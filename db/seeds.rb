require "json"
require "rest-client"

response = RestClient.get "https://tmdb.lewagon.com/movie/top_rated"
repos = JSON.parse(response)['results']
repos_id_ten = repos.first(20)
puts 'Creating 20 movies...'

repos_id_ten.each do |movie|
  movie_url = "https://tmdb.lewagon.com/movie/#{movie['id'].to_s}"
  movie_response = RestClient.get(movie_url)
  movie_detail = JSON.parse(movie_response)

  movie = Movie.new(
    title: movie_detail['original_title'],
    overview: movie_detail['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_detail['poster_path']}",
    rating: movie_detail['vote_average']
  )
  movie.save!
end
puts 'Finished!'
