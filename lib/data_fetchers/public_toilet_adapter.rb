class PublicToiletAdapter

  attr_reader :query, :handicap_input

  def initialize(query, handicap_input)
    @query = query
    @handicap_input = handicap_input
  end

  def fetch_toilets
    puts "Fetching all public park toilets located in #{query}..."
    response = RestClient.get("https://data.cityofnewyork.us/resource/r27e-u3sy.json")
    data = JSON.parse(response)
    data.each do |toilet|
      if handicap_input == "yes"
        if borough_park_check(toilet) && toilet["handicap_accessible"] == "Yes"
          Toilet.new(toilet)
        end
      else
        if borough_park_check(toilet)
          Toilet.new(toilet)
        end
      end
    end
  end

  def borough_park_check(toilet)
    toilet["borough"] == query || query.split.all? { |word| toilet["name"].split.include?(word) }
  end

end
