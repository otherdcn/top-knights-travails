require_relative 'queue'

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

  def knight_moves(start_square, end_square)
    legal_squares = generate_legal_squares(Queue.new, start_square)
    visited_squares = { start_square => true }
    path = [start_square]
    current_square = nil

    puts "Possible moves from #{start_square}: "
    legal_squares.traverse(legal_squares.head_node)
  end

  def generate_legal_squares(queue, start_square)
    moves.each do |move, coord|
      new_y = start_square[0] + coord[0]
      new_x = start_square[1] + coord[1]

      queue.enqueue([new_y, new_x]) if move_legal?(new_y) && move_legal?(new_x)
    end

    queue
  end

  def move_legal?(value, board_sqroot_size = 8)
    value >= 0 && value < board_sqroot_size
  end
end

