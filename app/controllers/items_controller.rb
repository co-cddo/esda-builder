class ItemsController < ApplicationController
  STEPS = {
    title: TitleForm,
    alternative_title: AlternativeTitleForm,
  }.freeze

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
    @item ||= params[:id].present? ? Item.find(params[:id]) : Item.new(metadata: {})
  end

  # Only allow a list of trusted parameters through.
  # REMOVE - params handled by form - so remove
  def item_params
    params.require(:item).permit(:title, :metadata, :name)
  end

  def form
    @form ||= STEPS[step.to_sym].new(item:, params:)
  end

  def step
    return STEPS.keys.first if item.last_completed_step.blank?

    STEPS.keys[STEPS.keys.index(item.last_completed_step.to_sym) - 1].presence || STEPS.keys.first
  end
end
