desc "Print out all defined routes"
task :routes do
  puts SinatraRakeRoutes.output
end

if Rake::Task.task_defined?("configure_routes")
  Rake::Task["routes"].enhance(["configure_routes"])
end
