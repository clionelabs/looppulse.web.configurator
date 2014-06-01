Meteor.startup(
  =>
    configureCompanies()
)

configureCompanies = ->
  for companyKey, company of Meteor.settings.companies
    do(companyKey, company) ->
      firebase = configureFirebase(Meteor.settings.firebase, companyKey)
      configureBeacons(firebase, company.beacons)
      # configureProducts(firebase, company.products)
      # configureLocations(firebase, company.locations)


configureFirebase = (firebaseConfig, companyKey) ->
  firebasePath = "#{firebaseConfig.root}/companies/#{companyKey}"
  firebase = new Firebase(firebasePath)
  if firebaseConfig.forceReset?
    firebase.remove()
  firebase


configureBeacons = (firebase, beacons) ->
  for beaconKey, beacon of beacons
    do(beaconKey, beacon) ->
      beaconRef = firebase.child("/beacons/#{beaconKey}")
      beaconRef.set(beacon)
