# PLAYLiST
Welcome to PLAYLiST!

This is an attempt to integrate several music streaming platforms into a single native iOS SwiftUI application.
This is a personal project, and I haven't made progress in a while, so this is heavily a work in progress.

Currently working on implementing YouTube and Spotify into the application.

## Current state
* Users are now able to create playlists
* They can add YouTube videos and Spotify tracks by their identifiers
* These tracks and videos are playable if the users taps on them

## Get it working
To get this project working, you'll need to create an application on the Spotify Developer Dashboard, get the client ID, and set the redirect URI. Once that's done, you need to create a bridging header, so the Objective-C Spotify framework libraries can be used in the application. For all of these steps I recommend checking out [this](https://medium.com/@brianhans/getting-started-with-the-spotify-ios-sdk-435607216ecc) article.

With these done, if the client ID and the redirect URI are set, the application should work in it's current form.

## Pictures
Some pictures of the current state of the application.

<img src="https://github.com/Horikecske/PLAYLiST_iOS/blob/master/screenshots/IMG_3333.PNG" height="500" />
<img src="https://github.com/Horikecske/PLAYLiST_iOS/blob/master/screenshots/IMG_3334.PNG" height="500" />
<img src="https://github.com/Horikecske/PLAYLiST_iOS/blob/master/screenshots/IMG_3335.PNG" height="500" />
<img src="https://github.com/Horikecske/PLAYLiST_iOS/blob/master/screenshots/IMG_3336.PNG" height="500" />



