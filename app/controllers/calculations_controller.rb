class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split = @text.split

    @word_count = text_split.count

    @character_count_with_spaces = @text.length
    
    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length

    text_downcase=@text.downcase
    text_downcase_nopunctuation=text_downcase.gsub(/[^a-z ]/, "")
    text_downcase_split=text_downcase_nopunctuation.split
    @occurrences = text_downcase_split.count(@special_word)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    n = @years*12
    r = @apr/12/100
    p = @principal
    
    @monthly_payment = (r*p*((1+r)**n))/((1+r)**n-1)
    

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    count_is_odd = @count.odd?
    if count_is_odd == true
      @median = @sorted_numbers[(@count-1)/2]
    else
      @median = (@sorted_numbers[@count/2]+@sorted_numbers[@count/2-1])/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count
    
    i = 0
    sum_of_squares=0
    while i < @count
      distance_mean = @sorted_numbers[i]-@mean
      squared_distance = distance_mean**2
      sum_of_squares = sum_of_squares + squared_distance
      i += 1
    end

    @variance = sum_of_squares/@count

    @standard_deviation = Math.sqrt(@variance)

    temp_mode=@sorted_numbers[0]
    i=1
    while i < @count
      count_i=@sorted_numbers.count(@sorted_numbers[i])
      if count_i>@sorted_numbers.count(temp_mode)
        temp_mode=@sorted_numbers[i]
      end
        i+=1
    end
    @mode = temp_mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
