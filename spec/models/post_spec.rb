# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    context 'given a Post' do
      let(:post) { build(:post) }

      context 'given no title' do
        before do
          post.title = nil
        end

        it { expect(post).not_to be_valid }
      end

      context 'given no content' do
        before do
          post.content = nil
        end

        it { expect(post).not_to be_valid }
      end

      context 'given no author' do
        before do
          post.author = nil
        end

        it { expect(post).not_to be_valid }
      end

      context 'given everything' do
        it { expect(post).to be_valid }
      end
    end
  end

  describe 'publishing' do
    context 'given new post' do
      let(:post) { build(:post) }
      context 'given inactive post' do
        before do
          post.active = false
        end
        it 'does not publish when saving' do
          post.save
          expect(post.published_at).to be_nil
          expect(post.active).to be_falsey
        end
      end

      context 'given active post' do
        before do
          post.active = true
        end
        it 'publish when saving' do
          post.save
          expect(post.published_at).to be_present
          expect(post.active).to be_truthy
        end
      end
    end

    context 'given old active post' do
      let(:post) { create(:post, active: true) }
      context 'given inactive post' do
        it 'inactivates but keeps date when saving' do
          post.update(active: false)

          expect(post.published_at).to be_present
          expect(post.active).to be_falsey
        end
      end

      context 'given active post' do
        it 'does not change published_at when saving' do
          date = post.published_at

          post.update(active: true)

          expect(post.published_at).to be_eql(date)
          expect(post.active).to be_truthy
        end
      end
    end

    context 'given old inactive post' do
      let(:post) { create(:post, active: false) }
      context 'given inactive post' do
        it 'keeps inactive when saving' do
          post.update(active: false)

          expect(post.published_at).to be_nil
          expect(post.active).to be_falsey
        end
      end

      context 'given active post' do
        it 'does change published_at when saving' do
          post.update(active: true)

          expect(post.published_at).to be_present
          expect(post.active).to be_truthy
        end
      end
    end
  end
end
