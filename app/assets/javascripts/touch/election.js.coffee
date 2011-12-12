class window.VoxeElection
  
  constructor: (options)->    
    window.app = {models: {}, collections: {}, views:{}}
    
    app.models.election = new ElectionModel()
    app.models.theme = new ThemeModel()
    
    app.collections.candidates = new CandidatesCollection()
    app.models.election.bind 'change', (election)=>
      app.collections.candidates.add election.get('candidates')
    
    app.collections.selectedCandidates = new CandidatesCollection()
    app.collections.propositions = new PropositionsCollection()
    
    app.views.application = new ApplicationView(el: "#application-view")
    app.views.navigation = new NavigationView(el: "#navigation-view")

    app.views.candidatesList = new CandidatesListView(el: "#candidates-list")
    app.views.themesList = new ThemesListView(el: "#themes")
    app.views.propositions = new PropositionsView(el: "#propositions")    

    app.router = new AppRouter()
    app.router.candidatesList()

    app.views.navigation.push 'themes'
    
    console.log options.election
    app.models.election.set options.election