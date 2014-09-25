Meteor.startup(
  =>
    console.log("We have company")
    configureCompanies()
    console.log("All done. Press Ctrl-C to exit")
)

configureCompanies = ->
  console.log("Preparing:", Meteor.settings.companyFiles)

  firebaseConfig = Meteor.settings.firebase
  firebasePath = "#{firebaseConfig.root}/companies"
  console.log("firebase path:", firebasePath)
  firebase = new Firebase(firebasePath)
  firebase.auth firebaseConfig.rootSecret, Meteor.bindEnvironment (error, result) ->
    if error
      console.error('Login Failed!', error)
    else
      console.info('Authenticated successfully with payload:', result.auth)
      console.info('Auth expires at:', new Date(result.expires * 1000))

      if firebaseConfig.forceReset?
        firebase.remove()

      for companyFile in Meteor.settings.companyFiles
        console.log("Writing...", firebaseConfig, companyFile)
        file = Assets.getText(companyFile)
        company = JSON.parse(file)

        firebase.push(company)
