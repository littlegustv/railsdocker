class Article < ApplicationRecord
  searchable do
    text :title
    string :title
    text :author
    string :author
    text :text
  end
end
