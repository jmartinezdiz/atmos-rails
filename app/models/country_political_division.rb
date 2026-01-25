class CountryPoliticalDivision < ApplicationRecord

  ##########################################################
  # RELATIONS
  ##########################################################
  belongs_to :country
  belongs_to :country_political_division_type

  belongs_to :higher_country_political_division, class_name: "CountryPoliticalDivision"

  has_many :lower_country_political_divisions, class_name: "CountryPoliticalDivision", foreign_key: "higher_country_political_division_id"
  has_many :rain_forecasts
  has_many :temperatures_forecasts
  has_many :wind_forecasts

  ##########################################################
  # DECLARATIVE BEHAVIOR
  ##########################################################
  translates :name

  ##########################################################
  # CALLBACKS
  ##########################################################
  before_validation do
    self.country = country_political_division_type&.country
  end

  ##########################################################
  # VALIDATIONS
  ##########################################################
  validates :country, presence: true
  validates :country_political_division_type, presence: true
  validates :code, length: { maximum: 255 }, presence: true
  validates *locale_columns(:name), length: { maximum: 255 }, presence: true

  validate :check_all_relations_have_same_country
  validate :check_all_relations_have_same_higher_country_political_division_type

  ##########################################################
  # PUBLIC INSTANCE METHODS
  ##########################################################
  def add_lower_political_division!(attrs = {})
    new_attrs = attrs.merge(country: country, higher_country_political_division: self)
    self.country_political_division_type.lower_country_political_division_type.country_political_divisions.create!(new_attrs)
  end

  def higher_country_political_divisions
    if higher_country_political_division
      [higher_country_political_division] + higher_country_political_division.higher_country_political_divisions
    else
      []
    end
  end

  ##########################################################
  # PRIVATE INSTANCE METHODS
  ##########################################################
  private

  def check_all_relations_have_same_country
    is_invalid = [
      country,
      country_political_division_type&.country,
      higher_country_political_division&.country,
    ].compact.uniq.many?
    self.errors.add(:base, :country_relations_not_match) if is_invalid
  end

  def check_all_relations_have_same_higher_country_political_division_type
    is_invalid = [
      country_political_division_type&.higher_country_political_division_type,
      higher_country_political_division&.country_political_division_type,
    ].compact.uniq.many?
    self.errors.add(:base, :higher_country_political_division_type_relations_not_match) if is_invalid
  end

end
