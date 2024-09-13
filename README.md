# Project: Knights Travails
Following the [TOP (The Odin Project)](https://www.theodinproject.com/lessons/ruby-knights-travails) course and creating project to practice my Graph search algorithms (BFS and DFS) skills.
> Your task is to build a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Implementation](#implementation)
- [Contributing](#contributing)
- [License](#license)

## Installation
1. Clone the repository:
```bash
git clone https://github.com/otherdcn/top-knights-travails
```

2. Install dependencies:
```bash
bundle install
```

## Usage
Use the following command to run the application:
```bash
ruby main.rb
```

## Implementation
This solution uses the __Graph Data Structure__ to solve the shortes path - via __Breadth-First Search (BFS)__ - from one chessboard square to the next for the Knight piece.

The following approach uses an adjacency list representation for the graph. The graph has `336 edges` for a possible maximum of `4,096 edges`; that's `8.2 percent` of the maximum connections possible. It's a sparse graph, therefore, adjacency list is the best representation.

The adjacency list is held in a hash:
```ruby
adjacency_list = Hash.new
```

The key will be the vertex unique id, and the value will be another nested hash that storing all the vertices' vertex object in one key/value pair and all its adjacent vertices in the other (in a linked list):
```ruby
def add_vertex(key, data)
  vertex = Vertex.new(data)
  edges =  LinkedList::Singly.new

  adjacency_list[key] = { vertex: vertex, edges: edges }

  key
end
```

The rest follows the standard operations you would expect from a graph data structure:
- check to see if two vertices are connected: `Graph#vertices_connected?`
- provide a list of all adjacent vertices to a particular vertex: `Graph#adjacent_vertices`
- provide a list of all vertices in the graph: `Graph#vertices`

__NOTE:__ The standard BFS algorithm builds a breadth-first tree as it searches the graph, with the source vertex as the root node. The knight piece will eventually reach every square from what ever beginning, thus the tree will be of size _v_ (the number of vertices the graph has):
> Given enough turns, [a knight on a standard 8x8 chess board can move from any square to any other square](https://cdn.statically.io/gh/TheOdinProject/curriculum/284f0cdc998be7e4751e29e8458323ad5d320303/ruby_programming/computer_science/project_knights_travails/imgs/00.png).

However, in this implementation, we stop and break out of the traversal once the current square being examined matches the end/target square:
```ruby
break if current_square == target_square
```

## Contributing
If you feel the need to try it out and perhaps contribute:
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`.
3. Make your changes.
4. Push your branch: `git push origin feature-name`.
5. Create a pull request.

## License
This project is licensed under the [MIT License](LICENSE).

