require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'website_name' do
    it 'サイト名を返すこと' do
      expect(website_name).to eq 'RailsCatchup'
    end
  end
end
