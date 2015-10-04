module SiteHelpers

  def page_title
    case @item.identifier
      when /^\/docs/  then "#{ @item[:title] } - PushType Docs"
      when '/'        then @item[:title]
      else "#{ @item[:title] } - PushType"
    end
  end

  def meta_tag(sym)
    %Q(<meta name="#{ sym.to_s }" content="#{ @item[sym] }">) if @item[sym]
  end

  def open_graph(sym)
    %Q(<meta name="og:#{ sym.to_s }" content="#{ @item[:open_graph][sym] }">) if @item[:open_graph][sym]
  end

  def body_class(*args)
    args += @item.identifier.split('/').reject(&:empty?)
    args.empty? ? 'home' : args.join(' ')
  end

  def ficon(sym, text = nil)
    type = sym.to_s.gsub(/_/, '-')
    text = "&nbsp;&nbsp;#{ text }" unless text.nil?
    %Q(<span class="ficon fi-#{ type }">#{ text }</span>)
  end

  def has_comments?
    ENV['RACK_ENV'] == 'production' && @item[:comments]
  end

  def share_manifesto_link(network)
    url, params = case network
    when :facebook
      ['http://www.facebook.com/sharer/sharer.php', {
        t: 'I support the PushType manifesto',
        u: 'http://www.pushtype.org' + @item.identifier,
      }]
    when :twitter
      ['https://twitter.com/intent/tweet', {
        text:     'I support the @pushtype manifesto: inspiring a new generation of #ruby developers with a new generation of CMS',
        url:      'http://www.pushtype.org' + @item.identifier,
        related:  'pushtype,push_code,aaronrussell'
      }]
    end
    "#{ url }?#{ Rack::Utils.build_query params }"
  end

end

