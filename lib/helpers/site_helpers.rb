module SiteHelpers

  def page_title
    case @item.identifier
      when /^\/docs/  then "#{ @item[:title] } - PushType Docs"
      when '/'        then @item[:title]
      else "#{ @item[:title] } - PushType"
    end
  end

  def meta_tag(sym)
    %Q( <meta name="#{ sym.to_s }" content="#{ @item[sym] }">) if @item[sym]
  end

  def body_class(*args)
    args += @item.identifier.split('/').reject(&:empty?)
    args.join(' ')
  end

  def ficon(sym, text = nil)
    type = sym.to_s.gsub(/_/, '-')
    %Q(<span class="ficon fi-#{ type }">#{ text }</span>)
  end

  def has_comments?
    ENV['RACK_ENV'] == 'production' && @item[:comments]
  end

end