json.set! page.url do 
    PageContent.tag_types.keys.each do |tag|
      json.set! tag, page.page_contents.send(tag.to_sym).pluck(:tag_content)
    end
  end