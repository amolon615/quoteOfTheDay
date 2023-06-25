# QUOTLY
The app for showing quotes

![alt text](https://raw.githubusercontent.com/amolon615/quoteOfTheDay/main/Quotly_Screenshots/Meet_Quotly.png)



Short project overview
1. Quotly is built 100% in clean **SwiftUI**. All requests handled with native Swift instrument (**URLSession**). 
2. Pexels (free images database) was integrated to fetch images for UI improvements. Integration is also 100% native using same URLSession api. (see **ImagesLoadingManager** file for details and comments)
3. No 3rd party code components OR libraries were used.
4. Target iOS version **16.4**.
5. Works on any iPhone screen size.
6. Works on **xCode 14.3**.
7. Continue after the image :)

![alt text](https://raw.githubusercontent.com/amolon615/quoteOfTheDay/main/Quotly_Screenshots/Select.png)

7. The app doesn't have any warnings or crashes, fetching quotes errors are properlyy handled (Only connection & bad server response provide with actionable button to reload. badURL and badDecoding are handled and notifying developer to check data-structre or url-building function. Actual user will see them only if JSON-schema is changed on the servers.)
8. Quotly works on iOS and iPad (was not optimized & tested for macOS).
9. It was built with a **MVVM** structure, and tests could be implemented easily (both unit & UI).
10. Pagination system is impemented (see **QuoteViewModel** for details and comments) 
11. Nice (**arguable**) UI & animations (transitions) added. 
12. Added share quote function to the detaield quote screen.
    


![alt text](https://raw.githubusercontent.com/amolon615/quoteOfTheDay/main/Quotly_Screenshots/Share%20With%20Friends.jpg)


Details:
1. App uses NavigationStack and routing system built on it for navigating and dependency injections. See (file Router for details)
2. App has two different download managers - one for downloading quotes and another one for images.
3. Download manager for fetching quotes is generic function, so it's reused to fetch all quotes and just selected quote when needed.
4. The app has two separate view models for handling operations of getting data and passing it to views.
5. Animations were built as reusable components (including loaders, button animations, transitions).

File Structure:
1. Router - manages navigation & dependancy injections
2. Managers -  QuotesLoadingManager (loads quotes) and  ImagesLoadingManager (loads images from Pexel)
3. DataModels - contains all data structures - Quotes, Quote, Images, Errors
4. ViewModels - QuoteViewModel(manages all quotes ops and passing data to Views) and ImagesViewModel ( manages all images ops and passing loaded image urls to Views.)
5. Views (Content View, QuotesListView, QuoteDetailedView, Error View) and View Components (CellView, Gradient, LoaderViews)

Possible next steps for improvements:
1. Add bookmarks
2. Implement openAI API to get a category for each quote and fetch Image for a cell based on its category
3. Add widgets (for iOS 17 add a button to load a new quote to a widget right from the homescreen.)
4. Implement UI & Unit tests
   

   
   




    
