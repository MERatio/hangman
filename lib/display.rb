# frozen_string_literal: true

# Displaying outputs on command line
class Display
  def correct_letters(correct_letters)
    puts "Correct letters:   #{correct_letters.join('')}"
  end

  def incorrect_letters(incorrect_letters)
    puts "Incorrect letters: #{incorrect_letters.join(', ')}"
  end

  def game_result(line_width, human_guessed, secret_word)
    message = human_guessed ? 'You Win!' : 'No lives left, You lose!'
    center_alert(message, line_width)
    puts "The secret word is #{secret_word}"
  end

  def new_or_load
    puts '          Type new to play a new game'
    puts '          Type load to load a previous save'
  end

  def save_files(save_files)
    save_files.each_with_index do |save_file, index|
      puts "          #{index} = #{save_file}"
    end
  end

  def center_alert(message, line_width = 50)
    puts message.center(line_width)
  end

  def alert(message)
    puts message
  end

  def newline
    puts "\n"
  end

  def clear
    system('clear') || system('cls')
  end
end
