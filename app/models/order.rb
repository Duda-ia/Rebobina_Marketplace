class Order < ApplicationRecord
  belongs_to :user_id
  belongs_to :product_id
end
