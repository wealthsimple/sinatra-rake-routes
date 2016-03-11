desc "Print out all defined routes"
task :routes do
  puts SinatraRakeRoutes.new.to_s
end

if Rake::Task.task_defined?("configure_routes")
  Rake::Task["routes"].enhance(["configure_routes"])
end
