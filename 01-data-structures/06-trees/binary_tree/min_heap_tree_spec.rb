include RSpec

require_relative 'min_heap_tree'

RSpec.describe MinHeapTree, type: Class do
  let (:tree) { MinHeapTree.new }
  let (:matrix) { Node.new("The Matrix", 87) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#insert(data)" do
    it "it inserts left child first" do
      tree.insert( matrix)
      tree.insert( donnie)
      expect(tree.tree[1].title).to eq "The Matrix"
    end

    it "properly inserts second node right" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      expect(tree.tree[2].title).to eq "Inception"
    end

    it "properly inserts third new node as a left-left child" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      expect(tree.tree[3].title).to eq "Star Wars: A New Hope"
    end

    it "properly inserts a new node as a left-right child" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      expect(tree.tree[4].title).to eq "District 9"
    end

    it "properly inserts a new node as a right-left child" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      tree.insert( martian)
      expect(tree.tree[5].title).to eq "The Martian"
    end

    it "properly inserts a new node as a right-right child" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      tree.insert( martian)
      tree.insert( mad_max_2)
      expect(tree.tree[6].title).to eq "Mad Max 2: The Road Warrior"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      tree.insert( matrix)
      tree.insert( empire)
      tree.insert( mad_max_2)
      expect(tree.find( nil)).to eq nil
    end

    it "properly finds a left node" do
      tree.insert( matrix)
      tree.insert( pacific_rim)
      expect(tree.find( matrix.title).title).to eq "The Matrix"
    end

    it "properly finds a right node" do
      tree.insert( matrix)
      tree.insert( braveheart)#switch with matrix
      tree.insert( pacific_rim)#sitch with braveheart
      expect(tree.find( braveheart.title).title).to eq "Braveheart"
    end

    it "properly finds a left-left node" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      expect(tree.find( hope.title).title).to eq "Star Wars: A New Hope"
    end

    it "properly finds a left-right node" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      expect(tree.find( district.title).title).to eq "District 9"
    end

    it "properly finds a right-left node" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      tree.insert( martian)
      expect(tree.find( martian.title).title).to eq "The Martian"
    end

    it "properly finds a right-right node" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.insert( hope)
      tree.insert( district)
      tree.insert( martian)
      tree.insert( mad_max_2)
      expect(tree.find( mad_max_2.title).title).to eq "Mad Max 2: The Road Warrior"
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(tree.delete( nil)).to eq nil
    end

    it "properly deletes a left node" do
      tree.insert( matrix)
      tree.insert( hope)
      tree.delete( hope.title)
      expect(tree.find( hope.title)).to be_nil
    end

    it "properly deletes a left-left node" do
      tree.insert( matrix)
      tree.insert( braveheart)
      tree.insert( pacific_rim)
      tree.delete( pacific_rim.title)
      expect(tree.find( pacific_rim.title)).to be_nil
    end

    it "properly deletes a left-right node" do
      tree.insert( matrix)
      tree.insert( donnie)
      tree.insert( inception)
      tree.delete( inception.title)
      expect(tree.find( inception.title)).to be_nil
    end

    it "properly deletes a right node" do
      tree.insert( matrix)
      tree.insert( district)
      tree.delete( district.title)
      expect(tree.find( district.title)).to be_nil
    end

    it "properly deletes a right-left node" do
      tree.insert( matrix)
      tree.insert( hope)
      tree.insert( martian)
      tree.delete( martian.title)
      expect(tree.find( martian.title)).to be_nil
    end

    it "properly deletes a right-right node" do
      tree.insert( matrix)
      tree.insert( empire)
      tree.insert( mad_max_2)
      tree.delete( mad_max_2.title)
      expect(tree.find( mad_max_2.title)).to be_nil
    end
  end

  describe "#printf" do
     specify {
       expected_output = "Pacific Rim: 72\nBraveheart: 78\nStar Wars: Return of the Jedi: 80\nThe Matrix: 87\nDistrict 9: 90\nStar Wars: The Empire Strikes Back: 94\nInception: 86\nStar Wars: A New Hope: 93\nThe Shawshank Redemption: 91\nThe Martian: 92\nMad Max 2: The Road Warrior: 98\n"
       tree.insert( matrix)#87
       tree.insert( hope)#93
       tree.insert( empire)#94
       tree.insert( jedi)#80
       tree.insert( martian)#92
       tree.insert( pacific_rim)#72
       tree.insert( inception)#86
       tree.insert( braveheart)#78
       tree.insert( shawshank)#91
       tree.insert( district)#90
       tree.insert( mad_max_2)#98
       expect { tree.printf }.to output(expected_output).to_stdout
     }

     specify {
       expected_output = "Pacific Rim: 72\nStar Wars: Return of the Jedi: 80\nBraveheart: 78\nThe Matrix: 87\nThe Shawshank Redemption: 91\nDistrict 9: 90\nInception: 86\nMad Max 2: The Road Warrior: 98\nThe Martian: 92\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\n"
       tree.insert( matrix)
       tree.insert( mad_max_2)
       tree.insert( district)
       tree.insert( shawshank)
       tree.insert( braveheart)
       tree.insert( inception)
       tree.insert( pacific_rim)
       tree.insert( martian)
       tree.insert( jedi)
       tree.insert( empire)
       tree.insert( hope)
       expect { tree.printf }.to output(expected_output).to_stdout
     }
  end
end
