# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
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
    let(:author) { create(:author) }
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        post 'create', params: { user: { email: 'nu@gmail.com', password: '123456' } }

        expect(response.code).to be_eql('302')
        expect(User.last.email).to be_eql('nu@gmail.com')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        post 'create', params: { user: { email: 'nu@gmail.com', password: '123456' } }

        expect(response.code).to be_eql('302')
        expect(User.last).to be_nil
      end
    end
  end

  describe '#update' do
    let(:author) { create(:author) }
    let(:user) { create(:user, email: 'old_email@gmail.com') }
    context 'given signed_in' do
      before do
        sign_in user
      end
      it do
        patch 'update', params: { id: user.id, user: { email: 'new_email@gmail.com' } }

        expect(response.code).to be_eql('302')
        expect(User.last.email).to be_eql('new_email@gmail.com')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        patch 'update', params: { id: user.id, user: { email: 'new_email@gmail.com' } }

        expect(response.code).to be_eql('302')
        expect(User.last.email).not_to be_eql('new_email@gmail.com')
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user, email: 'old_email@gmail.com') }
    context 'given signed_in' do
      before do
        sign_in user
      end
      it do
        delete 'destroy', params: { id: user.id }

        expect(response.code).to be_eql('302')
        expect(User.last).to be_nil
      end

      context 'given not destroyed' do
        before do
          allow_any_instance_of(User).to receive(:destroy).and_return(false)
        end

        it do
          delete 'destroy', params: { id: user.id }

          expect(response.code).to be_eql('302')
          expect(User.last).not_to be_nil
        end
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        delete 'destroy', params: { id: user.id }

        expect(response.code).to be_eql('302')
        expect(User.last.email).to be_eql('old_email@gmail.com')
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
