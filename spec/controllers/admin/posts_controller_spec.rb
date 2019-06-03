# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
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
        post 'create', params: { post: { title: 'Test title', content: 'Abcd', author_id: author.id } }

        expect(response.code).to be_eql('302')
        expect(Post.last.title).to be_eql('Test title')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        post 'create', params: { post: { title: 'Test title', content: 'Abcd', author_id: author.id } }

        expect(response.code).to be_eql('302')
        expect(Post.last).to be_nil
      end
    end
  end

  describe '#update' do
    let(:author) { create(:author) }
    let(:post) { create(:post, title: 'Old title') }
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        patch 'update', params: { id: post.id, post: { title: 'New title', content: 'Abcd', author_id: author.id } }

        expect(response.code).to be_eql('302')
        expect(Post.last.title).to be_eql('New title')
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        patch 'update', params: { id: post.id, post: { title: 'New title', content: 'Abcd', author_id: author.id } }

        expect(response.code).to be_eql('302')
        expect(Post.last.title).to be_eql('Old title')
      end
    end
  end

  describe '#destroy' do
    let(:post) { create(:post, title: 'Old title') }
    context 'given signed_in' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it do
        delete 'destroy', params: { id: post.id }

        expect(response.code).to be_eql('302')
        expect(Post.last).to be_nil
      end

      context 'given not destroyed' do
        before do
          allow_any_instance_of(Post).to receive(:destroy).and_return(false)
        end

        it do
          delete 'destroy', params: { id: post.id }

          expect(response.code).to be_eql('302')
          expect(Post.last).not_to be_nil
        end
      end
    end

    context 'given not signed_in' do
      it 'redirects' do
        delete 'destroy', params: { id: post.id }

        expect(response.code).to be_eql('302')
        expect(Post.last.title).to be_eql('Old title')
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
