class PopHealthRouter extends Backbone.Router
  initialize: ->
    # categories is defined globally in view
    @categories = new Thorax.Collections.Categories categories, parse: true
    @view = new Thorax.LayoutView el: '#container'

  routes:
    '':                                 'dashboard'
    'measures/:id(/:sub_id)/patient_results':  'patientResultsForMeasure'
    'measures/:id(/:sub_id)':           'measure'
    'patients/:id':                     'patient'
    'providers/:id':                    'provider'

  dashboard: ->
    @view.setView new Thorax.Views.Dashboard collection: @categories

  measure: (id, subId) ->
    console?.log 'measure!'

  patientResultsForMeasure: (id, subId) ->
    measure = @categories.findMeasure(id, subId)
    if measure?
      @view.setView new Thorax.Views.PatientResultsView query: measure.get('query')
    else
      console?.log 'Measure not found'

  patient: (id) ->
    patientRecord = new Thorax.Models.Patient '_id': id
    # TODO Handle 404 case
    @view.setView new Thorax.Views.PatientView model: patientRecord

  provider: (id) ->
    providerModel = new Thorax.Models.Provider '_id': id
    # TODO Handle 404 case
    @view.setView new Thorax.Views.ProviderView model: providerModel

new PopHealthRouter()
Backbone.history.start()
