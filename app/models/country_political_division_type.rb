class CountryPoliticalDivisionType < ApplicationRecord

  ##########################################################
  # RELATIONS
  ##########################################################
  belongs_to :country
  belongs_to :higher_country_political_division_type, class_name: "CountryPoliticalDivisionType"

  has_one :lower_country_political_division_type, class_name: "CountryPoliticalDivisionType", foreign_key: "higher_country_political_division_type_id"

  has_many :country_political_divisions, dependent: :destroy

  ##########################################################
  # DECLARATIVE BEHAVIOR
  ##########################################################
  translates :name

  ##########################################################
  # VALIDATIONS
  ##########################################################
  validates :country, presence: true
  validates :higher_country_political_division_type, uniqueness: { scope: :country }
  validates *locale_columns(:name), length: { maximum: 255 }, uniqueness: { scope: :country }, presence: true

  validate :check_all_relations_have_same_country

  ##########################################################
  # PRIVATE INSTANCE METHODS
  ##########################################################
  private

  def check_all_relations_have_same_country
    is_invalid = [
      country,
      lower_country_political_division_type&.country,
      higher_country_political_division_type&.country,
    ].compact.uniq.many?
    self.errors.add(:base, :country_relations_not_match) if is_invalid
  end

end
