class Page < ActiveRecord::Base
  has_many :page_contents, dependent: :destroy
  validates :url, presence: true, uniqueness: {message: 'is already scrapped!'}
  accepts_nested_attributes_for :page_contents
end
