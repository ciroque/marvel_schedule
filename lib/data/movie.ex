defmodule MarvelSchedule.Movie do
  @type t :: %__MODULE__{
    title: String.t(),
    order: integer,
    release_date: String.t()
  }

  defstruct [
    title: '',
    order: -1,
    release_date: ''
  ]

  def new(title, order, release_date) do
    %__MODULE__{title: title, order: order, release_date: release_date}
  end
end
