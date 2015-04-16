class Ema
  # S_t = \alpha*Y_t+(1-\alpha)*S_(t-1)
  attr_reader :a

  attr_reader :last

  def initialize(a:)
    puts a
    @a = a
  end

  def compute(current:, previous: nil)
    if previous
      @last = @a*current+(1-@a)*previous
    elsif @last
      @last = @a*current+(1-@a)*@last
    else
      @last = current
    end
  end

  def to_s
    "#{@last}"
  end
end