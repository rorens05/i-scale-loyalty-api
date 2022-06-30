module ApplicationCable
  class Channel < ActionCable::Channel::Base
    private
    def decoded_token
      if params[:token]
        begin
          JWT.decode(params[:token], 'rorens', true, algorithm: 'HS256')
        rescue JWT::DecodeError
          []
        end
      else
        []
      end
    end

    def session_user
      decoded_hash = decoded_token
      unless decoded_hash.empty?
        user_id = decoded_hash[0]['id']
        @user = User.find_by(id: user_id)
      end
    end
  end
end
