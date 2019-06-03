# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
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
        post 'create', params: { category: { name: 'Test name', description: 'Abcd' } }

        expect(response.code).to be_eql('302')
        expect(Category.last.name).to be_eql('Test name')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        post 'create', params: { category: { name: 'Test name', description: 'Abcd' } }

        expect(response.code).to be_eql('302')
        expect(Category.last).to be_nil
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:category) { create(:category, name: 'Old name') }
    context 'given signed_in' do
      before do
        sign_in user
      end
      it do
        patch 'update', params: { id: category.id, category: { name: 'New name', description: 'Abcd' } }

        expect(response.code).to be_eql('302')
        expect(Category.last.name).to be_eql('New name')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        patch 'update', params: { id: category.id, category: { name: 'New name', description: 'Abcd' } }

        expect(response.code).to be_eql('302')
        expect(Category.last.name).to be_eql('Old name')
      end
    end
  end

  describe '#destroy' do
    let(:category) { create(:category, name: 'Old name') }
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        delete 'destroy', params: { id: category.id }

        expect(response.code).to be_eql('302')
        expect(Category.last).to be_nil
      end

      context 'given not destroyed' do
        before do
          allow_any_instance_of(Category).to receive(:destroy).and_return(false)
        end

        it do
          delete 'destroy', params: { id: category.id }

          expect(response.code).to be_eql('302')
          expect(Category.last).not_to be_nil
        end
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        delete 'destroy', params: { id: category.id }

        expect(response.code).to be_eql('302')
        expect(Category.last.name).to be_eql('Old name')
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
