require 'rails_helper'

feature 'Manage todos in the list', :js => true do

def create_todo(title)
  visit root_path
  fill_in 'todo_title', with: title
  page.execute_script("$('form#new_todo').submit();")
end

  scenario 'We can create new tasks' do
    title = "catch capybaras"
    create_todo(title)
    expect(page).to have_content("catch capybaras")
  end

  scenario 'Counter updates when creating new tasks' do
    title = "catch capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'completed counter updates when completing tasks' do
    title = "catch capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check "todo-1"
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
  end

  scenario 'total count, completed count, todo count' do
    title = "catch capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check "todo-1"
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"

    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    check "todo-2"
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"

    create_todo(title)
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end

  scenario 'total count, completed count, todo count' do
    title = "catch capybaras"
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check "todo-1"
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"

    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    check "todo-2"
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"

    create_todo(title)
    click_link("clean-up")
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end
end
