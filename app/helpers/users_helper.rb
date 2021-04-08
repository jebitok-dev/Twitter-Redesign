module UsersHelper
  def attach_files(s3_service)
    bucket_path_photo = "jakes/#{File.basename(params[:user][:photo].original_filename)}"
    bucket_path_coverimage = "jakes/#{File.basename(params[:user][:coverimage].original_filename)}"

    s3_file_photo = s3_service.bucket('ror-capstone').object(bucket_path_photo)
    s3_file_coverimage = s3_service.bucket('ror-capstone').object(bucket_path_coverimage)

    s3_file_photo.upload_file(params[:user][:photo].path, acl: 'public-read')
    s3_file_coverimage.upload_file(params[:user][:coverimage].path, acl: 'public-read')

    @user.photo = s3_file_photo.public_url.to_s
    @user.coverimage = s3_file_coverimage.public_url.to_s
  end

  def upload_to_s3
    response = {JSON_KEY_STATUS_MESSAGE: "OK", server_time: DateTime.current.to_i}
    response[:user] = []
    response[:status] = '0'

    unless params[:avatar].present?
        response[:message] = 'either user avatar image file [avatar]'
        render json: response and return
    end

    begin
        user = User.new # create new user
        user.avatar = params[:avatar] # params[:avatar] is a file posted by form in mutli-part true over json api
        s = user.save # save it # will through error if you have more than one required attributes
        if(s != false)
            response[:message] = 'file Successfully upload to s3'
        else
            response[:message] = 'fail to upload file to s3'
        end
      rescue => e
          response[:message] = e.message # this guy will help debug a lot!
      end
      render json: response and return
  end
end
