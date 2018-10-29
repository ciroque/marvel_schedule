defmodule MarvelSchedule.ScheduleData do
#  @data_reader MarvelSchedule.DataReader
  @data_reader Application.get_env(:marvel_schedule, :data_reader)

  NimbleCSV.define(LocalParser, separator: ",", escape: "\"")

  def data() do
    @data_reader.read()
    |> LocalParser.parse_string
    |> Enum.map(fn([title, order, release_date]) -> MarvelSchedule.Movie.new(title, order, release_date) end)
  end
end
