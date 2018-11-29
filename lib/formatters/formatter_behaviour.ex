defmodule MarvelSchedule.Formatters.FormatterBehaviour do
  @type movie_t :: MarvelSchedule.Movie.t()
  @callback format(movie_t) :: list(map())
end
