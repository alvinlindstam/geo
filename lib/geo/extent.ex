defmodule Geo.Extent do

  @moduledoc """
  Defines helpers for extents. Extents are expected to be tuples of 4: {minX, minY, maxX, maxY}
  """

  @type t :: {number, number, number, number}

  @spec intersects?(t, t) :: boolean
  def intersects?({minX, _, _, _}, {_, _, maxX, _}) when minX > maxX, do: false
  def intersects?({_, _, maxX, _}, {minX, _, _, _}) when minX > maxX, do: false
  def intersects?({_, minY, _, _}, {_, _, _, maxY}) when minY > maxY, do: false
  def intersects?({_, _, _, maxY}, {_, minY, _, _}) when minY > maxY, do: false
  def intersects?({_, _, _, _}, {_, _, _, _}), do: true

  @spec extend(t, t) :: t
  def extend({minX1, minY1, maxX1, maxY1}, {minX2, minY2, maxX2, maxY2}) do
    {
      Kernel.min(minX1, minX2),
      Kernel.min(minY1, minY2),
      Kernel.max(maxX1, maxX2),
      Kernel.max(maxY1, maxY2)
    }
  end

  @spec extendCoordinate(t, {number, number}) :: t
  def extendCoordinate({minX, minY, maxX, maxY}, {coordX, coordY}) do
    {
      Kernel.min(minX, coordX),
      Kernel.min(minY, coordY),
      Kernel.max(maxX, coordX),
      Kernel.max(maxY, coordY)
    }
  end

  @spec extendCoordinates(t, [{number, number}]) :: t
  def extendCoordinates(extent, []), do: extent
  def extendCoordinates(extent, [h|t]) do
    extendCoordinates(extendCoordinate(extent, h), t)
  end

end
