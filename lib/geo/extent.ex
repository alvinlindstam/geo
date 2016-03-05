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

end
