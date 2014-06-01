Meteor.startup(
  =>
    configureCompanies()
)


configureCompanies = ->
  for companyKey, company of Meteor.settings.companies
    do(companyKey, company) ->
      firebase = configureFirebase(Meteor.settings.firebase, companyKey)
      configure(firebase, company.beacons, "beacons")
      configure(firebase, company.products, "products")
      configure(firebase, company.locations, "locations")


configureFirebase = (firebaseConfig, companyKey) ->
  firebasePath = "#{firebaseConfig.root}/companies/#{companyKey}"
  firebase = new Firebase(firebasePath)
  if firebaseConfig.forceReset?
    firebase.remove()
  firebase


configure = (firebase, hash, type) ->
  for key, value of hash
    do(key, value) ->
      ref = firebase.child("/#{type}/#{key}")
      ref.set(value)
