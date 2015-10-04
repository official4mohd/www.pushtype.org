#= require jquery/dist/jquery

jQuery ($) ->

  $('[data-nav-toggle]').click (e) ->
    e.preventDefault()
    $('body').toggleClass 'nav-active'
  $('[data-nav-overlay]').click (e) ->
    $('body').removeClass 'nav-active'

  $('.mn-cta .button').click (e) ->
    e.preventDefault()
    window.open $(this).attr('href'), 'blank', 'width=640,height=480,left=500,top=300'