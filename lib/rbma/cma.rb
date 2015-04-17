class Cma
  attr_reader :count
  attr_reader :last
  attr_reader :current

  def compute(current:, last: nil, count: nil)
    if last && count
      @last = (last*count + current).to_f
      @current = @last/ (count + 1)
    elsif last == nil && count == nil
      @count = @count ? @count + 1 : 1
      @last  = @last  ? @last : 0
      @last = (@last + current)
      @current = @last.to_f/@count
    end
  end
end