class Like < ApplicationRecord
  belongs_to :article, touch: true
end
