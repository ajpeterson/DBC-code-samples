require 'csv'

def open_csv_file(filename)
  CSV.open('todo_list_data.csv', "a+", headers: true)
end

def list_todos(todos)
  todos.to_a.each { | todo | puts "#{todo["item_description"]}" }
end

def add_item_to_list(todos, list_item)
  todos << ["[ ] #{list_item}"]
  puts "Added \"#{list_item}\" to the list"
end

def remove_item_from_list(todos, descriptor, filename)
  updated_list = todos.to_a.delete_if do | todo_item |
    string = todo_item.to_s.chomp
    string = string.gsub(/^(.{4})(.+)/, '\2')
    string_is_included = string.include? "#{descriptor}"
    if string_is_included
      puts "Removed \"#{string}\" from the list."
    end
    string_is_included
  end

  save_todo_list(filename, updated_list)
end

def mark_item_as_complete(todos, descriptor, filename)
    updated_list = todos.to_a.delete_if do | todo_item |
    string = todo_item.to_s.chomp
    string = string.gsub(/^(.{4})(.+)/, '\2')
    string_is_included = string.downcase.include? "#{descriptor}"
    if string_is_included
      todos << ["[X] #{string}"]
      puts "Marked \"#{string}\" as complete."
    end
    string_is_included
  end
  save_todo_list(filename, updated_list)
end

def save_todo_list(filename, todos)
  CSV.open(filename, "w") do | csv |
    csv << ["item_description"]
    todos.each do | row |
      csv << [row["item_description"]]
    end
  end

  # save to file name.txt
end

def process_command(csv, command, modifier, filename)
  case command
  when "list"
    list_todos(csv)
  when "add"
    add_item_to_list(csv, modifier)
  when "remove"
    remove_item_from_list(csv, modifier, filename)
  when "complete"
    mark_item_as_complete(csv, modifier, filename)
  end
end

#####################################################

csv = open_csv_file('todo_list_data.csv')
process_command(csv, ARGV[0], ARGV[1], 'todo_list_data.csv')
