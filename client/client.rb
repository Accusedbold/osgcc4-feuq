Shoes.setup do
  gem "mechanize"
end

class Encoding
  US_ASCII = "US-ASCII"
end
require "mechanize"
require 'json'

Shoes.app :height => 730, :width => 1296 do

  name = ask "What is the name of your character?"
  alert "Hello " + name
  require '../shared/player'

  @player = Player.new :name => name
  
  agent = Mechanize::Mechanize.new

   response = agent.post('http://localhost:9292/register_name', :name => name.force_encoding("UTF-8"))
   parsed_response = JSON.parse(response.body)
   alert parsed_response["player_list"]
   
  @player.y_pos = 360

  @board = []

  720.times { @board << "static/sand_1.gif" } 

  (0..35).each {|i| @board[i] = "static/wall_t_1.gif"}
  (0..20).each {|i| @board[i * 36 - 1 ] = "static/wall_r_1.gif"}
  (0..19).each {|i| @board[i * 36] = "static/wall_l_1.gif"}
  (2..37).each {|i| @board[i * 18] = "static/wall_l_1.gif"}
  (0..34).each {|i| @board[i + 684] = "static/wall_t_1.gif"}
  (0..1).each  {|i| @board[324 + i * 36] = "static/sand_1.gif"}
  (0..1).each  {|i| @board[342 + i * 36] = "static/sand_1.gif"}
  (0..6).each  {|i| @board[280 + i] = "static/wall_t_1.gif"}
  (0..6).each  {|i| @board[460 + i] = "static/wall_t_1.gif"}
  (0..3).each  {|i| @board[316 + i * 36] = "static/wall_l_1.gif"}

  #board[357] = "static/unicorn.gif"

  @board[352] = "static/sandweird.gif"

  #board[360] = "static/Warrior.gif"

  @image_array = []

  @board.each do |b| 
    image b
  end
  @uni_image = image "static/unicorn.gif", :top=> 324, :left => 1188
  @player_top = 360
  @player_left = 0
  @player_image = image "static/Warrior.gif", :top => 360, :left => 0

  def move_player_up
    if @board[(@player_top + (@player_left/36)) - 36]=="static/sand_1.gif" 
    @player_top -= 36
    @player_image.style :top => @player_top
    end
    
  end

  def move_player_down
    if @board[(@player_top + (@player_left/36)) + 36]=="static/sand_1.gif"
    @player_top += 36
    @player_image.style :top => @player_top
    end
 end

  def move_player_right
    if @board[(@player_top + (@player_left/36)) + 1]=="static/sand_1.gif" || @board[(@player_top + (@player_left/36)) + 1]=="static/sandweird.gif"
    @player_left += 36
    @player_image.style :left => @player_left
    end
  end

  def move_player_left
    if @board[(@player_top + (@player_left/36)) - 1]=="static/sand_1.gif" || @board[(@player_top + (@player_left/36)) - 1]=="static/sandweird.gif" 
    @player_left -= 36
    @player_image.style :left => @player_left
    end
  end

  #animate 30 do

    #input = get_input
    #update(input)

  #end

#  def get_input
    keypress do |k|
      case k
        when 'w' then move_player_up
        when 'a' then move_player_left
        when 's' then move_player_down
        when 'd' then move_player_right
	else ""
      end
    end
 # end

end
