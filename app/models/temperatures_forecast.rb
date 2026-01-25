class TemperaturesForecast < ApplicationRecord

  ##########################################################
  # RELATIONS
  ##########################################################
  belongs_to :country_political_division

  ##########################################################
  # VALIDATIONS
  ##########################################################
  validates :country_political_division, presence: true
  validates :date, presence: true, uniqueness: { scope: [:country_political_division, :measurement_unit] }
  validates :measurement_unit, length: { maximum: 255 }, presence: true
  validates :max_value, :min_value, numericality: { less_than_or_equal_to: 9999999999999.99, greater_than_or_equal_to: -9999999999999.99 }, presence: true

  validate :check_max_value_is_greater_or_equal_to_min_value

  ##########################################################
  # PRIVATE INSTANCE METHODS
  ##########################################################
  private

  def check_max_value_is_greater_or_equal_to_min_value
    if max_value && min_value && max_value < min_value
      self.errors.add(:max_value, I18n.t("errors.messages.greater_than_or_equal_to", count: min_value))
    end
  end

end
