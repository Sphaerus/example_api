# frozen_string_literal: true

module Repository
  class User
    def find!(user_id)
      ::User.find_by!(id: user_id)
    rescue ActiveRecord::RecordNotFound
      raise ResourceNotFound, 'User not found'
    end
  end
end
