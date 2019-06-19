# inspiration for what to do once you have a nerves app with Inky as a dependency :)
{:ok, pid} = Inky.start_link(%{type: :phat, accent: :red})

pid = Process.whereis(InkySample)

painter = fn x, y, w, h, _pixels_so_far ->
  wh = w / 2
  hh = h / 2

  case {x > wh, y > hh} do
    {true, true} -> :red
    {false, true} -> if(rem(x, 2) == 0, do: :white, else: :black)
    {true, false} -> :black
    {false, false} -> :white
  end
end

Inky.set_pixels(pid, painter)

painter = fn x, y, w, h, pxs ->
  cond do
    x < w / 3 and (rem(y, 2) == 0 or rem(x, 2) == 1) -> :black
    x < w / 3 -> :white
    x < w / 3 * 2 and (rem(y, 2) == 0 or rem(x, 2) == 1) -> :black
    x < w / 3 * 2 -> :red
    rem(y, 2) == 0 or rem(x, 2) == 1 -> :white
    true -> :red
  end
end

Inky.set_pixels(pid, painter)

# Inky.show(pid)
