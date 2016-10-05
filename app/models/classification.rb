class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    # binding.pry
    Boat.longest.classifications
    # Classification.joins(:boats).where("boats.length" => 34)
  end

end
