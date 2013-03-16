require 'FileUtils'

task :default do |t|
  Dir.mkdir 'gemdocs' rescue nil
  docs = Dir['gems/*'].map do |i| File.basename i end
  docs.each do |i|
    Dir.chdir("gems/#{i}")
    system("sdoc --op=../../gemdocs/#{i} --debug")
    Dir.chdir("../..")
  end
  FileUtils.rm_r "doc" rescue nil
  system("sdoc-merge --op doc " << docs.map{|i|"gemdocs/#{i}"}.join(" "))
end