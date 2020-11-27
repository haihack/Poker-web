require "spec_helper"
require 'rails_helper'

RSpec.describe "index.html", type: :feature do
  include Constants
  HAND_TYPES = %w[ロイヤルフラッシュ ストレートフラッシュ フォー・オブ・ア・カインド フルハウス フラッシュ ストレート スリー・オブ・ア・カインド ツーペア ワンペア ハイカー]
  HANDTYPES_ROYAL_FLUSH = 0
  HANDTYPES_STRAIGHT_FLUSH = 1
  HANDTYPES_4_OF_A_KIND = 2
  HANDTYPES_FULL_HOUSE = 3
  HANDTYPES_FLUSH = 4
  HANDTYPES_STRAIGHT = 5
  HANDTYPES_3_OF_A_KIND = 6
  HANDTYPES_2_PAIRS = 7
  HANDTYPES_1_PAIR = 8
  HANDTYPES_HIGH_CARD = 9

  let(:url) { "/welcome/index" }

  describe 'ok' do
    it 'should return ROYAL_FLUSH hand' do
      visit url
      fill_in 'my_data', with: 'H1 H13 H12 H11 H10'
      # find('input[name="submit"]').click
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_ROYAL_FLUSH]
    end

    it 'should return STRAIGHT_FLUSH hand' do
      visit url
      fill_in 'my_data', with: 'H1 H2 H3 H4 H5'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_STRAIGHT_FLUSH]
    end

    it 'should return FOUR_OF_A_KIND hand' do
      visit url
      fill_in 'my_data', with: 'H1 H7 D7 C7 S7'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_4_OF_A_KIND]
    end

    it 'should return FULL_HOUSE hand' do
      visit url
      fill_in 'my_data', with: 'H1 S1 D1 H5 D5'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_FULL_HOUSE]
    end

    it 'should return FLUSH hand' do
      visit url
      fill_in 'my_data', with: 'H1 H13 H5 H6 H10'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_FLUSH]
    end

    it 'should return STRAIGHT hand' do
      visit url
      fill_in 'my_data', with: 'H1 C2 D3 H4 H5'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_STRAIGHT]
    end

    it 'should return THREE_OF_A_KIND hand' do
      visit url
      fill_in 'my_data', with: 'H1 D1 C1 H11 D10'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_3_OF_A_KIND]
    end

    it 'should return TWO_PAIRS hand' do
      visit url
      fill_in 'my_data', with: 'H1 D1 H12 D12 C5'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_2_PAIRS]
    end

    it 'should return ONE_PAIR hand' do
      visit url
      fill_in 'my_data', with: 'H1 D1 H5 S11 H10'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_1_PAIR]
    end

    it 'should return HIGH_CARD hand' do
      visit url
      fill_in 'my_data', with: 'H1 D13 C4 S8 H10'
      submit_form

      expect(page).to have_content HAND_TYPES[HANDTYPES_HIGH_CARD]
    end

  end

  describe 'failure' do
    it 'empty hand' do
      visit url
      fill_in 'my_data', with: ''
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'over 5 cards in a hand' do
      visit url
      fill_in 'my_data', with: 'H1 H2 H3 H4 H5 H6 H7'
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'under 5 cards in a hand' do
      visit url
      fill_in 'my_data', with: 'H1 H2 H3'
      submit_form

      expect(page).to have_content "５枚のカードが必要です"
    end

    it 'multiple space between cards' do
      visit url
      fill_in 'my_data', with: 'H1  H2  H3 H4 H5'
      submit_form

      expect(page).to have_content "5つのカード指定文字を半角スペース区切りで入力してください。"
    end

    it 'invalid card name` s format' do
      visit url
      fill_in 'my_data', with: 'H111 H2 H3 H4 H5'
      submit_form

      expect(page).to have_content "指定文字が不正です"
    end

    it 'duplicated cards' do
      visit url
      fill_in 'my_data', with: 'H1 H1 H3 H4 H5'
      submit_form

      expect(page).to have_content "指定文字が重複"
    end

  end

end
