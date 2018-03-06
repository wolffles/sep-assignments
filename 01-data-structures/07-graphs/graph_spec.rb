include RSpec

require_relative 'graph'

RSpec.describe Graph, type: Class do
#Graph
  let (:graph) {Graph.new()}
#actors
  let (:a) { Node.new("a") }
  let (:b) { Node.new("b") }
  let (:c) { Node.new("c") }
  let (:d) { Node.new("d") }
  let (:e) { Node.new("e") }
  let (:f) { Node.new("f") }
  let (:g) { Node.new("g") }
  let (:h) { Node.new("h") }
  let (:i) { Node.new("i") }
  let (:j) { Node.new("j") }
  let (:kevin_bacon) { Node.new("kevin_bacon") }
  let (:l) { Node.new("l") }
  let (:m) { Node.new("m") }
  let (:n) { Node.new("n") }
  let (:o) { Node.new("o") }
  let (:p) { Node.new("p") }
  let (:q) { Node.new("q") }
  let (:r) { Node.new("r") }
  let (:s) { Node.new("s") }

#movies
  let (:one) { Node.new("one") }
  let (:two) { Node.new("two") }
  let (:three) { Node.new("three") }
  let (:four) { Node.new("four") }
  let (:five) { Node.new("five") }
  let (:six) { Node.new("six") }
  let (:seven) { Node.new("seven") }
  let (:eight) { Node.new("eight") }
  let (:nine) { Node.new("nine") }
  let (:ten) { Node.new("ten") }
  let (:eleven) { Node.new("eleven") }
  let (:twelve) { Node.new("twelve") }
  let (:thirteen) { Node.new("thirteen") }
  let (:fourteen) { Node.new("fourteen") }
  let (:fifteen) { Node.new("fifteen") }
  let (:sixteen) { Node.new("sixteen") }
  let (:seventeen) { Node.new("seventeen") }
  let (:eighteen) { Node.new("eighteen") }
  let (:nineteen) { Node.new("nineteen") }

   let (:actors) {[a,b,c,d,e,f,g,h,i,j,kevin_bacon,l,m,n,o,p]}

   let (:films) { [one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen] }
#insert movies to actors hash
before do
  a.film_actor_hash['sixteen'] = sixteen
  a.film_actor_hash['one'] = one
  b.film_actor_hash['one'] = one
  b.film_actor_hash['two'] = two
  c.film_actor_hash['two'] = two
  c.film_actor_hash['three'] = three
  d.film_actor_hash['three'] = three
  d.film_actor_hash['four'] = four
  e.film_actor_hash['four'] = four
  e.film_actor_hash['five'] = five
  f.film_actor_hash['five'] = five
  f.film_actor_hash['six'] = six
  g.film_actor_hash['six'] = six
  g.film_actor_hash['seven'] = seven
  h.film_actor_hash['seven'] = seven
  h.film_actor_hash['eight'] = eight
  i.film_actor_hash['eight'] = eight
  i.film_actor_hash['nine'] = nine
  j.film_actor_hash['nine'] = nine
  j.film_actor_hash['ten'] = ten
  l.film_actor_hash['ten'] = ten
  l.film_actor_hash['eleven'] = eleven
  m.film_actor_hash['eleven'] = eleven
  m.film_actor_hash['twelve'] = twelve
  n.film_actor_hash['twelve'] = twelve
  n.film_actor_hash['thirteen'] = thirteen
  o.film_actor_hash['thirteen'] = thirteen
  o.film_actor_hash['fourteen'] = fourteen
  p.film_actor_hash['fourteen'] = fourteen
  p.film_actor_hash['fifteen'] = fifteen
  kevin_bacon.film_actor_hash['fifteen'] = fifteen
  kevin_bacon.film_actor_hash['sixteen'] = sixteen

  one.film_actor_hash['a'] = a
  one.film_actor_hash['b'] = b
  two.film_actor_hash['b'] = b
  two.film_actor_hash['c'] = c
  three.film_actor_hash['c'] = c
  three.film_actor_hash['d'] = d
  four.film_actor_hash['d'] = d
  four.film_actor_hash['e'] = e
  five.film_actor_hash['e'] = e
  five.film_actor_hash['f'] = f
  six.film_actor_hash['f'] = f
  six.film_actor_hash['g'] = g
  seven.film_actor_hash['g'] = g
  seven.film_actor_hash['h'] = h
  eight.film_actor_hash['h'] = h
  eight.film_actor_hash['i'] = i
  nine.film_actor_hash['i'] = i
  nine.film_actor_hash['j'] = j
  ten.film_actor_hash['j'] = j
  ten.film_actor_hash['l'] = l
  eleven.film_actor_hash['l'] = l
  eleven.film_actor_hash['m'] = m
  twelve.film_actor_hash['m'] = m
  twelve.film_actor_hash['n'] = n
  thirteen.film_actor_hash['n'] = n
  thirteen.film_actor_hash['o'] = o
  fourteen.film_actor_hash['o'] = o
  fourteen.film_actor_hash['p'] = p
  fifteen.film_actor_hash['p'] = p
  fifteen.film_actor_hash['kevin_bacon'] = kevin_bacon
  sixteen.film_actor_hash['kevin_bacon'] = kevin_bacon
  sixteen.film_actor_hash['a'] = a
end

  describe "insert(node)" do
    it "inserts into array to make a sorted array" do
      graph.insert(a,"actor")
      graph.insert(c,"actor")
      graph.insert(b,"actor")
      expect(graph.actors).to eq [a,b,c]
    end
    it "inserts into array to make sorted array" do
      graph.insert(one,'film')
      graph.insert(two,'film')
      graph.insert(three,'film')
      expect(graph.films).to eq [one,three,two]
    end
  end

  describe "find(actor_node)" do
    it "returns the actors node" do
      graph.actors = actors
      graph.films = films
      expect(graph.find(a)).to eq a
    end
  end

  describe "six_degrees_KB(actor_node)" do
    it "tells you if it's kevin bacon" do
      graph.actors = actors
      graph.films = films
      expect(graph.six_degrees_KB(kevin_bacon)).to eq "redundant question actor is kevin_bacon"
    end

    it "returns the list of movies 1 degrees" do
      graph.actors = actors
      graph.films = films
      expect(graph.six_degrees_KB(a)).to eq ["sixteen"]
    end

    it "returns the list of movies 4 degrees away" do
      graph.actors = actors
      graph.films = films
      expect(graph.six_degrees_KB(d).sort).to eq ["one", "sixteen", 'two', 'three'].sort
    end

    it "returns the list of movies 6 degrees away" do
      graph.actors = actors
      graph.films = films
      expect(graph.six_degrees_KB(f).sort).to eq ["one", "sixteen", 'two', 'three', 'four','five'].sort
    end

    it "more than 6 degrees" do
      graph.actors = actors
      graph.films = films
      expect(graph.six_degrees_KB(h)).to eq "kevin bacon not in 6 degrees of h"
    end
  end
end
