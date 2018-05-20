class User < ApplicationRecord
  PAGE_SIZE = 10

  has_many :group_members
  has_many :transactions
  has_many :data_files

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :by_default, ->(email, is_deleted){email.nil? && is_deleted.nil? ? where(is_deleted: 0) : all }
  scope :by_email, ->(email){ email.blank? ? all : where("email LIKE '%#{email}%'") }
  scope :by_is_deleted, ->(is_deleted){ is_deleted.blank? ? all : where(is_deleted: is_deleted.to_i) }

  def remember_me
    (super == nil) ? '1' : super
    end
end
