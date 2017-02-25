class User < ApplicationRecord
  mount_uploader :image, ImagesUploader
  mount_uploader :icon, IconUploader
end
