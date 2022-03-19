class Helpers
    def self.is_logged_in?(session)
        current_user(session) ? true : false
    end

    def self.current_user(session)
        @user = User.find_by_id(session[:user_id])
    end
end