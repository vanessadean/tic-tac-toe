class Computer

  def initialize(game)
    @game = game
  end

  def move(x_or_o)
    puts "Computer move"
    if x_or_o == "X"
      move = coordinates_for_x
    else
      move = coordinates_for_o
    end
    @game.board[move] = x_or_o
  end

  def coordinates_for_x
    if @game.board[0].is_a?(Integer)
      0
    elsif @game.board[4].is_a?(Integer)
      4
    elsif !@game.board[5].is_a?(Integer) && @game.board[8].is_a?(Integer)
      8
    elsif !@game.board[1].is_a?(Integer) && @game.board[2].is_a?(Integer)
      2
    elsif !@game.board[3].is_a?(Integer) && @game.board[6].is_a?(Integer)
      6
    elsif @game.board[1].is_a?(Integer)
      1 
    elsif @game.board[3].is_a?(Integer)
      3
    elsif @game.board[5].is_a?(Integer)
      5
    elsif @game.board[7].is_a?(Integer)
      7
    else
      @game.board.select { |i| i.is_a?(Integer) }.sample
    end
  end  

  def coordinates_for_o
    if @game.board[4].is_a?(Integer)
      4
    elsif @game.board[3].is_a?(Integer) && !@game.board[5].is_a?(Integer)
      3
    elsif @game.board[5].is_a?(Integer) && !@game.board[3].is_a?(Integer)
      5
    elsif !@game.board[1].is_a?(Integer) && @game.board[2].is_a?(Integer)
      2
    elsif !@game.board[3].is_a?(Integer) && @game.board[6].is_a?(Integer)
      6
    elsif !@game.board[5].is_a?(Integer) && @game.board[8].is_a?(Integer)
      8
    elsif @game.board[2].is_a?(Integer)
      2
    elsif @game.board[7].is_a?(Integer)
      7
    else
      @game.board.select { |i| i.is_a?(Integer) }.sample
    end
  end
end