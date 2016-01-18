productIds = new ReactiveVar()

Template.qrs.onRendered ->
  randomIds = []
  for i in [0...20]
    randomIds.push Random.id()

  @$('textarea').val randomIds.join('\n')
  @$('input').val 'http://YOUR_URL/serial/'

Template.qrs.events
  'click .print' : ->
    window.print()

  'click .generate' : ->
    cleanIds = []
    prefix = $('input').val().trim()
    for code in $('textarea').val().split('\n')
      # remove whitepsace
      if cleanId = code.trim()
        # no duplicates
        if cleanIds.indexOf cleanId is -1
          cleanIds.push "#{prefix}#{cleanId}"
    productIds.set cleanIds

Template.qrs.helpers
  qrCodes: -> productIds.get()

Template.qrCode.onRendered ->
  console.log @data.toString()
  @$('.qr-code').qrcode text: @data.toString()
