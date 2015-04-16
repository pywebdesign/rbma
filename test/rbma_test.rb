require 'test_helper'

class RbmaTest < ActiveSupport::TestCase
  test "IEma recursive" do
    i = IEma.new(g: 60)
    i.compute(t: 0, current: 17)
    i.compute(t: 1, current: 15)
    i.compute(t: 3, current: 12)
    i.compute(t: 5, current: 11)
    i.compute(t: 9, current: 13)
    i.compute(t: 10, current: 15)
    i.compute(t: 13, current: 9)
    i.compute(t: 17, current: 8)
    i.compute(t: 19, current: 8)
    i.compute(t: 23, current: 7)
    i.compute(t: 29, current: 9)
    i.compute(t: 38, current: 10)
    i.compute(t: 49, current: 8)
    i.compute(t: 60, current: 6)
    i.compute(t: 80, current: 5)
    i.compute(t: 100, current: 8)
    i.compute(t: 150, current: 12)
    assert (i.compute(t: 152.88, current: 9)*100).round == 1070

  end
  test "IEma non recursive" do
    i = IEma.new(g: 60)
    i.compute(t: 0, current: 17)
    i.compute(t: 1, current: 15)
    prev = i.compute(t: 3, current: 12)
    j = IEma.new(g: 60)
    assert (j.compute(t: 5, current: 11, tprev: 3, prev: prev) * 100).round == 1661
  end

  test "IEma let you check value at t > tn" do
    i = IEma.new(g: 60)
    i.compute(t: 0, current: 17)
    i.compute(t: 1, current: 15)
    assert i.compute(t: 3, current: 12) == i.value(t:3)
    assert i.value(t:99999999).round == 0
  end
end
