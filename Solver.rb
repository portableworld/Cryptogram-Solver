class Puzzle

  attr :puzzle
  attr :solution

  @@dict = File.readlines("dictionary.txt").map{|x| x.chomp}

  def initialize(puzzle = "")
    raise TypeError, "String argument expected" unless puzzle.is_a? String
    @puzzle = puzzle

  end

  def solve
    # .empty? perhaps
    if @puzzle != ""
      # Start Timer
      # Call private method for solving
      solve_puzzle
      #puts @solution
    else
      # Tell user there is no puzzle to solve
      puts "You haven't given me a puzzle to solve"
    end
  end

  ## Assignment Methods ##

  def solution=(msg)
    puts "Please do not alter the solution"
  end

  def puzzle=(puzzle)
    raise TypeError, "String argument expected" unless puzzle.is_a? String
    @puzzle = puzzle
  end
  
  
  private
  
  def solve_puzzle
    # Find longest word in puzzle
    longest_word = find_longest_word
    # Solve that word
    solve_word(longest_word)
  end
  

  def find_longest_word
    words = @puzzle.split
    longest = words.max {|a,b| a.length <=> b.length}
  end
  
  def solve_word(word)

    encrypted_word = encrypt_word(word)

    possible_solutions = {}
    @@dict.each {|w|
      if w.length == word.length
        possible_solutions[w] = encrypt_word(w)
      end
    }

    possible_solutions.each_pair {|key, value|
      if value == encrypted_word
        puts "Word could be: #{key}"
      end
    }

    return nil
  end

  def encrypt_word(word)
    hash = {}
    i = 0
    new_word = []

    word.each_char {|c|
      unless hash.include?(c)
        hash[c] = i.to_s
        new_word << i.to_s
        i += 1
      else
        new_word << hash[c]
      end
    }
    return new_word.join
  end


end
