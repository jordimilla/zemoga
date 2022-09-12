# zemoga test JORDI MILLA


- Architecture used: Clean Architecture
- Architecture pattern in the presentation layer: MVVM
- UI Framework: UIKit
- Persistence Framework: CoreData
- Reactive Framework: Combine


The application is organized in 3 layers in ZemogaPackage provided by SwiftPackageManager:

# Presentation 
Layer contains UI that are coordinated by Presenters/ViewModels which execute 1 or multiple. Presentation Layer depends on Domain Layer.

# Domain Layer 
is the most INNER part of the onion (no dependencies with other layers) and it contains Entities & Repository Interfaces. Use cases combine data from 1 or multiple Repository Interfaces.

# Data Layer 
contains Repository Implementations and multiple Data Sources. Repositories are responsible to coordinate data from the different Data Sources. Data Layer depends on Domain Layer.


I have not wanted to use any third-party library.


# Improvements

- UI: I have focused on the architecture part and not on the visual
- Finish the unit tests I have done a few in each layer.
- Maybe use an object for Data and some mappers inside it to send to Domain
- Use some kind of generic for all use cases

# Requirements & Extra points completed

