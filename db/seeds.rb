require 'json'
require 'net/http'
require 'uri'

puts 'Creating 20 movies...'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer YOUR_ACCESS_TOKEN' # Remplacez YOUR_ACCESS_TOKEN par votre token d'accès

response = http.request(request)
repos = JSON.parse(response.body)['results']
repos_id_ten = repos.first(20)

repos_id_ten.each do |movie|
  movie_detail = movie

  movie = Movie.new(
    title: movie_detail['original_title'],
    overview: movie_detail['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_detail['poster_path']}",
    rating: movie_detail['vote_average']
  )
  movie.save!
end

puts 'Finished!'
