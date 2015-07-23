require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end

feature "When users are logged in" do

  it "they can only edit there own restaurants" do
    visit '/'
    sign_up
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Trade'
    click_button 'Create Restaurant'
    expect(current_path).to eq '/restaurants'
    click_link 'Sign out'
    sign_up_2
    expect(current_path).to eq '/'
    click_link 'Edit Trade'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You do not have permission to edit this restaurant'
  end

  it "they can only delete there own restaurants" do
    visit '/'
    sign_up
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Trade'
    click_button 'Create Restaurant'
    expect(current_path).to eq '/restaurants'
    click_link 'Sign out'
    sign_up_2
    expect(current_path).to eq '/'
    click_link 'Delete Trade'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You do not have permission to delete this restaurant'
  end

  def sign_up
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

  def sign_up_2
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'player2@email.com'
    fill_in 'Password', with: 'password2'
    fill_in 'Password confirmation', with: 'password2'
    click_button 'Sign up'
  end
end
