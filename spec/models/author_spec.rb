# frozen_string_literal: true

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

      it { expect(author).to be_valid }
    end
  end

  describe '#name' do
    let(:author) { Author.new(firstname: 'Jon', lastname: 'Snow') }

    context 'given no firstname' do
      before do
        author.firstname = nil
      end
      context 'given lastname' do
        it 'returns lastname' do
          expect(author.name).to be_eql('Snow')
        end
      end

      context 'given no lastname' do
        before do
          author.lastname = nil
        end
        it 'returns nothing' do
          expect(author.name).to be_eql('')
        end
      end
    end

    context 'given firstname' do
      context 'given lastname' do
        it 'returns lastname' do
          expect(author.name).to be_eql('Jon Snow')
        end
      end

      context 'given no lastname' do
        before do
          author.lastname = nil
        end
        it 'returns nothing' do
          expect(author.name).to be_eql('Jon')
        end
      end
    end
  end
end
