Meteor.startup(
  =>
    console.log("We have company")
    configureCompanies()
    console.log("All done. Press Ctrl-C to exit")
)


configureCompanies = ->
  console.log("Preparing.")
  for companyKey, company of Meteor.settings.companies
    # do(companyKey, company) ->
      console.log("Writing...", Meteor.settings.firebase, companyKey)
      firebase = configureFirebase(Meteor.settings.firebase, companyKey)
      firebase.set(company)


configureFirebase = (firebaseConfig, companyKey) ->

  firebasePath = "#{firebaseConfig.root}/companies/#{companyKey}"
  console.log("firebase path:", firebasePath)
  firebase = new Firebase(firebasePath)
  if firebaseConfig.forceReset?
    firebase.remove()
  firebase
