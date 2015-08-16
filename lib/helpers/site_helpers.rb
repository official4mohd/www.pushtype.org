module SiteHelpers

  def meta_tag(sym)
    %Q( <meta name="#{ sym.to_s }" content="#{ @item[:desc] }">) if @item[sym]
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