# Current working smoothing functions:
* For now using a 14 day moving average, with recent SMA for "true weight"


# Smoothing data:
* there are a few ways I'm thinking of smoothing data, I think maybe the most rigorous may be simple error propagation as we would do in a lab, if we need to have certainty to a certain level, and random measurments from a normal distribution
* but, there are problems here, unless we can tell users to control behavior around measurements to an unrealistic degree, calculating how many days of a SMA to do, or using EMA are just making it feel more scientific than it is.


# A heuristic based scientifc method for smoothing:
* I've personally noticed a 5lbs swing in a day to be about the max
* I'll say based on this we are pulling from a distribution that is roughly normal, with a standard deviation of 2 lbs. 
* we want precision within ~.1-.2 lbs, (as this is roughly the maximum healthy weight loss in a day)
* thus we would need almost 100 measurements to determine the true weight by this method, which is obviously not functional
* if they were measuring with similar water and time of the day circumstances, error probably drops to about half a pound, and 7-10 days becomes really accurate
* now that I think about it, the day to day fluctuations are not IID, the next day is probably largely based on the day before, so maybe we have to take something like 10-14 days, maybe removing the 2 most extreme values (as after a day of eating a lot, they probably eat less)?
* from simulated data, 10-20 days works really well, with their own positives and downsides. I'm working with 14 for now


# Extra notes on smoothing
* if people are trying to lose or gain weight, more smoothing also hurts the feeling of progress, as if they are actually (for this example, trying to lose weight at 1 lbs per 5 days) losing weight, then adding day x-6:x-11 means their weight would show up as 1.5 lbs more than they actually weigh, which is also discuraging.


# True weight
* this is where true weight comes in, we can keep using more data, but also project them forward to guess true weight. Ex if using 10 days of previous data to form a SMA, projecting their data forward 5 days would estimate their true weight better


# Maintenance vs weight change:
* if their goal is weight change, using projected weight/ true weight matters
* if they are trying to maintain their weight then just showing the graph and the current SMA is fine
* can afford to take longer periods of moving averages here



# Some notes/ ideas:
* for now, super simple, no accounts or database yet, to get rolling quick just local storage of data, stored as (date and hour, weight)
* user defaults
* take Calorie info from apple watch or health to help estimate calories for a normal day etc.
* Bmi, display ranges
* A new scale that doesn't show the user the current measurement is a good idea