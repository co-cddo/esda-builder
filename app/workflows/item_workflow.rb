class ItemWorkflow
  STEPS = {
    title: TitleForm,
    alternative_title: AlternativeTitleForm,
  }.freeze

  def self.form_for(**options)
    new(**options).form
  end

  attr_reader :item, :params

  def initialize(item:, params: {})
    @item = item
    @params = params
  end

  def current_step
    return first_step if item.last_completed_step.blank?

    STEPS.keys[STEPS.keys.index(item.last_completed_step.to_sym) - 1].presence || first_step
  end

  def first_step
    @first_step ||= STEPS.keys.first
  end

  def form
    STEPS[current_step].new(item:, params:)
  end
end
