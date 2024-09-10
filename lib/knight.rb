require_relative 'queue'

class Square
  include Comparable
  attr_accessor :coord, :distance, :predecessor

  def initialize(coord, distance, predecessor)
    self.coord = coord
    self.distance = distance
    self.predecessor = predecessor
  end

  def <=>(other)
    self.coord <=> other.coord
  end

  def traverse_predecessors(square = self, list = [])
    return if square.nil?

    list.unshift(square)
    traverse_predecessors(square.predecessor, list)

    list
  end
end

class Knight
  attr_accessor :moves

  def initialize
    self.moves = {
      up_left: [2, -1],
      up_right: [2, 1],
      left_up: [1, -2],
      right_up: [1, 2],
      left_down: [-1, -2],
      right_down: [-1, 2],
      down_left: [-2, -1],
      down_right: [-2, 1]
    }
  end

  def knight_moves(start_coord, end_coord)
    start_square = Square.new(start_coord, 0, nil)
    end_square = Square.new(end_coord, nil, nil)

    legal_squares = Queue.new
    squares = generate_legal_squares(start_square)
    squares.each { |square| legal_squares.enqueue square  }

    visited_squares = { start_square => true }
    current_square = nil

    until legal_squares.empty?
      current_square = legal_squares.dequeue

      next if visited_squares[current_square]
      visited_squares[current_square] = true

      break if current_square == end_square

      squares = generate_legal_squares(current_square)
      squares.each { |square| legal_squares.enqueue square  }
    end

    current_square.traverse_predecessors
  end

  def generate_legal_squares(current_square)
    squares = []

    moves.each do |_, coord|
      rank = current_square.coord[0] + coord[0]
      file = current_square.coord[1] + coord[1]

      next unless move_legal?(rank) && move_legal?(file)
      coord = [rank, file]
      distance = current_square.distance + 1
      predecessor = current_square

      square = Square.new(coord, distance, predecessor)
      squares << square
    end

    squares
  end

  def move_legal?(value, board_sqroot_size = 8)
    value >= 0 && value < board_sqroot_size
  end
end

