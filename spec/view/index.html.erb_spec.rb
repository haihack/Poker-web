require "spec_helper"
require 'rails_helper'

RSpec.describe "index.html", type: :feature do
  include Constants

  describe 'ok' do
    it 'should return ROYAL_FLUSH hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H13 H12 H11 H10'
      # find('input[name="submit"]').click
      submit_form

      expect(page).to have_content $handTypes[$handTypes_royal_flush]
    end

    it 'should return STRAIGHT_FLUSH hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H2 H3 H4 H5'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_straight_flush]
    end

    it 'should return FOUR_OF_A_KIND hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H7 D7 C7 S7'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_4_of_a_kind]
    end

    it 'should return FULL_HOUSE hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 S1 D1 H5 D5'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_full_house]
    end

    it 'should return FLUSH hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H13 H5 H6 H10'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_flush]
    end

    it 'should return STRAIGHT hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 C2 D3 H4 H5'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_straight]
    end

    it 'should return THREE_OF_A_KIND hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 D1 C1 H11 D10'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_3_of_a_kind]
    end

    it 'should return TWO_PAIRS hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 D1 H12 D12 C5'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_2_pairs]
    end

    it 'should return ONE_PAIR hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 D1 H5 S11 H10'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_1_pair]
    end

    it 'should return HIGH_CARD hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 D13 C4 S8 H10'
      submit_form

      expect(page).to have_content $handTypes[$handTypes_high_card]
    end

  end

  describe 'failure' do
    it 'empty hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: ''
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'over 5 cards in a hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H2 H3 H4 H5 H6 H7'
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'under 5 cards in a hand' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H2 H3'
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'multiple space between cards' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1  H2  H3 H4 H5'
      submit_form

      expect(page).to have_content "5つのカード指定文字を半角スペース区切りで入力してください。"
    end

    it 'invalid card name` s format' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H111 H2 H3 H4 H5'
      submit_form

      expect(page).to have_content "指定文字が不正です"
    end

    it 'duplicated cards' do
      visit "/welcome/index"
      fill_in 'my_data', with: 'H1 H1 H3 H4 H5'
      submit_form

      expect(page).to have_content "指定文字が重複"
    end

  end

end
