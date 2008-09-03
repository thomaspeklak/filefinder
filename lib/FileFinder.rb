# FileFinder - finds files in directory
#--
# $Author: tpesl $	
# $Revision: 616 $
# $LastChangedDate: 2008-04-10 10:48:13 +0200 (Thu, 10 Apr 2008) $
#++

require 'Find'
# finds files in a given path
# possible filters
# * types
# * includes
# * excludes
# * ignore_subdirectories
# * max_depth
#
# Example:
#   FileFinder::find('path',:types => ['.xml'],:exclusions => 't')
class FileFinder
	# Finds files in the given directory.
	# Arguments:
	# [path] directory to search for files
	# [types]  file types to include
	# [includes] array of strings a file name must contain
	# [excludes] array of strings a file name must not contain
	# [ignore_subdirectories] boolean, do not recursively search subdirectories
	# [max_depth] integer, maximum depth to descend in subdirectories
  def self.find(path, *config)
		if (config.empty?)
			types = exclusions = false
		else
			types, types_filter = filter_factory(config[0][:types])
			includes, includes_filter = filter_factory(config[0][:includes])
			excludes, excludes_filter = filter_factory(config[0][:excludes])
			ignore_directories, ignore_directories_filter = filter_factory(config[0][:ignore_directories])
			ignore_subdirectories = switch_factory(config[0][:ignore_subdirectories])
			max_depth, max_depth_value = integer_factory(config[0][:max_depth])
		end
    @files = Array.new
    Find.find(path) do |f|
			if ((ignore_subdirectories && FileTest.directory?(f) && f!='.' && f!=path) || (ignore_directories && FileTest.directory?(f) && File.basename(f) =~ /#{ignore_directories_filter}/i))
				Find.prune
			end
			if (max_depth && FileTest.directory?(f) && f.gsub(/^(..\/|.\/)*/,'')=~ /(.*\/){#{max_depth_value}}/)
				Find.prune
			end
      if FileTest.file?(f)
        if ((types && File.basename(f) =~ /#{types_filter}$/i) || !types) && ((includes && File.basename(f) =~ /#{includes_filter}/i) || !includes) 
          @files.push(f) unless excludes && File.basename(f) =~ /#{excludes_filter}/i
        end
      end
    end		
    @files
  end
	
	private
	def self.filter_factory(filter_array)
	    filter_string=''
	    filter_array.each { |fi| filter_string+="#{fi}|"} unless filter_array.nil?
			[!filter_array.nil? && !filter_array.empty? ,"(#{filter_string[0..-2]})"]
	end
	
	def self.switch_factory(switch)
		!switch.nil? && (switch == true || switch == 1)
	end
	def self.integer_factory(int)
		exists = !int.nil? && !int.empty?
		value = (exists)? int+1 : nil
		[exists,value]
	end
end