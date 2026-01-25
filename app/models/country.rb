class Country < ApplicationRecord

  ##########################################################
  # RELATIONS
  ##########################################################
  has_many :country_political_division_types, dependent: :destroy
  has_many :country_political_divisions, dependent: :destroy

  ##########################################################
  # DECLARATIVE BEHAVIOR
  ##########################################################
  translates :name

  ##########################################################
  # VALIDATIONS
  ##########################################################
  validates :alpha3_code, length: { maximum: 3 }, presence: true, uniqueness: true
  validates *locale_columns(:name), length: { maximum: 255 }, uniqueness: true, presence: true

  ##########################################################
  # PUBLIC INSTANCE METHODS
  ##########################################################
  def higher_country_political_division_type
    country_political_division_types.where(higher_country_political_division_type: nil).first
  end

end
