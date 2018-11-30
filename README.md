# MarvelSchedule

Run it by hand for the moment...

```elixir
MarvelSchedule.generate_viewing_schedule("2019-05-03") 
|> Tuple.to_list() 
|> Enum.at(0) 
|> MarvelScheduler.Formatters.VCalender.format() 
|> Stream.into(File.stream!("marvel-release-order.vcf", [:write, :utf8])) 
|> Stream.run
```
