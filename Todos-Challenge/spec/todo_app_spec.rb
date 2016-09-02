require_relative '../todo_app'

describe 'todo list' do
  let(:app) {TodoApp.new}
  let(:model) {[ {:description => "Walk the dog.", :complete => true} ]}

  let(:todo) {{:description => "Walk the dog.", :complete => true}}
  let(:todo_list) { "[X] Walk the dog.\n" }

  let(:modifier) { "Pick Nora up from daycare." }
  let(:remove_modifier) { "dog" }
  let(:complete_modifier) { "fill up gas tank" }

  it 'should print a string given a todo' do
    expect(app.generate_todo_string(todo)).to eq("[X] Walk the dog.")
  end

  describe "output.to_stdout matcher" do
    specify { expect { app.list_todos(model) }.to output.to_stdout }
    specify { expect { app.list_todos(model) }.to output(todo_list).to_stdout }
    specify { expect { }.to_not output.to_stdout }
    specify { expect { app.list_todos(model) }.to_not output('bar').to_stdout }
    specify { expect { app.list_todos(model) }.to_not output(/bar/).to_stdout }
  end

  describe 'add' do
    it 'should add an item to the todo list' do
      expect { app.add_one_todo(model, modifier) }.to change { model.length }.by(1)
    end
  end

  describe 'remove' do
    it 'should add an item to the todo list' do
      expect { app.remove_one_todo(model, remove_modifier) }.to change { model.length }.by(-1)
    end
  end

end
