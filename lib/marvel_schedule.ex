defmodule MarvelSchedule do

  require Logger

  def generate_viewing_schedule(_target_date) do
    MarvelSchedule.ScheduleData.data()
    |> Enum.sort_by(&(&1.order))
    |> Enum.reverse()
    |> Enum.map(fn movie -> Logger.info(">>> #{inspect(movie)}}") end)
  end
end
