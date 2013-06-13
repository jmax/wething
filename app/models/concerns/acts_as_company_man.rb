module ActsAsCompanyMan
  extend ActiveSupport::Concern

  included do
    belongs_to :company

    accepts_nested_attributes_for :company
    delegate :name, to: :company, prefix: true, allow_nil: true

    validates :company, presence: true
  end
end
