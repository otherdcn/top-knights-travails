require_relative "linked_list"

class Vertex
  include Comparable
  attr_accessor :data, :colour, :distance, :predecessor

  def initialize(data)
    self.data = data
    self.colour = :white
    self.distance = nil
    self.predecessor = nil
  end

  def <=>(other)
    data <=> other.data
  end

  def shortest_path(square = self, list = [])
    return if square.nil?

    list.unshift(square)
    shortest_path(square.predecessor, list)

    list
  end
end

class Graph
  attr_accessor :adjacency_list

  def initialize
    self.adjacency_list = ({})
  end

  def add_vertex(key, data)
    vertex = Vertex.new(data)
    edges =  LinkedList::Singly.new

    adjacency_list[key] = { vertex: vertex, edges: edges }

    key
  end

  def get_vertex(key)
    adjacency_list[key][:vertex]
  end

  def add_edge(source, target)
    raise StandardError, "Source vertex not present" unless adjacency_list.key? source
    raise StandardError, "Target vertex not present" unless adjacency_list.key? target
    return nil if vertices_connected?(source, target)

    adjacency_list[source][:edges].append(target)
    adjacency_list[target][:edges].append(source)
  end

  def vertices_connected?(source, target)
    return false if adjacency_list[source].nil?

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

    adjacency_list[key][:edges].traverse[1].map do |key|
      adjacency_list[key][:vertex]
    end
  end
end
