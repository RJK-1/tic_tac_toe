class Board
  attr_reader :status, :win_rows

  def initialize
    @status = {
      '1' => 1,
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9 
    }
  end

  def print_board
    puts <<~HEREDOC
    +--------------------+
    |      |      |      |
    |  #{@status['1']}   |   #{@status['2']}  |   #{@status['3']}  |
    |______|______|______|
    |      |      |      |
    |  #{@status['4']}   |   #{@status['5']}  |   #{@status['6']}  |
    |______|______|______|
    |      |      |      |
    |  #{@status['7']}   |   #{@status['8']}  |   #{@status['9']}  |
    |      |      |      |
    +--------------------+
    HEREDOC
  end
end

class Player
  attr_reader :name, :sign
  def initialize(name, sign)
    @name = name
    @sign = sign
  end
end

class Game
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @player = ''
  end

  def display_board
    @board.print_board
  end

  def select_move(player)
    @player = player.name
    puts "#{player.name} select a square: "
    move = gets.chomp
    move_available?(player, move)
  end

  def move_available?(player, move)
    if @board.status["#{move}"] == 'X' || @board.status["pos#{move}"] == 'O'
      puts 'Square is already taken!'
      select_move
    else
      play_move(player, move)
    end
  end

  def play_move(player, move)
    @board.status["#{move}"] = player.sign
    display_board
    check_win(player)
  end

  def check_win(player)
    if @board.status['1'] == @board.status['2'] && @board.status['1'] == @board.status['3']
      puts "#{player.name} has won!"
    elsif @board.status['4'] == @board.status['5'] && @board.status['4'] == @board.status['6']
      puts "#{player.name} has won!"
    elsif @board.status['7'] == @board.status['8'] && @board.status['7'] == @board.status['9']
      puts "#{player.name} has won!"
    elsif @board.status['1'] == @board.status['4'] && @board.status['1'] == @board.status['7']
      puts "#{player.name} has won!"
    elsif @board.status['2'] == @board.status['5'] && @board.status['2'] == @board.status['8']
      puts "#{player.name} has won!"
    elsif @board.status['3'] == @board.status['6'] && @board.status['3'] == @board.status['9']
      puts "#{player.name} has won!"
    elsif @board.status['1'] == @board.status['5'] && @board.status['1'] == @board.status['9']
      puts "#{player.name} has won!"
    elsif @board.status['3'] == @board.status['5'] && @board.status['3'] == @board.status['7']
      puts "#{player.name} has won!"
    else
      change_player
    end
  end

  def change_player
    if @player[7] == '1'
      select_move(@player2)
    else
      select_move(@player1)
    end
  end
end

player1 = Player.new('Player 1', 'X')
player2 = Player.new('Player 2', 'O')
board = Board.new
game = Game.new(board, player1, player2)

game.display_board
game.select_move(player1)
