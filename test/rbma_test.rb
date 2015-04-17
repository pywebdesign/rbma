require 'test_helper'

class RbmaTest < ActiveSupport::TestCase
  test "Ema recursive" do
    e = Ema.new(a: 0.3)
    e.compute(current: 11)
    e.compute(current: 13)
    e.compute(current: 15)
    e.compute(current: 9)
    e.compute(current: 8)
    e.compute(current: 8)
    e.compute(current: 7)
    e.compute(current: 9)
    assert (e.compute(current: 10)*1000).round == 9257
  end
  test "Ema non recursive" do
    e = Ema.new(a: 0.3)
    e.compute(current: 11)
    e.compute(current: 13)
    e.compute(current: 15)
    e.compute(current: 9)
    e.compute(current: 8)
    e.compute(current: 8)
    e.compute(current: 7)
    d = e.compute(current: 9)
    e = Ema.new(a: 0.3)
    assert (e.compute(current: 10, previous: d)*1000).round == 9257
  end

  test "NDayEma" do
    days = 6
    n = NDayEma.new(n: days)
    assert n.a == 2.0/(days+1)
  end

  test "SimpleMa recursive" do
    s = SimpleMa.new(n: 5, empty: "-")
    assert s.compute(current: 2) == "-"
    s.compute(current: 3)
    s.compute(current: 5)
    s.compute(current: 3)
    assert s.compute(current: 3) == 3.2
  end

  test "SimpleMa non recursive" do
    s = SimpleMa.new(n: 5, empty: "-")
    assert s.compute(current: 2) == "-"
    s.compute(current: 3)
    s.compute(current: 5)
    s.compute(current: 3)
    lasts = s.lasts
    s = SimpleMa.new(n: 5, empty: "-")
    assert s.compute(current: 3, lasts: lasts ) == 3.2
  end

  test "Cma recursive" do
    c = Cma.new()
    c.compute(current: 1)
    c.compute(current: 2)
    c.compute(current: 21)
    c.compute(current: 10)
    c.compute(current: 31)
    c.compute(current: 28)
    c.compute(current: 5)
    assert c.compute(current: 2) == 12.5
  end


  test "Cma non recursive" do
    c = Cma.new()
    c.compute(current: 1)
    c.compute(current: 2)
    c.compute(current: 21)
    c.compute(current: 10)
    c.compute(current: 31)
    c.compute(current: 28)
    d = c.compute(current: 5)
    c = Cma.new()
    assert c.compute(current: 2, last: d, count: 7) == 12.5
  end
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
