defmodule MarvelSchedule do

  require Logger

  def generate_viewing_schedule(target_date) do
    prepare_list()
    |> calculate_with_date(target_date)
  end

  defp prepare_list() do
    MarvelSchedule.ScheduleData.data()
    |> Enum.sort_by(&(Integer.parse(&1.order)))
    |> Enum.reverse()
  end

  defp calculate_with_date(list, target_date) do
  {:ok, date} = Timex.parse(target_date, "{YYYY}-{0M}-{D}")
    list
    |> Enum.map_reduce(date, fn entry, date -> compose_schedule_entry(entry, date) end)
  end

  defp compose_schedule_entry(entry, date) do
    {:ok, viewing_date} = Timex.format(date, "{YYYY}-{0M}-{D}")
    {
      %{
        title: entry.title,
        release_date: entry.release_date,
        viewing_date: viewing_date,
        order: String.to_integer(entry.order)
      },
      Timex.shift(date, weeks: -1)
    }
  end
end
