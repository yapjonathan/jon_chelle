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
      duration: 300
      render: (url, $container, $content) ->
        $body.css 'cursor', 'auto'
        $body.find('a').css 'cursor', 'auto'
        $container.html $content
        $('#content').velocity 'transition.shrinkIn' , {easing: 'spring'}
        $('#main').velocity 'scroll'
        render()
        $(window).trigger 'load'
        return

    onStart:
      duration: 300
      render: (url, $container) ->
        $('#content').velocity 'transition.shrinkOut' , {easing: 'spring'}
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

# Toggle Header
toggleHeader = ()->
  activeHeader = () ->
    $('.header').addClass('active')

  _.delay activeHeader, 1000
