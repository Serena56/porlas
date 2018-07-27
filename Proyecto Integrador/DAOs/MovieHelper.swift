
class MovieHelper{
    private static let apiKey = "db898f2be5d80aee6fee0407b549ec39"
    private static let baseUrl = "https://api.themoviedb.org/3"

    //IDIOMAS
    public static let language_ENGLISH = "en-US"
    public static let language_SPANISH = "es-ES"

    //IMAGENES
    public static let IMAGE_SIZE_W45 = "w45"
    public static let IMAGE_SIZE_W92 = "w92"
    public static let IMAGE_SIZE_W154 = "w154"
    public static let IMAGE_SIZE_W185 = "w185"
    public static let IMAGE_SIZE_W300 = "w300"
    public static let IMAGE_SIZE_W342 = "w342"
    public static let IMAGE_SIZE_W780 = "w780"
    public static let IMAGE_SIZE_W1280 = "w1280"
    public static let IMAGE_SIZE_ORIGINAL = "original"
    public static let IMAGE_SIZE_H632 = "h632"

    //CATEGORIAS PELICULAS
    public static let MOVIE_GENRE_ACTION = "28"
    public static let MOVIE_GENRE_ADVENTURE = "12"
    public static let MOVIE_GENRE_ANIMATION = "16"
    public static let MOVIE_GENRE_COMEDY = "35"
    public static let MOVIE_GENRE_CRIME = "80"
    public static let MOVIE_GENRE_DOCUMENTARY = "99"
    public static let MOVIE_GENRE_DRAMA = "18"
    public static let MOVIE_GENRE_FAMILY = "10751"
    public static let MOVIE_GENRE_FANTASY = "14"
    public static let MOVIE_GENRE_HISTORY = "36"
    public static let MOVIE_GENRE_HORROR = "27"
    public static let MOVIE_GENRE_MUSIC = "10402"
    public static let MOVIE_GENRE_MYSTERY = "9648"
    public static let MOVIE_GENRE_ROMANCE = "10749"
    public static let MOVIE_GENRE_SCIENCE_FICTION = "878"
    public static let MOVIE_GENRE_SCIENCE_TV_MOVIE = "10770"
    public static let MOVIE_GENRE_SCIENCE_THRILLER = "53"
    public static let MOVIE_GENRE_SCIENCE_WAR = "10752"
    public static let MOVIE_GENRE_SCIENCE_WESTERN = "37"

    //CATEGORIAS SERIES
    public static let TV_GENRE_ACTION_AND_ADVENTURE = "10759"
    public static let TV_GENRE_ANIMATION = "16"
    public static let TV_GENRE_COMEDY = "35"
    public static let TV_GENRE_CRIME = "80"
    public static let TV_GENRE_DOCUMENTARY = "99"
    public static let TV_GENRE_DRAMA = "18"
    public static let TV_GENRE_FAMILY = "10751"
    public static let TV_GENRE_KIDS = "10762"
    public static let TV_GENRE_MYSTERY = "9648"
    public static let TV_GENRE_NEWS = "10763"
    public static let TV_GENRE_REALITY = "10764"
    public static let TV_GENRE_SCI_FI_AND_FANTASY = "10765"
    public static let TV_GENRE_FANTASY = "14"
    public static let TV_GENRE_HISTORY = "36"
    public static let TV_GENRE_HORROR = "27"
    public static let TV_GENRE_MUSIC = "10402"
    public static let TV_GENRE_ROMANCE = "10749"

    public static func getMovieDetailURL(movieID: String, language: String) -> String{
        return baseUrl + "/movie/" + movieID + "?api_key=" + apiKey + "&language=" + language
    }

    public static func getTrailerURL(movideID: String, language: String) -> String{
        return baseUrl + "/movie/" + movideID + "/videos?api_key=" + apiKey + "&language=" + language
    }

    public static func getMoviesRecomended(movideID: String, language: String, page: Int) -> String{
        return baseUrl + "/movie/" + movideID + "/recomendations?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getSimilarMovies(movideID: String, language: String, page: Int) -> String{
        return baseUrl + "/movie/" + movideID + "/similar?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getMoviesReviews(movideID: String, language: String, page: Int) -> String{
        return baseUrl + "/movie/" + movideID + "/reviews?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getMoviePlayList(movideID: String, language: String, page: Int) -> String{
        return baseUrl + "/movie/" + movideID + "/lists?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getLastestMovie(language: String, page: Int)-> String{
        return baseUrl + "/movie/" + "latest?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getNowPlayingMovies(language: String, page: Int) -> String{
        return baseUrl + "/movie/" + "now_playing?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getPopularMovies(language: String, page: Int) -> String{
        return baseUrl + "/movie/" + "popular?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getBestMoviesOfSpecificYear(language: String, specificYear: String, page: Int) -> String{
      return baseUrl + "/discover/movie" + "?api_key=" + apiKey + "&primary_release_year=" + specificYear +
                "&sort_by=vote_average.desc&language=" + language + "&page=" + "\(page)"
    }

    public static func getHighestGrossingMovies(language: String, page: Int, specificYear: String) -> String{
        return baseUrl + "/discover/movie?api_key=" + apiKey + "&sort_by=revenue.desc" + "&primary_release_year=" + specificYear +
                "&language=" + language + "&page=" + "\(page)"
    }

    public static func getTopRatedMovies(language: String, page: Int) -> String{
        return baseUrl + "/discover/movie/" + "?api_key=" + apiKey + "&sort_by=vote_average.desc&language=" + language + "&page=" + "\(page)"
    }

    public static func getUpcomingMovies(language: String, page: Int) -> String{
        return baseUrl + "/movie/" + "upcoming?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getImagePoster(size: String, imagePath: String) -> String{
        return "https://image.tmdb.org/t/p/" + size + imagePath
    }

    public static func getAllGenres(language: String) -> String{
        return baseUrl + "/genre/list?api_key=" + apiKey + "&language=" + language
    }

    public static func getMoviesByGenre(genre: String, page: Int, language: String) -> String{
        return baseUrl + "/discover/movie?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)" + "&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_genres=" + genre
    }

    public static func getTVByGenre(genre: String, page: Int, language: String) -> String{
        return baseUrl + "/discover/tv?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)" + "&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_genres=" + genre + "&include_null_first_air_dates=false"
    }

    public static func getTVShowDetail(tvShow: String, language: String) -> String{
        return baseUrl + "/tv/" + tvShow + "?api_key=" + apiKey + "&language=" + language
    }

    public static func getTVShowRecomendedForTVShow(tvShow: String, language: String, page: Int) -> String{
        return baseUrl + "/tv/" + tvShow + "/recomendations?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getTVPopular(language: String, page: Int) -> String{
        return baseUrl + "/tv/popular?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getTVTopRated(language: String, page: Int) -> String{
        return baseUrl + "/tv/on_the_air?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }

    public static func getTVShowVideo(language: String, tvShowId: String) -> String{
        return baseUrl + "/tv/" + tvShowId + "/videos?api_key=" + apiKey + "&language=" + language
    }

    public static func getTVSeasonDetail(tvShowId: String, season: Int, language: String) -> String{
        return baseUrl + "/tv/" + tvShowId + "/season/" + "\(season)" + "?api_key=" + apiKey + "&language=" + language
    }

    public static func getTVEpisodeDetail(tvShowId: String, season: Int, language: String) -> String{
        return baseUrl + "/tv/" + tvShowId + "/season/" + "\(season)" + "?api_key=" + apiKey + "&language=" + language
    }
    public static func getTVAiringToday(language: String, page: Int) -> String{
        return baseUrl + "/tv/airing_today?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)"
    }
    
    
    public static func getMoviesGender(lenguage: String) -> String{
        return baseUrl + "/genre/movie/list?api_key=" + apiKey + "&lenguage=" + lenguage
    }
    
    public static func getSeriesGender(lenguage: String) -> String{
        return baseUrl + "/genre/tv/list?api_key=" + apiKey + "&language=" + lenguage
    }
    


}
