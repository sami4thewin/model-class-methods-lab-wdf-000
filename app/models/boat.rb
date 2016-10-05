class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < ?", 20)
  end

  def self.ship
    Boat.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    # binding.pry
    Boat.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    # binding.pry
    Boat.joins(:classifications).where("classifications.name" => "Sailboat")
  end

  def self.with_three_classifications
    # binding.pry
    # a = Boat.joins(:boat_classifications).group(:boat_id).count
    # b = a.select {|k,v| v == 3}
    # Boat.where(id: b.keys)
    Boat.joins(:boat_classifications).group(:boat_id).having("count(classification_id) = ?", 3)
  end

  def self.longest
   order('length DESC').first
  end

end
