# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'active scope' do
    context 'given active category' do
      let!(:category) { create(:category, active: true) }

      it 'returns active' do
        expect(Category.active.size).to be_eql(1)
      end
    end

    context 'given inactive category' do
      let!(:category) { create(:category, active: false) }

      it 'returns active' do
        expect(Category.active.size).to be_eql(0)
      end
    end
  end
end
