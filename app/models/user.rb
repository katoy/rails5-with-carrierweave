class User < ApplicationRecord
  mount_uploader :image, ImagesUploader
end
