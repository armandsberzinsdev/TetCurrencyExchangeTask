# Tet Currency Exchange Task
![alt text](https://raw.githubusercontent.com/armandsberzinsdev/TetCurrencyExchangeTask/master/Screenshots/iconImage.JPG)

This is Tet job applicants challenge task done by Armands. Even the app is quite simple it has some features for better user experience, improved maintainability and made to be easily scalable. App was made in one week on late evenings after work so it's hard to tell how many actually hours spent on this. Nevertheless, apps works fine and there are many great things about it. There are still many places I would like to improve and some bugs can be found but as far as I can see no matter how good this project would become I would still see a room for improvement even if it would exceed requirements too much. More about possible improvements see Features section.

![alt text](https://raw.githubusercontent.com/armandsberzinsdev/TetCurrencyExchangeTask/master/Screenshots/stickedTogetherTet.jpg)

### Clone and branching:
GIT is organised by storing release in Master branch. Master branch is supposed to be tested version with passed Unit Tests.
Develop branch - there are some new features, yet develop branch also should be stable with some bugs possible. In other words in develop branch you can get "Beta or RC" versions.
Feature branches - every bigger feature is made in feature branch and there nothing is stable. When the feature development is done, it is merged into develop branch.

When evaluating task you should mainly look on Master branch but also can have look on Develop branch version since there might be some small improvement already but also greater chance on some bug.

### Installation:
Just open the project file with Xcode 10.3 or newer.

### Setup:
No other steps need - project was intended to be easily run. 

### 3rd part libraries:
None

### Features:
Main goal:
App shows currency exchenges rates immediately convertable from EUR and data are updated every second. Select currency are always supposed to be in first row.

### Project architectural pattern: 
Viper is used for this. It is overkill for such simple app since you basically need to make 4-6 files instead of 1 (for MVC) or 2 (for MVVM) and that definitely takes more time. But I chouse to use this because by making app on this pattern app will easily testable and scalable what I found to be important here since in real life this app my grow too many features (and I want to show that I know VIPER :)) MVVM would have done the trick here and saved some time while MVC is more awkward for Unit Tests. Unfortunatley all code done in rush in last 2 days made add more code in ViewController and some par need to be refactored to Presneter.

### Test Driven Development:
In the beginning I stated development with tests and then made functions like the best TDD practices would say but at some point I understand that I also want to mange to add features I have planned so I started to make functionality without covering them with tests immediately. On good side - Network Manger, main Interactor and Presenter core functionality is covered with lot unit tests. There should be more tests especially to cover last 2 days work. No UI Tests yet.

### Network handling, Reachability:
Every network call must go through Network Manager. Request response with success handler or error handler and returns data in class model format already. Before every call Reachability manager checks is device even online and request can be made. In case of unreachable error is shown. Interactor is responsible not to send data to the Presenter-UI if lately fetched data does not have any change.

### Offline mode / Local storage: 
Fetched data is also saved so you can still do currency converting if you are offline or with bad network. Considering that not all data must be saved for offline mode, saving should be called on Interactors and not in Network manager. Right now it just saves data as JSON data in documents folder but this should be refactored to CoreData. Since offline mode was one of the last features added I decided not to go with this that can cause issues if something goes wrong and go with safer flow. Saving fails if such would happen wont be shown to user since user does not even know something is saved.

### Error handling:
Errors that can be useful if user sees them are shown with alert view. Many other places has errors for console but also its considered that something should returned nearly always. For example, if there would be some issues with data, then empty data would be returned and not nil by ideology that better show empty with error alert than not return anything that could cause crash or something unpredictable. 


### User interface:
Given design parameters in task was made as UI Components to easier adapt them in View files and to provide consistent changes if designer would request. For custom cells I've used StackViews since that provide auto-layout in decreses for constraints. App has sepretaded extensions for UIColor and UIFont for better theming across the app. Views looks good on all iPhones, works well on iPads meanwhile I would plan to redesign iPad to more Master-Detail view design like Mail app. App also has Icon and Launch Screen.




