require "rails_helper"

RSpec.describe "/esdas", type: :request do
  let!(:esda) { create :esda }
  let(:valid_attributes) do
    { metadata: esda.metadata.to_json }
  end
  let(:invalid_attributes) do
    { metadata: "" }
  end

  let(:valid_headers) do
    {}
  end

  describe "GET /index" do
    it "renders a successful response" do
      get esdas_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get esda_url(esda), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Esda" do
        expect {
          post esdas_url,
               params: { esda: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Esda, :count).by(1)
      end

      it "renders a JSON response with the new esda" do
        post esdas_url,
             params: { esda: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Esda" do
        expect {
          post esdas_url,
               params: { esda: invalid_attributes }, as: :json
        }.to change(Esda, :count).by(0)
      end

      it "renders a JSON response with errors for the new esda" do
        post esdas_url,
             params: { esda: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:metadata) do
        { this: :that }.as_json
      end
      let(:new_attributes) do
        { metadata: metadata.to_json }
      end
      it "updates the requested esda" do
        patch esda_url(esda),
              params: { esda: new_attributes }, headers: valid_headers, as: :json
        esda.reload
        expect(esda.metadata).to eq(metadata)
      end

      it "renders a JSON response with the esda" do
        patch esda_url(esda),
              params: { esda: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the esda" do
        patch esda_url(esda),
              params: { esda: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested esda" do
      expect {
        delete esda_url(esda), headers: valid_headers, as: :json
      }.to change(Esda, :count).by(-1)
    end
  end
end
