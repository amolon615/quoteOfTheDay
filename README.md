# QUOTLY
The app for showing quotes

<img src="[/path/to/img.jpg](https://raw.githubusercontent.com/amolon615/quoteOfTheDay/main/github_cover.png)" alt="Quotly cover imaget" title="Quotly Cover">


Short prject overview:
1. Quotly is build 100% in clean SwiftUI. All requests handled with native Swift instrument (URLSession).
2. Pexels (free images database) was integrated to fetch images for UI improvements. Integration is also 100% native using same URLSession api. (see ImagesLoadingManager for details and comments)
3. No 3rd party code components OR libraries were used.
4. Target iOS version 16.4.
5. Works on any iPhone screen size.
6. Works on xCode 14.3.
7. The app doesn't have any warnings or crashes, errors are propety handled.
8. Quotly works on iOS and iPad (was not optimized for macOS).
9. It was built with a MVVM structure, and test could be implemented easily (both unit & UI).
10. Pagination system is impemented (see QuoteViewModel for details and comments) 
11. Nice (arguable) UI & animations (transitions) added.


Details:
1. App uses NavigationStack and routing system built on it for navigating. See file Router for details
2. App has two different download managers - one for downloading quotes and another one for images.
3. Download manager for fetching quotes is generic function, so it's reused to fetch all quotes and selected quotes when needed.
4. The app has two separate view models for handling operations of getting data and passing it to views.
5. Views are seperated to:
   5.1 ContentView (which is main navigation view), 
   5.2 QuotesListView (contains the list of fetched quotes)
   5.3 QuoteDetailedView (the view with one selected View)
   5.4 Error View (used to display errors - title, solution, image)
   
   and view components: 
   5.5 CellView (one element view for QuotesList)
   5.6 Gradient Background View (contains all animated backgrounds)
   5.7 LoaderViews (contains all loaders animations)




    
