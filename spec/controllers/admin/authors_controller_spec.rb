# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::AuthorsController, type: :controller do
  describe '#new' do
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        get 'new'

        expect(response.code).to be_eql('200')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        get 'new'

        expect(response.code).to be_eql('302')
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    context 'given signed_in' do
      before do
        sign_in user
      end
      it do
        post 'create', params: { author: { firstname: 'Test firstname', lastname: 'Abcd', user_id: user.id } }

        expect(response.code).to be_eql('302')
        expect(Author.last.firstname).to be_eql('Test firstname')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        post 'create', params: { author: { firstname: 'Test firstname', lastname: 'Abcd', user_id: user.id } }

        expect(response.code).to be_eql('302')
        expect(Author.last).to be_nil
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:author) { create(:author, firstname: 'Old firstname') }
    context 'given signed_in' do
      before do
        sign_in user
      end
      it do
        patch 'update', params: { id: author.id, author: { firstname: 'New firstname', lastname: 'Abcd', user_id: user.id } }

        expect(response.code).to be_eql('302')
        expect(Author.last.firstname).to be_eql('New firstname')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        patch 'update', params: { id: author.id, author: { firstname: 'New firstname', lastname: 'Abcd', user_id: user.id } }

        expect(response.code).to be_eql('302')
        expect(Author.last.firstname).to be_eql('Old firstname')
      end
    end
  end

  describe '#destroy' do
    let(:author) { create(:author, firstname: 'Old firstname') }
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        delete 'destroy', params: { id: author.id }

        expect(response.code).to be_eql('302')
        expect(Author.last).to be_nil
      end

      context 'given not destroyed' do
        before do
          allow_any_instance_of(Author).to receive(:destroy).and_return(false)
        end

        it do
          delete 'destroy', params: { id: author.id }

          expect(response.code).to be_eql('302')
          expect(Author.last).not_to be_nil
        end
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        delete 'destroy', params: { id: author.id }

        expect(response.code).to be_eql('302')
        expect(Author.last.firstname).to be_eql('Old firstname')
      end
    end
  end

  describe '#index' do
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        get :index, params: {}

        expect(response.code).to be_eql('200')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        get :index

        expect(response.code).to be_eql('302')
      end
    end
  end
end
