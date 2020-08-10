# Carsales Challenge App - SwiftUI Version

## The iOS App

### Architecture

MVVM

- Model represents the data
- ViewModel provides the data
- View displays the data


### Development plan

#### Requirement 1

- An API to pull/decode data from the REST endpoint.

##### Fulfilment

- Created the CarsalesAPI Swift Package that handles the above.
- Why a package?
- Because the plan was to create two apps, one with auto-layout and another in SwiftUI. Hence, a shared library was the best approach.
- Why two apps and not just add a SwiftUI version of the UI in the same app?
- For SwiftUI 2.0. It has a few extra APIs that helped in developing the required app.



#### Requirement 2

- Display a list of items with an image and some text.
- Display a single row on an iPhone. 2 or 3 rows on an iPad depending upon the orientation.

##### Fulfilment

- A `LazyVGrid` is the best choice to display a flexible grid of items.
- The `ListImageView` has an embedded `AsyncImageView` that loads the image asynchronously using Combine.
- Rest is just `Text`, `VStack` & `HStack`.
- The empty state is created by using sample data and `redacted` view modifier.

❤️ Building UI in SwiftUI is such a joy!


#### Requirement 3

- Display the details of an item with multiple images scrolling horizontally at the top and some text items to follow.

##### Fulfilment

- The empty state is, again, created by using sample data and `redacted` view modifier.
- The views are laid-out within a `VStack` embedded in a `ScrollView`. Pretty much the same as in the auto-layout version of the app.
- The `PhotoCarousel` is created using a `TabView` with `SyncImageView` embeded in each tab. Added paging support using `PageTabViewStyle()`.

##### Issues
`PhotoCarousel` was a bit tricky because of the paging. It seems that `TabView` does not properly update when its children update. Hence, when the `AsyncImageView` was used inside the tabs, the image would not show until we moved away from the tab and came back. This was not an issue if we used an `HStack` embedded in a `ScrollView`. But that did not give us paging.

So, there was a choice to be made. Have paging but load images synchronously or have a scrolling list of images without paging, but the images load asynchronously. Aesthetics over Performance.

Normally, I would go for performance but in this instance, I went with aesthetics as it just made the view look so pleasing. Also, I'm sure we'll see the bug fixed in a later version of SwiftUI. Or, I might find a workaround if I spend some more time on it.


## The macOS App

### Architecture

MVVM

- Model represents the data
- ViewModel provides the data
- View displays the data


### Development plan

#### Requirement 1 & Fulfilment
Same as the iOS app

#### Requirement 2

- Display a list of items with an image and some text.
- Display a single row on an iPhone. 2 or 3 rows on an iPad depending upon the orientation.

##### Fulfilment
- A grid would not have looked very native on the macOS. Hence, I used left navigation to display the list of cards. And the right details for the car details.
- Rest is just Text, VStack & HStack.

#### Requirement 3

- Display the details of an item with multiple images scrolling horizontally at the top and some text items to follow.

##### Fulfilment

- The views are laid-out within a `VStack` embedded in a `ScrollView`. Pretty much the same as in the auto-layout version of the app.
- The `PhotoCarousel` is created using a `HStack` embedded in a `ScrollView`. And if you remember the issue with the carousel in the iOS App, you'd know that we can download images asynchronously in an `HStack`. So, I did that. Mainly because `TabView` behaves very differently on macOS. But, we did get Performance over Aesthetics, so the world is balanced once again.


### Dependencies

CarsalesAPI
https://github.com/ggndpsinghgit/CarsalesAPI


### How to test

#### Requirements

- Xcode 12 beta 4
- A device running iOS 14 beta 4 or above (Optional)


#### Installation

- Clone the repo
- Open the .xcproject file in Xcode
- The CarsalesAPI Swift Package should automatically update when the project loads. If it does not, you can manually do it by going to File -> Swift Packages -> Update to Latest Package Versions.
 
