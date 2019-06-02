require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    context 'given no associated user' do
      let(:author) { build(:author, user: nil) }

      it { expect(author).not_to be_valid }
    end

    context 'given no firstname' do
      let(:author) { build(:author, firstname: nil) }

      it { expect(author).not_to be_valid }
    end

    context 'given all required data' do
      let(:author) { build(:author) }

      it { expect(author).not_to be_valid }
    end
  end
end
