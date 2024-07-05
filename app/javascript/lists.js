// app/assets/javascripts/lists.js

$(document).ready(function() {
  $('#addMovieButton').on('click', function(e) {
    e.preventDefault(); // Empêche le comportement par défaut du lien

    // Toggle visibility of movie list
    $('#movieList').toggle();

    // Load movies only if the list is visible
    if ($('#movieList').is(':visible')) {
      // Make an AJAX request to fetch movies
      $.ajax({
        url: '<%= movies_path %>', // Assurez-vous que cette URL correspond à votre route pour récupérer les films
        method: 'GET',
        dataType: 'json',
        success: function(response) {
          // Clear existing content
          $('#movieList').empty();

          // Append mini cards for each movie
          response.forEach(function(movie) {
            var miniCard = `
              <div class="col-md-3 mb-4">
                <div class="card">
                  <img src="${movie.poster_url}" class="card-img-top">
                  <div class="card-body">
                    <h5 class="card-title">${movie.title}</h5>
                    <p class="card-text">${truncate(movie.overview, { length: 100 })}</p>
                    <button class="btn btn-success add-to-list" data-movie-id="${movie.id}">Add to List</button>
                  </div>
                </div>
              </div>
            `;
            $('#movieList').append(miniCard);
          });

          // Attach click event handler to Add to List buttons
          $('.add-to-list').on('click', function() {
            var movieId = $(this).data('movie-id');
            addToMovieList(movieId);
          });
        },
        error: function(error) {
          console.error('Error fetching movies:', error);
        }
      });
    }
  });

  // Function to add movie to the list
  function addToMovieList(movieId) {
    $.ajax({
      url: '<%= list_bookmarks_path(@list) %>', // Assurez-vous que cette URL correspond à votre route pour ajouter un bookmark à la liste
      method: 'POST',
      dataType: 'json',
      data: { movie_id: movieId },
      success: function(response) {
        // Handle success (optional)
        console.log('Movie added to list:', response);
      },
      error: function(error) {
        console.error('Error adding movie to list:', error);
      }
    });
  }
});
