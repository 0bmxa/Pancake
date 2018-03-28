#!/usr/bin/env ruby

require 'xcodeproj'

# Get arguments
if ARGV.count < 1
    puts 'Usage: target_files.rb /path/to/myproject.xcodeproj MyTargetName [c|cpp|objc|swift]'
    exit 1
end

project_path = ARGV[0]
target_name = ARGV[1]
file_types = ARGV[2]

# Make sure first argument is a path to an xcode project
if not project_path or not project_path.end_with?('.xcodeproj')
    puts 'ERROR: arg1 is not a path to an .xcodeproj'
    exit 1
end

# Read project
project = Xcodeproj::Project.open(project_path)


# Prints all targets in a project
def print_targets(project)
    puts "Available targets are:"
    project.targets.each do |target|
        puts "  #{target.name}"
    end
    puts ""
end


# Make sure target is specified
if not target_name
    puts "ERROR: No target specified.\n"
    print_targets(project)
    exit 1
end


# Make sure target exists
target = project.targets.find{|t| t.name == target_name }
if not target
    puts "ERROR: Target '#{target_name}' not found.\n"
    print_targets(project)
    exit 1
end


# Get all header file names in target
# header_files = target.headers_build_phase.files.to_a.map do |build_file|
# 	build_file.file_ref.real_path.to_s
# end
#
# # Get all source file names in target
# source_files = target.source_build_phase.files.to_a.map do |build_file|
# 	build_file.file_ref.real_path.to_s
# end
#
# files = header_files.concat source_files

# files = target.headers_build_phase.files.to_a.map do |build_file|
# 	build_file.file_ref.real_path.to_s
# end.concat
# target.source_build_phase.files.to_a.map do |build_file|
# 	build_file.file_ref.real_path.to_s
# end

headers = target.headers_build_phase.files.to_a
sources = target.source_build_phase.files.to_a
files = (headers.concat sources).map do |build_file|
	build_file.file_ref.real_path.to_s
end


# Filter files by extension, if set
if file_types
    case file_types
    when 'c'
        files = files.select do |path|
            path.end_with?('.h', '.c')
        end

    when 'cpp'
        files = files.select do |path|
            path.end_with?('.h', '.hpp', '.c', '.cpp')
        end

    when 'objc'
        files = files.select do |path|
            path.end_with?('.h', '.hpp', '.c', '.cpp', '.m', '.mm')
        end

    when 'swift'
        files = files.select do |path|
            path.end_with?('.swift')
        end
    end
end

puts files
