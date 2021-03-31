module UsersHelper
  def attach_files(s3_service)
    bucket_path_photo = "jakes/#{File.basename(params[:user][:photo].original_filename)}"
    bucket_path_coverImage = "jakes/#{File.basename(params[:user][:coverImage].original_filename)}"

    s3_file_photo = s3_service.bucket('ror-capstone').object(bucket_path_photo)
    s3_file_coverImage = s3_service.bucket('ror-capstone').object(bucket_path_coverImage)

    s3_file_photo.upload_file(params[:user][:photo].path, acl: 'public-read')
    s3_file_coverImage.upload_file(params[:user][:coverImage].path, acl: 'public-read')

    @user.photo = s3_file_photo.public_url.to_s
    @user.coverImage = s3_file_coverImage.public_url.to_s
  end
end
