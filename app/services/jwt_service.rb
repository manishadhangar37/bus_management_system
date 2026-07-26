class JwtService
    def generate_token(user)
        token = JWT.encode(
            {
            user_id: user.id,
            exp: 24.hours.from_now.to_i
        },
        Rails.application.secret_key_base,
        "HS256")

    
    end
end
