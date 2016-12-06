class Toilet

  attr_accessor :borough, :comments, :handicap_accessible, :location, :name, :open_year_round
  ALL = []

  def self.all
    ALL
  end

  def self.clear
    ALL.clear
  end

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    ALL << self
  end

end
