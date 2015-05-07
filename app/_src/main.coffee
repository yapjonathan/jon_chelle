(($) ->
  'use strict'
  $body = $('html, body')
  content = $('#main').smoothState(
    prefetch: true,
    development : true,
    pageCacheSize: 4,

    onProgress:
      duration: 300
      render: (url, $container) ->
        $body.css 'cursor', 'wait'
        $body.find('a').css 'cursor', 'wait'
        return

    onEnd:
      duration: 600
      render: (url, $container, $content) ->
        $body.css 'cursor', 'auto'
        $body.find('a').css 'cursor', 'auto'
        $container.html $content
        $('#content').velocity 'transition.fadeIn' , {easing: 'spring'}
        $('.header').velocity 'transition.slideDownIn' , {easing: 'spring'}
        $('#main').velocity 'scroll'
        render()
        $(window).trigger 'load'
        return

    onStart:
      duration: 600
      render: (url, $container) ->
        $('.header').velocity 'transition.slideUpOut' , {easing: 'spring'}
        $('#content').velocity 'transition.fadeOut' , {easing: 'spring'}
        return

  ).data('smoothState')
  # makes public methods available
) jQuery

# Document Ready
$(document).ready ->
  render()

# Render
render = () ->
  toggleHeader()
  scrollAnimate()

# Toggle Header
toggleHeader = ()->
  activeHeader = () ->
    $('.header.full').addClass('active')

  _.delay activeHeader, 600

 scrollAnimate = (e) ->
    $('.js-nav-link').unbind('click').bind 'click', (e) ->
      e.preventDefault()
      $current = $(e.currentTarget)
      target = $current.attr('href')

      console.log target

      $(target).velocity 'scroll', {easing: 'easeInOutBack'}
