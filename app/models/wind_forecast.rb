class WindForecast < ApplicationRecord

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
  validates :value, numericality: { less_than_or_equal_to: 9999999999999.99, greater_than_or_equal_to: -9999999999999.99 }, presence: true

end
