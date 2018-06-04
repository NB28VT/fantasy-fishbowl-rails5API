class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :jwt_authenticatable

    # Skip for now. Consider in future http://waiting-for-dev.github.io/blog/2017/01/23/stand_up_for_jwt_revocation/
    jwt_revocation_strategy: JWTBlacklist

end
