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
  end

  def generate_legal_squares(start_square)
  end

  def move_legal?()
  end
end

