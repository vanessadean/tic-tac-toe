class Human

  def initialize(game)
    @game = game
  end

  def move(x_or_o)
    puts "Where would you like to move?"
    move = coordinates(@game.board)
    @game.board[move] = x_or_o
  end

  def coordinates(board)
    move = gets.to_i
    while move < 1 or move > @game.side**2
      puts "That's not even on the board! Try again."
      move = gets.to_i
    end
    if @game.board[move-1].is_a?(String)
      puts "Already taken! Try again."
      move = gets.to_i
    end
    move -= 1
  end
end