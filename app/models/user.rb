class User < ApplicationRecord
  validates :uid, format: { with: /\A[A-Za-z0-9]{1,32}\z/ }, uniqueness: true
end
