
subscription =
  setupForm: ->
    $('form#new_user').submit ->
      form = $(this)
      $('input[type=submit]').attr('disabled', true)
      if form.find('input.card-number').length
        subscription.processCard()
        false
      else
        true

  processCard: ->
    form = $('form#new_user')
    card =
      number: form.find('input.card-number').val()
      cvc: form.find('input.card-cvc').val()
      expMonth: form.find('input.card-expiry-month').val()
      expYear: form.find('input.card-expiry-year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('input#user_stripe_card_token').val(response.id)
      $('form#new_user')[0].submit()
    else
      $('#stripe-errors').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)

$(document).ready ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()
