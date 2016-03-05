defmodule Geo.Extent.Test do
  use ExUnit.Case, async: true

  test "Completey enclosed" do
    extent1 = {0, 0, 10, 10}
    extent2 = {2, 4, 3, 6}
    assert(Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == extent1)
  end

  test "Separate on x axis" do
    extent1 = {0, 0, 10, 10}
    extent2 = {20, 4, 30, 6}
    assert(!Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == {0, 0, 30, 10})
  end

  test "Separate on y axis" do
    extent1 = {0, 0, 10, 10}
    extent2 = {2, 40, 3, 60}
    assert(!Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == {0, 0, 10, 60})
  end

  test "Separate on both axis" do
    extent1 = {0, 0, 10, 10}
    extent2 = {20, 40, 30, 60}
    assert(!Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == {0, 0, 30, 60})
  end

  test "Shared border X" do
    extent1 = {0, 0, 10, 10}
    extent2 = {10, 4, 30, 6}
    assert(Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == {0, 0, 30, 10})
  end

  test "Shared border Y" do
    extent1 = {0, 0, 10, 10}
    extent2 = {2, 10, 30, 60}
    assert(Geo.Extent.intersects?(extent1, extent2))
    assert(Geo.Extent.extend(extent1, extent2) == {0, 0, 30, 60})
  end

end
