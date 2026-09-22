# In-Class Activity 04 — Viral Content Studio

## Team Members

**Het Jani**
Panther ID: 002826152

**Rohan Reddy Gosangi**
Panther ID: 002845899

## Build Challenge

### Theme

**Viral Content Studio**

This Flutter application simulates engagement on a social media post. Users can like, comment, share, and save a post. Each interaction increases the engagement score and updates the interface in real time.

## State Variables

* `int likes` — tracks the number of likes.
* `int comments` — tracks the number of comments.
* `int shares` — tracks the number of shares.
* `int saves` — tracks the number of saves.
* `int streak` — tracks the number of engagement actions performed.
* `bool isTrending` — determines whether Trending Mode is active.
* `String lastAction` — displays the most recent user interaction.
* `bool isDarkMode` — controls the global light/dark theme.

## Engagement Scoring

* Like = **+1 point**
* Comment = **+2 points**
* Share = **+3 points**
* Save = **+2 points**

## Special Condition

When the total engagement score reaches **20 points**, the application activates **Trending Mode**.

When Trending Mode activates:

* A **TRENDING 🔥** banner appears.
* The application background changes.
* The engagement progress meter reaches its goal.
* The interface displays that the post is trending.

## Flutter Concepts Used

* `StatelessWidget`
* `StatefulWidget`
* `setState()`
* `Gest
