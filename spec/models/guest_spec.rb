# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  context 'name' do
    it 'returns the name of the guest' do
      guest = Guest.new(first_name: 'John', last_name: 'Doe')
      expect(guest.name).to eq('John, Doe')
    end

    it 'returns the first name if the last name is not present' do
      guest = Guest.new(first_name: 'John')
      expect(guest.name).to eq('John')
    end

    it 'returns the last name if the first name is not present' do
      guest = Guest.new(last_name: 'Doe')
      expect(guest.name).to eq('Doe')
    end

    it 'returns the default name if the first and last name are not present' do
      guest = Guest.new
      expect(guest.name).to eq('Guest')
    end
  end
end
