require 'rails_helper'

feature 'Manage todos in the list', :js => true do
  scenario 'We can create new tasks' do
    title = "catch capybaras"
    visit root_path
    fill_in 'todo_title', with: "catch capybaras"
    page.execute_script("$('form#new_todo').submit();")
    expect(page).to have_content("catch capybaras")
  end

  scenario 'Counter updates when creating new tasks' do
  visit root_path
  title = "catch capybaras"
  fill_in 'todo_title', with: "catch capybaras"
  page.execute_script("$('form#new_todo').submit();")
  expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

end
