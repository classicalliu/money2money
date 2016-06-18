# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  panels = $('.user-infos')
  panelsButton = $('.dropdown-user')
  panels.hide()

  # Click dropdown
  panelsButton.click ->
    dataFor = $(this).attr('data-for')
    idFor = $(dataFor)

    currentButton = $(this)
    idFor.slideToggle 400, ->
      if idFor.is(':visible')
        currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>')
      else
        currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>')


  $('[data-toggle="tooltip"]').tooltip()

  $('button').click (e)->
    e.preventDefault()
    alert('This is a demo.\n :-')