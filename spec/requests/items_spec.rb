require "rails_helper"

RSpec.describe "/items", type: :request do
  let(:item) { create :item }

  let(:valid_attributes) { attributes_for :item }

  let(:invalid_attributes) do
    { name: "", metadata: "" }
  end

  describe "GET /index" do
    it "renders a successful response" do
      get items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get item_url(item)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_item_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:valid_attributes) do
      { title: Faker::Company.name }
    end

    context "with valid parameters" do
      it "creates a new Item" do
        expect {
          post items_url, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the next step for item" do
        post items_url, params: { item: valid_attributes }
        expect(response).to redirect_to(edit_item_url(Item.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        expect {
          post items_url, params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post items_url, params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "alternative title step" do
    let(:steps) { ItemWorkflow::STEPS }
    let(:last_completed_step) { steps.keys[steps.keys.index(:alternative_title) - 1] }
    let(:item) { create :item, last_completed_step: }
    let(:alternative_title) { Faker::Company.name }

    it "updates the requested item" do
      patch item_url(item), params: { item: { alternative_title: } }
      item.reload
      expect(item.metadata["alternativeTitle"]).to eq([alternative_title])
    end

    it "redirects to the item" do
      patch item_url(item), params: { item: { alternative_title: } }
      expect(response).to redirect_to(edit_item_url(item))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested item" do
      item # Need to initiate item before expectation to get count right
      expect {
        delete item_url(item)
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      delete item_url(item)
      expect(response).to redirect_to(items_url)
    end
  end

  describe "publish /publish" do
    subject(:publish) { post publish_item_path(item) }
    let(:esda_id) { SecureRandom.uuid }

    before do
      stub_request(:post, ItemsController::PUBLISH_URL).with(
        body: { esda: { metadata: item.metadata } }.to_json,
      ).to_return(
        status: 200,
        body: { id: esda_id }.to_json,
        headers: { "content-type" => "application/json" },
      )
    end

    it "renders successfully" do
      publish
      expect(response).to redirect_to(item_path(item))
    end

    it "stores the esda id on the item" do
      publish
      expect(item.reload.esda_id).to eq(esda_id)
    end
  end
end
