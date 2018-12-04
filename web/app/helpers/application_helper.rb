module ApplicationHelper
  # 参考サイト https://qiita.com/satoken0417/items/df4098a122d05d69a3e6
  require "uri"
  def text_url_to_link(text)
    URI.extract(text, ['https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end
end
