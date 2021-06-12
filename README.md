# insta_flutter

A Flutter app that tries to clone the instagram UI for posts and comments.

## Packages Used

http: ^0.13.3
provider: ^5.0.0
shared_preferences: ^2.0.6
font_awesome_flutter: ^9.1.0

## Details

The app uses provider package for state management. The logic for fetching posts and comments are inclued in the Posts provider(lib/providers/Posts.dart). The user can bookmark posts and the bookmarked posts will be saved locally so that even if the app restarts the user can access this list. The bookmarked posts are stored as json String using shared_preferences package. The bottom navigation bar has two buttons which will allow the user to navigate to the home page or the bookmarks page.
