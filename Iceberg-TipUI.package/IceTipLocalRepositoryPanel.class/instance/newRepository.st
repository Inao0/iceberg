accessing
newRepository
	UIManager default 
		informUser: ('Adding repository {1}' format: { self location fullName })
		during: [ 
			^ IceRepositoryCreator new 
				location: self location;
				subdirectory: self subdirectory;
				createRepository ]