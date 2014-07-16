class DataSearcher
  
  attr_accessor :final

  def initialize
    @file_name = ''
    @max = 0
    @min = 0
  end

  def get_file_name
    puts 'What is the name of the file you would like to analyze?  Chose a file with only numbers please.'
    gets.chomp
  end

  def file_check (f_name)
    File.open(f_name, 'r') do |f|
      while num = f.gets
        unless num.is_a? Integer
          puts 'Please use a file with only numbers next time.'
          return false
        end
      end
    end
    true
  end

  def find_mean (f_name)
    sum = 0
    count = 0
    File.open(f_name,'r') do |f|
      while num = f.gets
        sum += num
        count += 1
      end
    end
    sum/count
  end

  def find_range (f_name)
    File.open(f_name, 'r') do |f|
      while num = f.gets
        if num > @max
          @max = num
        end
        if num < @min
          @min = num
        end
      end
    end
  end

  def find_mode (f_name)
    mode_array = []
    File.open(f_name, 'r') do |f|
      while num = f.gets
        mode_array.add(num)
      end
    end
    frequency = mode_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h}
    mode_array.max_by { |v| frequency[v]}
  end

  def find_median (f_name)
    median_array = []
    median_count = 0
    File.open(f_name, 'r') do |f|
      while num = f.gets
        median_array.add(num)
        median_count += 1
      end
    end
    median_array.sort!
    median_count = (median_count / 2).round
    if median_array.length % 2 ==0
      return (median_array[median_count] + median_array[median_count + 1]) / 2
    end
    median_array[median_count]
  end

  def body
    puts "Hello! Let's look at some data."
    @file_name = get_file_name
    if file_check(@file_name)
      puts 'What would you like to see? Press 1 for mean, 2 for median, 3 for mode, or 4 for range.'
      selection = gets.chomp
      case selection
        when 1
          find_mean(@file_name)
        when 2
          find_median(@file_name)
        when 3
          find_mode(@file_name)
        when 4
          find_range(@file_name)
        else
          puts 'You did not enter 1-4!'
      end
    end
  end

end

