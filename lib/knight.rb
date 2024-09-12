require_relative 'queue'
require_relative 'graph'

class Knight
  attr_accessor :graph, :board_size

  MOVES = {
    up_left: [2, -1],
    up_right: [2, 1],
    left_up: [1, -2],
    right_up: [1, 2],
    left_down: [-1, -2],
    right_down: [-1, 2],
    down_left: [-2, -1],
    down_right: [-2, 1]
  }

  def initialize(board_size = 8)
    self.graph = Graph.new
    self.board_size = board_size

    add_board_positions(board_size)
    add_possible_movements_per_board_positions(board_size)
  end

  def add_board_positions(board_size)
    board_size.times do |row|
      board_size.times do |col|
        square_coord = [row, col]
        square_id = gen_square_id(square_coord, board_size)
        graph.add_vertex(square_id, square_coord)
      end
    end
  end

  def add_possible_movements_per_board_positions(board_size)
    board_size.times do |row|
      board_size.times do |col|
        square_coord = [row, col]
        square_id = gen_square_id(square_coord, board_size)
        squares = generate_legal_squares(square_coord)

        squares.each do |target_coord|
          target_id = gen_square_id(target_coord, board_size)
          graph.add_edge(square_id, target_id)
        end
      end
    end
  end

  def gen_square_id(coord, size = board_size)
    (coord[0] * size) + coord[1]
  end

  def generate_legal_squares(current_square)
    squares = []

    MOVES.each do |_, coord|
      file = current_square[0] + coord[0]
      rank = current_square[1] + coord[1]

      next unless move_legal?([rank, file])
      squares << [file, rank]
    end

    squares
  end

  def knight_moves(start_coord, end_coord)
    start_square_id = gen_square_id(start_coord)
    start_square = graph.vertex(start_square_id)

    end_square_id = gen_square_id(end_coord)
    end_square = graph.vertex(end_square_id)

    return [start_square] if start_square_id == end_square_id

    legal_squares = Queue.new
    squares = graph.adjacent_vertices(start_square_id)
    squares.each { |square| legal_squares.enqueue square  }

    visited_squares = { start_square => true }
    current_square = nil

    until legal_squares.empty?
      current_square = legal_squares.dequeue
      current_square_id = gen_square_id(current_square.data)

      next if visited_squares[current_square]
      visited_squares[current_square] = true

      break if current_square == end_square

      squares = graph.adjacent_vertices(current_square_id)
      squares.each { |square| legal_squares.enqueue square  }
    end

    current_square.traverse_predecessors(start_square)
  end

  def move_legal?(coord, size = board_size)
    coord.all? { |point| point.between?(0, size - 1) }
  end
end

