class Metric < ApplicationRecord

  attribute :name, :string
  attribute :value, :float
  attribute :valid_at, :datetime
end
