This example shows a single event method, rather than separate methods for each event.

Advantages:
   Fewer methods
   Easy to add a new event (transition). You don't have to add a new method.

Disadvantages:
   Have switch statement or if-statements in each State's method.

Use:
   Probably best in sparse handling of events (i.e., most states handle only one or two events, and ignore the rest.)


Teaching:
   Show how easy it is to add a new event (transition). Add a "Revive" event.

Notes to point out:
  You could make the Events into classes too. It may or may not be worth the trouble.


It also shows single state objects applying to multiple context objects. The state objects are singletons.
