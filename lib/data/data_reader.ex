defmodule MarvelSchedule.DataReader do
  @moduledoc false

  def read() do
    Application.app_dir(:marvel_schedule, ["priv", "movies.csv"])
    |> File.read!
  end
end
