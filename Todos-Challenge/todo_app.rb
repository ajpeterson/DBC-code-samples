class TodoApp
  def run(args)
    begin
      command = get_command_from_args(args)
      process_command(command)
    rescue RuntimeError => error
      puts "Sorry this error occurred '#{error}'"
    end
  end

  # args is an array
  # returns a Hash for the command
  def get_command_from_args(args)
    raise 'A command is required' if args.empty?
    {
      :filename => 'todo_list_data.txt',
      :command => args[0],
      :modifier => args[1]
    }
  end

  # command is a hash
  def process_command(command)
    model = generate_model_from_text_file(command[:filename])
    case command[:command]
    when 'list'
      list_todos(model)
    when 'add'
      add_one_todo(model, command[:modifier])
    when 'remove'
      remove_one_todo(model, command[:modifier])
    when 'complete'
      mark_todo_complete(model, command[:modifier])
    end
    save_model_to_text_file(command[:filename], model)
  end

  def save_model_to_text_file(filename, model)
    # create txt file from model
    File.open(filename, "w") do |file|
      model.each do |todo|
        file.puts generate_todo_string(todo)
      end
    end
  end

  def generate_model_from_text_file(filename)
    lines = read_non_blank_lines_from_file(filename)
    build_todo_list_from_lines(lines)
  end

  def build_todo_list_from_lines(lines)
    lines.map do |line|
      build_todo_from_line(line)
    end
  end

  def read_non_blank_lines_from_file(filename)
    lines = File.readlines(filename)
    lines.reject! do |line|
      line == "\n"
    end
    lines
  end

  def build_todo_from_line(line)
    # [X] Walk the cat.\n
    {
      :description => line[4..-1].chomp,
      :complete => parse_complete_status(line)
    }
  end

  def parse_complete_status(line)
    if line[1] == 'X'
      true
    else
      false
    end
  end

  # model is an array
  def list_todos(model)
    # print the todos to the screen

    model.each do |todo|
      # each todo is a hash
      puts generate_todo_string(todo)
    end
  end

  def generate_todo_string(todo)
    "[#{todo[:complete] ? 'X' : ' '}] #{todo[:description]}"
  end

  def add_one_todo(model, modifier)
    todo = build_todo_from_modifier(modifier)
    model << todo
    puts "Added \"#{modifier}\" to the list."
  end

  def build_todo_from_modifier(modifier)
    {
      :description => modifier.chomp,
      :complete => parse_complete_status(modifier)
    }
  end

  def remove_one_todo(model, modifier)
    updated_list = model.delete_if do | todo |
      string = todo[:description]
      string_is_included = string.include? "#{modifier}"
      if string_is_included
        puts "Removed \"#{string}\" from the list."
      end
    string_is_included
    end
  end

  def mark_todo_complete(model, modifier)
    updated_list = model.each do | todo |
      string = todo[:description]
      string_is_included = string.downcase.include? "#{modifier}"
      if string_is_included
        todo[:complete] = true
        puts "Marked \"#{string}\" as complete."
      end
    string_is_included
    end
  end



end
