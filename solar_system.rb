#array of hashes with planet info
planets = [
  {name: "Mercury",
    type: "terrestrial",
    position: "first",
    diameter: 3031,
    moons: 0,
    solar_revolution: 88,
    distance_from_the_sun: 36000000 },

  { name: "Venus",
    type: "terrestrial",
    position: "second",
    diameter: 7521,
    moons: 0,
    solar_revolution: 225,
    distance_from_the_sun: 67200000 },

  { name: "Earth",
    type: "terrestrial",
    position: "third",
    diameter: 7926,
    moons: 1,
    solar_revolution: 365,
    distance_from_the_sun: 93000000},

  { name: "Mars",
    type: "terrestrial",
    position: "fourth",
    diameter: 4222,
    moons: 2,
    solar_revolution: 687,
    distance_from_the_sun: 141600000},

  { name: "Jupiter",
    type: "gas",
    position: "fifth",
    diameter: 88729,
    moons: 67,
    solar_revolution: 4380,
    distance_from_the_sun: 483600000},

  { name: "Saturn",
    type: "gas",
    position: "sixth",
    diameter: 74600,
    moons: 62,
    solar_revolution: 10585,
    distance_from_the_sun: 886700000},

  { name: "Uranus",
    type: "gas",
    position: "seventh",
    diameter: 32600,
    moons: 27,
    solar_revolution: 30660,
    distance_from_the_sun: 178400000},

  {name: "Neptune",
    type: "gas",
    position: "eighth",
    diameter: 30200,
    moons: 14,
    solar_revolution: 60225,
    distance_from_the_sun: 3674500000},

  {name: "Hoth",
    type: "star wars",
    position: "far far away",
    diameter: 10000,
    moons: 2,
    solar_revolution: 73000,
    distance_from_the_sun: 15600000}
]

#creates class Planet
class Planet
  #instance vars accessed outside of the class need to be here in attributes
  attr_reader :name, :moons, :diameter, :position, :type, :distance, :solar_revolution

  #the hashes that send the info to Planet are not ordered
  def initialize(planet_hash)
    @name = planet_hash[:name]
    @moons = planet_hash[:moons]
    @diameter = planet_hash[:diameter]
    @position = planet_hash[:position]
    @type = planet_hash[:type]
    @distance = planet_hash[:distance_from_the_sun]
    @solar_revolution = planet_hash[:solar_revolution]
  end

  #prints info about a planet
  def print_info
    puts "#{ @name } is the #{ @position } planet from the sun.\nIt is a #{ @type } planet that is #{ @diameter } miles wide.\n#{ @name } has #{ @moons } moons."
  end

end #end Planet class

#creates class SolarSystem
class SolarSystem
  attr_accessor :system, :planet, :all_planets, :age

  #required parameters are an array of planet hashes, name of system, formation year (given in billions of earth years)
  def initialize(in_all_planets, in_system, in_formation)
    @system = in_system #name of system
    @all_planets = in_all_planets
    @formation = in_formation
  end

  #lists all the planets in the system
  def list_all_planets
    puts "The #{ @system } system has these #{ @all_planets.length } planets:"
    @all_planets.each do |planet|
      puts "#{@all_planets.index(planet)+1}. #{planet.name}"
    end
  end

  #calculates the age of the planet called from a method outside of SolarSystem class. solar_revolion is called on Planet.class var
  def calc_planet_age(solar_revolution) #pass planet.solar_revolution to this method
    formation_year = @formation * 10 ** 9
    return formation_year/solar_revolution #pretend math
  end

  #calculates the absolute distance between two planets and returns a puts statement.
  def planets_distance(planet_one, planet_two)
    distance = (@all_planets[planet_one].distance-@all_planets[planet_two].distance).abs
    puts "#{@all_planets[planet_one].name} and #{@all_planets[planet_two].name} are #{distance/1000000.0} million miles apart."
  end

  #method I made to see if @all_planets was an array (though maybe .class would have been better than .length)
  def test_all_planets
    puts @all_planets.length
  end

end #SolarSystem class

#method to give user a way to interact with a SolarSystem class var
def solar_system(system) #parameter is an object of class SolarSystem
  user_done = false

  #runs until user says they are done
  until user_done do
    valid_response = false

    system.list_all_planets
    puts "\nPick a planet for more info. (e.g. Enter 1 for #{ system.all_planets[0].name })"
    planet = gets.chomp.to_i-1
    #runs the SolarSystem class method calc_planet_age on the solar_revolution method of the selected planet to get the age of the planet.Coudl have just put this into the planet hash, but was good practice for working with classes within classes
    age = system.calc_planet_age(system.all_planets[planet].solar_revolution)
    puts "\n#{system.all_planets[planet].print_info}"
    #print instead of puts b/c the the print_info method called above has a puts inside of it
    print "#{system.all_planets[planet].name} is #{age.round(2)} Earth years old."

    puts "Find out how far #{system.all_planets[planet].name} is from another planet!\nEnter the number of another planet (see list above) to find out"
    planet_two = gets.chomp.to_i-1
    #runs SolarSystem class method planets_distance on the two selected planets -- which then outputs a statement about the absolute difference
    system.planets_distance(planet, planet_two)
    #asks if they want to learn about a second planet and makes sure they provide a valid response

    until valid_response do
      puts "Do you want to learn about another planet? (yes/no)?"
      keep_going = gets.chomp
      if keep_going == "yes" || keep_going == "no"
        valid_response = true

        if keep_going == "yes"
          user_done = false
        else
          puts "Good-bye!"
          user_done = true
        end

      else
        "Please enter a valid response."
      end

    end

  end

end # end solar_system method

#initialize empty array for Planet class vars
system_planets = []

#populate array with Planets
planets.each do |planet|
  system_planets << Planet.new(planet)
end

#new SolarSystem
borg = SolarSystem.new(system_planets, "borg", 4.9)

#run solar_system method on borg to learn about its planets
solar_system(borg)
