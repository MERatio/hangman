# frozen_string_literal: true

require 'json'
require_relative './display.rb'
require_relative './human.rb'

# Overall game functionality
class Game
  LINE_WIDTH = 50
  DICTIONARY = IO.readlines('dictionary.txt', chomp: true)
                 .select { |word| word.length > 4 && 13 }

  attr_reader :dictionary, :secret_word, :display, :human
  attr_accessor :correct_letters, :incorrect_letters, :lives, :human_guessed

  def initialize
    @secret_word = DICTIONARY.sample.downcase
    @display = Display.new
    @human = Human.new
    self.correct_letters = []
    self.incorrect_letters = []
    self.lives = 10
    self.human_guessed = false
    assemble_correct_letters
    new_or_load_game
  end

  def play
    play_round until @lives < 1 || @human_guessed
    @display.game_result(LINE_WIDTH, @human_guessed, @secret_word)
  end

  private

  def new_or_load_game
    choice = human.choice
    if choice == 'new'
      @display.center_alert('New game started', LINE_WIDTH)
    elsif choice == 'load'
      load_save_file
    end
    @display.center_alert('Type save to save the current game', LINE_WIDTH)
    play
  end

  def save_file
    Dir.mkdir('save_files') unless Dir.exist?('save_files')
    File.write("save_files/#{@correct_letters.join}.json", game_data_json)
    @display.center_alert('Game saved', LINE_WIDTH)
  end

  def game_data_json
    {
      secret_word: @secret_word,
      correct_letters: @correct_letters,
      incorrect_letters: @incorrect_letters,
      lives: @lives
    }.to_json
  end

  def load_save_file
    save_files = list_save_files
    if save_files.length.positive?
      @display.save_files(save_files)
      number = human.save_file_number(save_files)
      load_game_data(JSON.parse(File.read("save_files/#{save_files[number]}")))
      @display.clear
      @display.center_alert('Game loaded', LINE_WIDTH)
    else
      @display.center_alert('No save file found, starting a new game', LINE_WIDTH)
    end
  end

  def list_save_files
    Dir.glob('save_files/*.json').sort_by { |save_file| File.mtime(save_file) }
       .map { |save_file| save_file.split('/')[-1] }
  end

  def load_game_data(hash)
    @secret_word = hash['secret_word']
    @correct_letters = hash['correct_letters']
    @incorrect_letters = hash['incorrect_letters']
    @lives = hash['lives']
  end

  def play_round
    @display.center_alert("Lives left: #{@lives}", LINE_WIDTH)
    @display.correct_letters(@correct_letters)
    @display.incorrect_letters(@incorrect_letters)
    guess = human.guess(@correct_letters + @incorrect_letters)
    check_guess(guess)
    assemble_correct_letters
    check_answer
    @display.newline
  end

  def check_guess(guess)
    if guess == 'save'
      save_file
    else
      assign_guess(guess)
    end
  end

  def assign_guess(guess)
    if @secret_word.include?(guess)
      @correct_letters.push(guess)
    else
      @incorrect_letters.push(guess)
      @lives -= 1
    end
  end

  def assemble_correct_letters
    @correct_letters = @secret_word.split('').map do |letter|
      @correct_letters.include?(letter) ? letter : '*'
    end
  end

  def check_answer
    @human_guessed = true if @correct_letters.join == @secret_word
  end
end
