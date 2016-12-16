class PageContent < ApplicationRecord
  enum tag_type: {h1: 1, h2: 2, h3: 3, link:4}
  belongs_to :page
end
