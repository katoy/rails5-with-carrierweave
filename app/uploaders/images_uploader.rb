class ImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick # 画像トリミングしますよー

  storage :fog # fog使いますよー

  # thumb バージョン(width 400px x height 200px)
  version :thumb do
    process :resize_to_fit => [64, 64]
  end

  # cash使います。
  def fog_attributes
    {
      'Content-Type' =>  'image/jpg',
      'Cache-Control' => "max-age=#{1.week.to_i}"
    }
  end

  # バケット以下アイコンの保存先を指定します。
  # ~/[バケット名]/[foldername]　配下に画像がアップロードされます。
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な形式をここで指定します。
  # ちなみにアップロード不可な形式の指定はextension_black_list
  def extension_white_list
    %w(jpg jpeg png)
  end

  # アップロード時のファイル名を指定します。
  # アップロードしたファイルを一意に認識
  def filename
    return unless original_filename.present?
    "#{Time.now.strftime('%Y%m%d_%H%M%S')}_#{secure_token}.#{file.extension}"
    # "image.#{file.extension}"
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
