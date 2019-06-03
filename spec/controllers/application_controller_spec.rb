# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  context 'given devise controller' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:devise_controller?).and_return(true)
    end

    it { expect(controller.send(:layout_by_resource)).to be_eql('devise') }
  end

  context 'given common controller' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:devise_controller?).and_return(false)
    end

    it { expect(controller.send(:layout_by_resource)).to be_eql('application') }
  end
end
