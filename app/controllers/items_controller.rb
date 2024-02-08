class ItemsController < ApplicationController
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
    initial_form
  end

  # GET /items/1/edit
  def edit
    item
  end

  # POST /items
  def create
    form = initial_form

    if form.save
      redirect_to item_url(form.item), notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if item.update(item_params)
      redirect_to item_url(@item), notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    item.destroy!
    redirect_to items_url, notice: "Item was successfully destroyed."
  end

private

  def item
    @item ||= params[:id].present? ? Item.find(params[:id]) : Item.new
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :metadata, :name)
  end

  def initial_form
    item = Item.new(metadata: {})
    @form = TitleForm.new(item:, params:)
  end
end
