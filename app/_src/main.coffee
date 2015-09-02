(($) ->
  methods =
    init: (options) ->
      render()

  render = ->
    toggleHeader()
    scrollAnimate()
    backgroundVideo()

  # Toggle Header
  toggleHeader = ->
    $('.header.full').addClass('active')

  scrollAnimate = (e) ->
    $('.js-nav-link').unbind('click').bind 'click', (e) ->
      e.preventDefault()
      $current = $(e.currentTarget)
      target = $current.attr('href')
      $(target).velocity 'scroll', {easing: 'easeInOutBack'}

  backgroundVideo = ->
    $('#bg-vid').vide
      mp4: '/img/bg-cover'
      webm: '/img/bg-cover'
      ogv: '/img/bg-cover'
      poster: '/img/bg-cover'
    ,
      posterType: 'jpg'
      mute: true
      loop: true
      position: '50% 50%'

  $.fn.payload = (methodOrOptions) ->
    if methods[methodOrOptions]
      return methods[methodOrOptions].apply(this, Array::slice.call(arguments, 1))
    else if typeof methodOrOptions == 'object' or !methodOrOptions
      # Default to "init"
      return methods.init.apply(this, arguments)
    else
      $.error 'Method ' + methodOrOptions + ' does not exist on jQuery.payload'

) jQuery

(($) ->
  'use strict'
  $body = $('html, body')
  $main = $('#main')
  $content = $('#content')
  options =
    onReady:
      duration: 600
      render: ($container, $content) ->
        $body.css 'cursor', 'auto'
        $body.find('a').css 'cursor', 'auto'
        $container.html $content
        $('#content').velocity 'transition.fadeIn' , {easing: 'spring'}
        $('.header').velocity 'transition.slideDownIn' , {easing: 'spring'}
        $('#main').velocity 'scroll'
        return
    ,
    onStart:
      duration: 600
      render: ($container) ->
        smoothState.restartCSSAnimations()
        $('.header').velocity 'transition.slideUpOut' , {easing: 'spring'}
        $('#content').velocity 'transition.fadeOut' , {easing: 'spring'}
        return
    ,
    onAfter: ($container, $content) ->
      $main.payload().render
      return

  smoothState = $('#main').smoothState(options).data('smoothState')

  $.fn.smoothStateStart = () ->
    $(this).smoothState(options).data('smoothState')
) jQuery

# Document Ready
$(document).ready ->
  $('body').payload().render
