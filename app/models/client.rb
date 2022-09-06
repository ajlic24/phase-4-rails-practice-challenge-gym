class Client < ApplicationRecord
    has_one :membership
    has_many :gyms, through: :memberships

    validates :name, presence: true
    validates :age, presence: true, numericality: {only_integer: true}
end
