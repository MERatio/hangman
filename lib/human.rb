# frozen_string_literal: true

require_relative './display.rb'

# Representing the guesser
class Human
  attr_reader :display

  def initialize
    @display = Display.new
  end

  def choice
    begin
      @display.new_or_load
      choice = prompt_user('Your choice: ')
      choice = prompt_user('Your choice: ') until proper_choice_format(choice)
    rescue Interrupt
      exit
    end
    choice
  end

  def guess(used_letters)
    begin
      guess = prompt_user('Enter a letter:    ')
      until proper_guess_format(guess, used_letters)
        guess = prompt_user('Enter a letter:    ')
      end
    rescue Interrupt
      exit
    end
    guess
  end

  def save_file_number(save_files)
    begin
      save_file = prompt_user('Input save file number: ').to_i
      until proper_save_file_format(save_file, save_files)
        save_file = prompt_user('Input save file number: ').to_i
      end
    rescue Interrupt
      exit
    end
    save_file
  end

  private

  def prompt_user(message)
    print message
    gets.downcase.strip
  end

  def proper_choice_format(choice)
    true if %w[new load].include?(choice)
  end

  def proper_save_file_format(save_file, save_files)
    save_files[save_file]
  end

  def proper_guess_format(guess, used_letters)
    return true if guess == 'save'

    only_letter(guess) && single_letter(guess) && unused_letter(guess, used_letters)
  end

  def single_letter(guess)
    if guess.length == 1
      true
    else
      @display.center_alert('Input 1 letter only')
      false
    end
  end

  def only_letter(guess)
    if /[a-z]/.match?(guess)
      true
    else
      @display.center_alert('Input 1 letter only')
      false
    end
  end

  def unused_letter(guess, used_letters)
    if !used_letters.include?(guess)
      true
    else
      @display.center_alert('Letter used already, use different letter')
      false
    end
  end
end
