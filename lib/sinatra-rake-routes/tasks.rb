desc "Print out all defined routes"
task :routes do
  SinatraRakeRoutes.app_class.routes.each do |http_method, routes_list|
    puts http_method
    routes = []
    routes_list.each do |item|
      source = item[0].source
      item[1].each do |s|
        source.sub!(/\(.+?\)/, ':'+s)
      end
      routes << source[1...-1]
    end
    puts routes.sort.join("\n")
    puts "\n"
  end
end

if Rake::Task.task_defined?("configure_routes")
  Rake::Task["routes"].enhance(["configure_routes"])
end
