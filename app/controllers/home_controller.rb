
class HomeController < ApplicationController
  def index
  end

  def word
    init_ex
    word = params[:word];
    @hash = {}
    process_ex word
    respond_to do |format|
      format.json {render json: @hash.to_json}
    end
  end

  def process_ex word
     @log = "";
    if @keyword.match word
      @hash["key"] = word
      @log = "#{@log}->key"
    elsif @number.match word
      @hash["number"] = word
      @log = "#{@log}->number"
    elsif @rel_op.match word
      @hash["rel_op"] = word
      @log = "#{@log}->rel_op"
    elsif @cal_op.match word
      @hash["cal_op"] = word
      @log = "#{@log}->cal_op"
    elsif @delimiter.match word
      @hash["delimiter"] = word
      @log = "#{@log}->delimiter"
    elsif @string.match word
      @hash["string"] = word
      @log = "#{@log}->string"
    elsif @identify.match word
      @hash["identify"] = word
      @log = "#{@log}->identify"
    else
      mata word
    end
  end

  def init_ex
    @number = /^[0-9]([.][0-9]+|[0-9]*)$/
    @keyword = /^(do|while|if|then|else|var|function|return|true|false)$/
    @identify = /^([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*$/
    @rel_op = /^(==|<|>|!=|=|<=|>=)$/
    @cal_op = /^(\+|\-|\*|\/|\%)$/
    @delimiter = /^(\.|\(|\)|,|\{|\}|;|\[|\]|\'|\")$/

    @string = /^(".*"|'.*')$/
  end

  def mata word
    @status = :start
    @temp = "";
     word.each_char{|char|
      process_ana char
     }
     @hash[@status] = "#{@hash[@status]}  #{@temp}"
  end

  def process_ana char
    case @status.to_s
      when :start.to_s
        start_status char
      when :number.to_s
        if @number.match "#{@temp}#{char}"
          @temp = "#{@temp}#{char}"
        else
          if char == "."
            @status = :pre_number
            @temp = "#{@temp}#{char}"
          elsif @rel_op.match char
            @status = :rel_op
          elsif @cal_op.match char
            @hash[:number] = "#{@hash[:number]}  #{@temp}"
            @temp = ""
            start_status char
          elsif @delimiter.match char
            @hash[:number] = "#{@hash[:number]}  #{@temp}"
            @temp = ""
            start_status char
          else
            @status = :unknow
            @temp = "#{@temp}#{char}"
          end
        end
      when :pre_number.to_s
        if @number.match "#{@temp}#{char}"
          @temp = "#{@temp}#{char}"
        else
          if @rel_op.match char
            @status = :rel_op
          elsif @cal_op.match char
            @hash[:number] = "#{@hash[:number]}  #{@temp}"
            @temp = ""
            start_status char
          else
            @status = :unknow
            @temp = "#{@temp}#{char}"
          end
        end
      when :identify.to_s
        if @identify.match "#{@temp}#{char}"
          @temp = "#{@temp}#{char}"
        else
          @hash[:identify] = "#{@hash[:identify]}  #{@temp}"
          @temp = ""
         start_status char
        end
      when :rel_op.to_s
        if @rel_op.match "#{@temp}#{char}"
          @temp = "#{@temp}#{char}"
        else
          @hash[:rel_op] = "#{@hash[:rel_op]}  #{@temp}"
          @temp = ""
          start_status char
        end
      when :unknow.to_s
        @temp = "#{@temp}#{char}"
    end
  end

  def start_status char
    if @delimiter.match char
      @status = :start 
      @temp = ""
      @hash[:delimiter] = "#{@hash[:delimiter]}  #{char}"
    elsif
     @number.match char
      @status = :number
      @temp = "#{@temp}#{char}"
    elsif
     @identify.match char
      @status = :identify 
      @temp = "#{@temp}#{char}"
    elsif
     @rel_op.match char
      @status = :rel_op 
      @temp = "#{@temp}#{char}"
    elsif
     @cal_op.match char
      @status = :start 
      @hash[:cal_op] = "#{@hash[:cal_op]}  #{char}"
    end
  end
end

