class IEma
  # Irrugularly timed events series exponential moving average

  # 1) S_n = (1-a)*Y_n + a*S_n-1
  # 2) a = exp((t(n)-t(n-1))/G)
  # 3) S_t = S_t(n)*exp((t-t(n))/G)

  # where G is the smoothing coeficient, a the rate decay
  # Y_t, an event value at time t
  # Y_n, an event value at the time of event n
  # S_t, the EMA value at time t
  # S_n, the EMA value at the time of the event n
  # t(n), the time of the event n

  attr_reader :prev
  attr_reader :g
  attr_reader :tprev

  def initialize(g:)
    @g = g.to_f
  end

  def compute(current:, t:, prev: nil, tprev: nil)
    if tprev && prev
      alpha = a(t - tprev)
    elsif @tprev && @prev
      alpha = a(t - @tprev)
      prev = @prev
    else
      alpha = 0
      prev = 0
    end
    @tprev = t
    @prev = (1-alpha)*current + alpha*prev
  end

  def value(t:, tprev: nil, prev: nil)
      # 3) S_t = S_t(n)*exp((t-t(n))/G)
    if tprev && prev
    elsif @tprev && @prev
      tprev = @tprev
      prev = @prev
    else
      raise ArgumentError.new("There is no previous data and you did not provide any")
    end
    prev*a(t - tprev)
  end

  private
    def a(dt)
      a = Math.exp((-dt)/@g)
    end
end