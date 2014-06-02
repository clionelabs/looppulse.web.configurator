Meteor.startup(
  =>
    configureCompanies()
)


configureCompanies = ->
  for companyKey, company of Meteor.settings.companies
    do(companyKey, company) ->
      firebase = configureFirebase(Meteor.settings.firebase, companyKey)
      firebase.set(company)


configureFirebase = (firebaseConfig, companyKey) ->
  firebasePath = "#{firebaseConfig.root}/companies/#{companyKey}"
  firebase = new Firebase(firebasePath)
  if firebaseConfig.forceReset?
    firebase.remove()
  firebase
