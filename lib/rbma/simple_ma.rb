class SimpleMa
  attr_reader :n
  attr_reader :empty
  attr_reader :lasts

  def initialize(n:, empty: "-")
    @n = n
    @empty = empty
    @lasts = []
    @count = 0
  end

  def compute(current:, count: nil, lasts: nil, empty: nil)
    @count +=1
    @lasts << current

    if lasts.is_a?(Array) && count
      @lasts = lasts
      @count = count
      @empty = @empty ? @empty : empty
    end

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
