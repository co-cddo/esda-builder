class ItemsController < ApplicationController
  PUBLISH_URL = ENV.fetch("PUBLISH_URL", "http://example.com")

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    item
  end

  # GET /items/new
  def new
    form
  end

  # GET /items/1/edit
  def edit
    form
  end

  # POST /items
  def create
    if form.save
      redirect_to edit_item_url(form.item), notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if form.save
      target_url = ItemWorkflow.last_step?(item:) ? item_url(item) : edit_item_url(item)
      redirect_to target_url, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    item.destroy!
    redirect_to items_url, notice: "Item was successfully destroyed."
  end

  def publish
    header = { "Content-Type" => "application/json" }
    body = { esda: { metadata: item.metadata } }.to_json
    response = Faraday.post(PUBLISH_URL, body, header)
    if response.success? && response.headers["content-type"] =~ /json/
      json = JSON.parse(response.body)
      item.update!(esda_id: json["id"])
      redirect_to @item, notice: "ESDA published to remote site"
    else
      redirect_to @item, alert: "Failed to publish: #{response.body}"
    end
  end

private

  def item
    @item ||= params[:id].present? ? Item.find(params[:id]) : Item.new(metadata: {})
  end

  def form
    @form ||= ItemWorkflow.form_for(item:, params:)
  end
end
