AutoForm.addInputType 'fileUpload',
  template: 'afFileUpload'
  valueOut: ->
    @val()

getCollection = (context) ->
  if typeof context.atts.collection == 'string'
    context.atts.collection = FS._collections[context.atts.collection] or window[context.atts.collection]
  return context.atts.collection

getDocument = (context) ->
  collection = getCollection context
  id = context.value
  collection?.findOne(id)

Template.afFileUpload.onCreated ->
  file = getDocument @data
  @value = new ReactiveVar @data.value
  @filename = new ReactiveVar(file && file.original && file.original.name)
  @url = new ReactiveVar(file && file.url && file.url())

  $(self.firstNode).closest('form').on 'reset', =>
    @value.set null

Template.afFileUpload.helpers
  buttonText: ->
    this.buttonText || 'Choose file'

  value: ->
    Template.instance().value.get()

  filename: ->
    Template.instance().filename.get()

  schemaKey: ->
    @atts['data-schema-key']

  isImage: ->
    @atts.style == 'image'

  noImageText: ->
    @atts.noImageText || 'No Image'

  style: ->
    @atts.style || 'file'

  url: ->
    Template.instance().url.get() || @atts.noImageUrl

Template.afFileUpload.events
  'change [type="file"]': (e, t) ->
    file = e.target.files[0]
    collection = getCollection t.data
    doc = getDocument t.data

    collection.insert file, (err, fileObj) ->
      if err then return console.log err
      if(fileObj && fileObj.data)
        console.log(fileObj)
        t.filename.set(fileObj.data.blob && fileObj.data.blob.name)
      t.value.set fileObj._id
