module UserProfileHelper
  def is_private_element?(element_id)
    @user.users_elements.find_by(element_id: element_id).private
  end
end
