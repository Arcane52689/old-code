class PostSub < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub
end
