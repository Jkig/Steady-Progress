# Current todo (final big test data and then set up for read data):
* a little bit more testing with synthetic data to make sure smoothing helps spot slow weight change, and compare 10 days - 14 days? Maybe get rid of 14 days?
* have nick, zo, ben, maybe one more check to see if it looks good, then get rid of this datatype/set of synthetic data


* change Model to use correct date type (down to hour, maybe day), and try to use index in data as ID instead of UUID?, this would speed up lots of operations (may not be too important, but shouldn't take long)
* add measurement: Do nothing if the most recent was within the same hour.(maybe day?). Build to standard I set in Model, send them error
* store User data on device


# next things/ easy things:
* if settings change, I need to refresh the main page. Ex toggle show Goal
* allow adjusting goal (will basically be an easier copy of adding values)
* finally deleting old data (follows from adding values)
* finish personal data stuff
* go through each value and make sure it is displayed correctly


# From the above things, the MVP is ready. Release ASAP and get users trying it
* and chat with some people about how to make the posting look good


# Bigger/later things
* do the projections for true weight and true start weight
* Data stored with Firebase probably
* Sign in with google and apple, leave it there for now
* longer projections, and showing a goal weight change line
* graphs of progress over time
* ask users what they want
