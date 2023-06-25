# QUOTLY
The app for showing quotes

![alt text](https://raw.githubusercontent.com/amolon615/quoteOfTheDay/main/github_cover.png)

Short project overview
1. Quotly is build 100% in clean **SwiftUI**. All requests handled with native Swift instrument (**URLSession**).
2. Pexels (free images database) was integrated to fetch images for UI improvements. Integration is also 100% native using same URLSession api. (see **ImagesLoadingManager** file for details and comments)
3. No 3rd party code components OR libraries were used.
4. Target iOS version **16.4**.
5. Works on any iPhone screen size.
6. Works on **xCode 14.3**.
7. The app doesn't have any warnings or crashes, errors are propety handled.
8. Quotly works on iOS and iPad (was not optimized for macOS).
9. It was built with a **MVVM** structure, and tests could be implemented easily (both unit & UI).
10. Pagination system is impemented (see **QuoteViewModel** for details and comments) 
11. Nice (**arguable**) UI & animations (transitions) added.


Details:
1. App uses NavigationStack and routing system built on it for navigating. See file Router for details
2. App has two different download managers - one for downloading quotes and another one for images.
3. Download manager for fetching quotes is generic function, so it's reused to fetch all quotes and selected quotes when needed.
4. The app has two separate view models for handling operations of getting data and passing it to views.

File Structure:

1. Router - manages navigation & dependancy injections
2. Managers -  QuotesLoadingManager (loads quotes) and  ImagesLoadingManager (loads images from Pexel)
3. DataModels - contains all data structures - Quotes, Quote, Images, Errors
4. ViewModels - QuoteViewModel(manages all quotes ops and passing data to Views) and ImagesViewModel ( manages all images ops and passing loaded image urls to Views.)
5. Views (Content View, QuotesListView, QuoteDetailedView, Error View) and View Components (CellView, Gradient, LoaderViews)
   




    
