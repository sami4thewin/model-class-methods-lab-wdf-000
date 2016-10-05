class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    Captain.joins(:classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    Captain.joins(:classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  #seamen motorboaters and sailer, make own method MOTORBOATERS to find motorboaters
  #combining the two SQL queries together

  def self.motorboaters
    Captain.joins(:classifications).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seamen
    # binding.pry
    a = Captain.motorboaters & Captain.sailors
    Captain.where(id: a.map {|b| b.id  })
  end

  def self.non_sailors
    # binding.pry
    # Captain.joins(:classifications).where("classifications.name = ?", "Sailboat").uniq
    a = Captain.sailors
    Captain.where.not(id: a.map {|b| b.id  })
  end

end
