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

  test "Extend coordinate" do
    extent = {0, 0, 5, 5}
    assert(Geo.Extent.extendCoordinate(extent, {0, 10}) == {0, 0, 5, 10})
    assert(Geo.Extent.extendCoordinate(extent, {10, 0}) == {0, 0, 10, 5})
    assert(Geo.Extent.extendCoordinate(extent, {10, 10}) == {0, 0, 10, 10})
    assert(Geo.Extent.extendCoordinate(extent, {0, -10}) == {0, -10, 5, 5})
    assert(Geo.Extent.extendCoordinate(extent, {-10, 0}) == {-10, 0, 5, 5})
    assert(Geo.Extent.extendCoordinate(extent, {-10, -10}) == {-10, -10, 5, 5})
  end

  test "Extend coordinates" do
    extent = {0, 0, 5, 5}
    assert(Geo.Extent.extendCoordinates(extent, [{0, 10}, {0, -15}, {20, 0}]) == {0, -15, 20, 10})
  end

  test "From coordinates" do
    assert(Geo.Extent.fromCoordinates([{0, 10}, {0, -15}, {20, 0}]) == {0, -15, 20, 10})
  end

  test "From Point" do
    geo = %Geo.Point{ coordinates: {5, 8}}
    assert(Geo.Extent.fromGeo(geo) == {5, 8, 5, 8})
  end

  test "From LineString" do
    geo = %Geo.LineString{ coordinates: [{5, 8}, {10, 3}]}
    assert(Geo.Extent.fromGeo(geo) == {5, 3, 10, 8})
  end

  test "From MultiLineString" do
    geo = %Geo.MultiLineString{ coordinates: [[{5, 8}, {10, 3}], [{20, -4}, {30, 0}]]}
    assert(Geo.Extent.fromGeo(geo) == {5, -4, 30, 8})
  end

end
