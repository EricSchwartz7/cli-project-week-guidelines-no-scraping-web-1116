class PeeHereCLI

  def call
    greet_user
    loop do
      query = input
      exit?(query)
      handicap_input = handicap?
      exit?(handicap_input)
      fetch_toilets(query, handicap_input)
      render_toilets
      Toilet.clear
    end
  end

  def exit?(query)
    if query == "exit" || query == "Exit"
      abort("Goodbye.")
    end
  end

  def greet_user
    puts "Welcome to the PeeHere app where you can pee freely! Weeee..."
  end

  def input
    print "Would you like to search by borough or park name? "
    borough_or_park_input = gets.strip.downcase
    if borough_or_park_input == "borough"
      prompt_for_borough
    elsif borough_or_park_input == "park" || borough_or_park_input == "park name"
      prompt_for_park
    else
      exit?(borough_or_park_input)
      puts "Please enter a valid response."
      input
    end
  end

  def prompt_for_borough
    print "Please enter the name of your borough: "
    gets.strip.split.collect { |word| word.capitalize }.join(' ')
  end

  def prompt_for_park
    print "Please enter the name of the park: "
    gets.strip.split.collect { |word| word.capitalize }.join(' ')
  end

  def handicap?
    print "Does it need to be handicap accessible? "
    gets.strip.downcase
  end

  def fetch_toilets(query, handicap_input)
    adapter = PublicToiletAdapter.new(query, handicap_input)
    adapter.fetch_toilets
  end

  def render_toilets
    toilets = Toilet.all
    toilets.each do |toilet|
      display_toilet(toilet)
    end
  end

  def display_toilet(toilet)
    puts "Park: #{toilet.name}"
    puts "Location: #{toilet.location}"
    open_year_round?(toilet)
    handicap_accessible?(toilet)
    comments(toilet)
    puts "--------------------------"
  end

  def open_year_round?(toilet)
    if toilet.open_year_round == "Yes"
      puts "This toilet is open year round!"
    elsif toilet.open_year_round == "No"
      puts "Note: This toilet is not open year round."
    else
      puts "Note: This toilet may not be open year round."
    end
  end

  def handicap_accessible?(toilet)
    if toilet.handicap_accessible == "Yes"
      puts "This toilet is handicap accessible."
    else
      puts "This toilet is not handicap accessible."
    end
  end

  def comments(toilet)
    if toilet.comments
      puts "Note: #{toilet.comments}!"
    end
  end

end
