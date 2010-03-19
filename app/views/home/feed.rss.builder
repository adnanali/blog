xml.instruct! :xml, :version => "1.0"
xml.rss(:version => "2.0", 
        "xmlns:content" => 'http://purl.org/rss/1.0/modules/content/',
        "xmlns:wfw" => "http://wellformedweb.org/CommentAPI/",
        "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
        "xmlns:slash" => "http://purl.org/rss/1.0/modules/slash/",
        "xmlns:atom" => "http://www.w3.org/2005/Atom"
        ) do
  xml.channel do
    xml.title "jaadu hai"
    xml.description "jaadu hai - tumhare nazroon mein jaadu hai"
    xml.atom :link, :href => feed_url, :rel => "self", :type => "application/rss+xml"
    xml.link root_url
    xml.lastBuildDate @posts.first.created_at.to_s(:rfc822)
    xml.language "en"

    Rails.logger.info "we're in the rss yo!"

    for post in @posts
      xml.item do
        content = raw markdown gfm post.content[:body]
        description = strip_tags(content)[0..200] + "[...]"
        xml.title post.title
        xml.link content_url(post.post_type, post.slug) 
        xml.comments content_url(post.post_type, post.slug) + "/#comments" 
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.dc :creator, post.user.name
        post.categories.each do |category|
          xml.category category
        end
        xml.guid(content_url(post.post_type, post.slug), :isPermalink => false)
        xml.description { xml.cdata! description }
        xml.content(:encoded) { xml.cdata! content }
        xml.wfw :commentRss, comment_feed_url(post.post_type, post.slug)
        xml.slash :comments, post.comment_count
      end
    end
  end
end
