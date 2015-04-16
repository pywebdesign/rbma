class NDayEma < Ema
  def initialize(n:)
    if n < 2
      warn "ATTENTION: N should probably be bigger thant 2."
    else
      a = 2.0/(n+1)
      super(a: a)
    end
  end
end