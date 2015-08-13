#= require jquery/dist/jquery

jQuery ($) ->

  $('[data-nav-toggle]').click (e) ->
    e.preventDefault()
    $('body').toggleClass 'nav-active'
  $('[data-nav-overlay]').click (e) ->
    $('body').removeClass 'nav-active'