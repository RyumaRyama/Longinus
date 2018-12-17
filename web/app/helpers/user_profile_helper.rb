module UserProfileHelper
  # 空白文字の削除
  def remove_white_spaces(element)
    element.name.gsub(/(\s|　)+/, '').downcase
  end
end
