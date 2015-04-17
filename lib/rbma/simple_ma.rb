class SimpleMa
  attr_reader :n
  attr_reader :empty
  attr_reader :lasts

  def initialize(n:, empty: "-")
    @n = n
    @empty = empty
    @lasts = []
  end

  def compute(current:, lasts: nil, empty: nil)
    if lasts.is_a?(Array)
      @lasts = lasts
      @empty = @empty ? @empty : empty
    end
    @lasts << current
    if @lasts.size > @n
      @lasts.last(5)
    end
    sum = 0
    @lasts.each{ |a| sum +=a }

    ma = (sum).to_f / @lasts.size

    if @lasts.size == @n
      ma
    else
      @empty
    end
  end

end
