require 'active_support/core_ext'
require './human.rb'
require './computer.rb'

class Game
  attr_accessor :board, :side

  def initialize
    puts "Let's play Tic Tac Toe!"
    set_up_game
  end

  def set_up_game
    get_players
    create_board
    play_game
  end

  def get_players
    puts "Would you like to play against a human or the computer? (Type h or c.)"
    opponent = gets.downcase[0]
    if !["h","c"].include?(opponent)
      puts "That is not a valid choice. Please try again"
      get_players
    end
    if opponent == "h"
      @player1 = Human.new(self) 
      @player2 = Human.new(self)
    else
      choice = rand(2)
      if choice == 0
        @player1 = Computer.new(self)
        @player2 = Human.new(self)
      else
        @player1 = Human.new(self)
        @player2 = Computer.new(self)
      end
    end 
  end

  def play_game
    @turn = 0
    @winner = false
    while @winner == false
      if @turn == @side**2 
        print_board
        puts "It's a tie!"
        play_again
      else
        print_board
        get_moves
        @turn += 1
      end
    end
  end

  def get_moves
    puts "Player #{(@turn%2)+1}"
    if @turn % 2 == 0 
      @player1.move("X")
    else
      @player2.move("O")
    end
   check_for_winner
  end

  def check_for_winner
    board = @board.in_groups_of(side)
    @tally = 1
    if vertical_win?(board) || horizontal_win?(board) || diagonal_win?(board)
      @winner = true
      print_board
      puts "Player #{(@turn%2)+1} wins!"
      play_again
    end
  end

  def vertical_win?(board)
    (0...@side).each do |x|
      (0...(@side-1)).each do |y|     
        @tally += 1 if board[y][x] == board[y+1][x]
      end
      if @tally == @side 
        return true
      else 
        @tally = 1
      end    
    end
    return false
  end

  def horizontal_win?(board)
    (0...@side).each do |y|
      (0...(@side-1)).each do |x|   
        @tally += 1 if board[y][x] == board[y][x+1]
      end
      if @tally == @side 
        return true
      else 
        @tally = 1
      end
    end
    return false
  end

  def diagonal_win?(board)
    (0...(@side-1)).each do |i|
      @tally += 1 if board[i][i] == board[i+1][i+1]
    end
    if @tally == @side 
      return true
    else 
      @tally = 1
    end
    (0...(@side-1)).each do |i|
      @tally += 1 if board[@side-1*(i+1)][i] == board[@side-1*(i+2)][i+1]
      puts @tally
    end
    if @tally == @side 
      return true
    else 
      @tally = 1
    end
    false
  end

  def create_board
    puts "How big would you like the board to be? (Type 3 for 3x3, 4 for 4x4, etc.)"
    @side = gets.strip[0].to_i
    if @side <= 0
      puts "That is not a valid board size. Please try again.\n\n"
      create_board
    end    
    @board = (1..@side**2).to_a
  end

  def print_board
    board = @board.in_groups_of(side)
    printed_board = "\n"
    board.each_with_index do |row, i|
      row.each do |char|
        printed_board += char.to_s.rjust(@side**2.to_s.length, " ")
      end
      printed_board += "\n\n" 
    end
    puts printed_board
  end

  def play_again
    puts "Play again? y/n"
    again = gets.downcase[0]
    again == "y" ? set_up_game : exit
  end

  def exit
    puts "Thanks for playing!"
  end
end

new_game = Game.new
