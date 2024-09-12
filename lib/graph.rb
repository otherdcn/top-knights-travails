require_relative 'linked_list'

class Vertex
  include Comparable
  attr_accessor :data, :distance, :predecessor

  def initialize(data, predecessor)
    self.data = data
    self.predecessor = predecessor
  end

  def <=>(other)
    self.data <=> other.data
  end

  def traverse_predecessors(start_square, current_square = self, list = [])
    puts "Checking #{current_square.data} against #{start_square.data}..."
    if current_square == start_square
      list.unshift(current_square)
      return
    end

    list.unshift(current_square)
    traverse_predecessors(start_square, current_square.predecessor, list)

    list
  end
end

class Graph
  attr_accessor :adjacency_list

  def initialize
    self.adjacency_list = Hash.new
  end

  def add_vertex(key, data)
    vertex = Vertex.new(data, nil)
    edges =  LinkedList::Singly.new

    adjacency_list[key] = { vertex: vertex, edges: edges }

    key
  end

  def get_vertex(key)
    adjacency_list[key][:vertex]
  end

  def add_edge(source, target)
    raise StandardError, "Source vertex not present" unless adjacency_list.has_key? source
    raise StandardError, "Target vertex not present" unless adjacency_list.has_key? target
    return nil if nodes_connected?(source, target)

    adjacency_list[source][:edges].append(target) 
    adjacency_list[target][:edges].append(source)
  end

  def nodes_connected?(source, target)
    return if adjacency_list[source].nil?

    adjacency_list[source][:edges].contains(target)
  end

  def vertex(key)
    return if adjacency_list[key].nil?

    adjacency_list[key][:vertex]
  end

  def vertices
    adjacency_list.keys
  end

  def adjacent_vertices(key)
    return if adjacency_list[key].nil?

    list = adjacency_list[key][:edges].traverse[1]
    source_vertex = vertex(key)

    list.map do |list_key|
      target_vertex = vertex(list_key)
      target_vertex.predecessor = source_vertex
      target_vertex
    end
  end
end
