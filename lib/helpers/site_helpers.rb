module SiteHelpers

  def body_class(*args)
    args += @item.identifier.split('/').reject(&:empty?)
    args.join(' ')
  end

  def ficon(sym, text = nil)
    type = sym.to_s.gsub(/_/, '-')
    %Q(<span class="ficon fi-#{ type }">#{ text }</span>)
  end

end