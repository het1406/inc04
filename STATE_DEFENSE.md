# State Defense Summary

## Team Members
Het Jani — Panther ID: 002826152  
Rohan Reddy Gosangi — Panther ID: 002845899

## 1. What widgets are Stateless and why?

StudioHeader, MetricBadge, and TrendingBanner are StatelessWidgets.

They only receive information from their parent and display it. They do not own or modify any mutable state themselves.

## 2. What widgets are Stateful and what state do they own?

ViralStudioApp is Stateful because it owns the global `isDarkMode` variable.

ViralContentScreen is Stateful because it owns the main application state:
- likes
- comments
- shares
- saves
- streak
- isTrending
- lastAction

TactileActionButton is Stateful because every button owns its own private `isPressed` variable.

Keeping `isPressed` local prevents pressing one button from visually pressing every other button.

## 3. Where is setState() used?

`setState()` is used whenever mutable data changes.

In ViralContentScreen, it updates engagement values such as likes, comments, shares, saves, streak, the last action, and Trending Mode.

In TactileActionButton, `setState()` updates the private `isPressed` value during `onTapDown`, `onTapUp`, and `onTapCancel`.

In ViralStudioApp, `setState()` changes `isDarkMode` when the theme button is pressed.

## 4. What rebuilds when setState() is called?

Calling `setState()` marks that State object's element as dirty.

Flutter schedules that widget's build method to run again, which rebuilds the affected widget subtree with the updated values.

It does not restart the entire application.

## 5. How does GestureDetector work in our app?

`onTapDown` changes `isPressed` to true and creates the tactile pressed effect.

`onTapUp` changes `isPressed` back to false and then triggers the button action.

`onTapCancel` restores `isPressed` to false if the gesture is interrupted.

## 6. What condition changes the interface?

The engagement score is calculated using:

Like = +1  
Comment = +2  
Share = +3  
Save = +2

When the engagement score reaches 20 points, `isTrending` becomes true.

This causes the TRENDING banner to appear and changes the background of the application.

## 7. How is the theme state lifted?

The root ViralStudioApp owns `isDarkMode`.

It passes the current theme value and a callback function to ViralContentScreen.

The child can request a theme change through the callback while the parent remains the single source of truth for the global theme.
