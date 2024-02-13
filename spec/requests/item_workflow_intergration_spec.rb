require "rails_helper"

RSpec.describe "items workflow", type: :request do
  let(:steps) do
    {
      title: Faker::Company.name,
      alternative_title: Faker::Company.name,
      summary: Faker::Lorem.paragraph,
      description: Faker::Lorem.paragraph,
      keyword: Faker::Internet.slug,
    }
  end

  it "visits each step in the flow" do
    item = nil
    steps.each do |step, input|
      if step == steps.keys.first
        post items_url, params: { item: { step => input } }
        item = Item.last
      else
        patch item_url(item), params: { item: { step => input } }
      end

      if step == steps.keys.last
        expect(response).to redirect_to(item_url(item))
      else
        expect(response).to redirect_to(edit_item_url(item)), "#{step} didn't redirect to next step"
      end

      expect(item.reload.metadata[step.to_s.camelize(:lower)]).to include(input), "#{step} in metadata was not: #{input}"
    end
  end
end
