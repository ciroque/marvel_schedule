defmodule MarvelScheduler.Formatters.VCalender do
  @behaviour MarvelSchedule.Formatters.FormatterBehaviour

  defmodule VEvent do
    @type t :: %__MODULE__{
      description: String.t(),
      start_at: String.t(),
      end_at: String.t(),
      created_at: String.t()
    }

    defstruct [
      description: '',
      start_at: '',
      end_at: '',
      created_at: ''
    ]

    def new(description, start_at) do
      new(description, start_at, '')
    end

    def new(description, start_at, end_at) do
      {:ok, created_at} = Timex.now() |> Timex.format("{YYYY}{0M}{0D}T{h24}{m}{s}")
      %__MODULE__{description: description, start_at: start_at, end_at: end_at, created_at: created_at}
    end
  end

  defimpl String.Chars, for: VEvent do
    def to_string(vevent) do
      "BEGIN:VEVENT
UID:#{UUID.uuid1()}
DTSTAMP:#{vevent.created_at}
CATEGORIES:MCU,Marvel,Avengers
STATUS:CONFIRMED
SUMMARY:Marvel Universe Movie: #{vevent.description}
DESCRIPTION:#{vevent.description}
CLASS:PUBLIC
DTSTART:#{vevent.start_at}
END:VEVENT
"
    end
  end

  defmodule VCal do
    @preamble "BEGIN:VCALENDAR"
    @version "VERSION:1.0"
    @epilogue "END:VCALENDAR"

    @type t :: %__MODULE__{
      preamble: String.t(),
      version: String.t(),
      events: list(VEvent.t()),
      epilogue: String.t()
    }

    defstruct [
      preamble: '',
      version: '',
      events: [],
      epilogue: ''
    ]

    def new(events) do
      %__MODULE__{preamble: @preamble, version: @version, events: events, epilogue: @epilogue}
    end
  end

  defimpl String.Chars, for: VCal do
    def to_string(vcal) do
      "#{vcal.preamble}
#{vcal.version}
#{vcal.events}
#{vcal.epilogue}
"
    end
  end

  def format(list) do
    events = list
#    |> Enum.reverse
    |> Enum.map(fn event -> VEvent.new(event.title, event.viewing_date) end)
    |> Enum.map(fn vevent -> to_string(vevent) end)

    with_epilogue = Enum.reverse(["END:VCALENDAR\n" | events])

    with_version = ["VERSION:2.0\n" | with_epilogue]

    with_prodid = ["PRODID:#{__MODULE__}\n" | with_version]

    ["BEGIN:VCALENDAR\n" | with_prodid]
  end
end
