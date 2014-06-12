# MSDateFormatter

A delightful NSDate category for iOS written in Swift.

This is an iOS, Objective-C, Swift, Cocoa Touch, iPhone, iPad category for `NSDate`. It gives `NSDate` the ability to report times like `"10 seconds ago"`, `"about 10 days ago"`, , `"10 hours 30 minutes ago"`, `"15 minutes from now"`, `"Yesterday"`, `"Tomorrow"`, `"Last month"`, `"Next month"`, and so on.



## Localizations

MSDateFormatter comes any languages, with .strings files for the following locales:

- English (`en`)
- Japanese (`ja`)
- Vietnamese (`vi`)

If you'd like to contribute an additional localization, feel free to [open a new pull request](https://github.com/Namvt/MSDateFormatter/pulls).

## Example

Build and run the MSDateFormatter Example project in Xcode to see an inventory of the available MSDateFormatter features.

## Example Usage

### NSDateComponents

It give `NSDateComponents` the ability to get date time by call `"ago()"` and `"fromNow()"` and should use: second(s), minute(s), day(s), week(s), month(s) and year(s)

```objective-c
println("One minute ago:  \(1.minute.ago())")
println("Two day from now:  \(2.days.fromNow())")
```

And `+` and `-` operator

```objective-c
println("One hour and ten minutes ago:  \((1.hour + 10.minutes).ago())")
println("Two days from now:  \(1.day.fromNow() + 1.day.fromNow())")
```

Also use

```objective-c
println("Five hours from now:  \(3.day.add(2.day).fromNow())")
println("3 months ago:  \(4.months.subtract(1.month).ago())")
```

### NSDate

There're a list of functions with `"yesterday()"`, `"tomorrow()"`, `"ago(1.hour)"`, `"timeAgo()"`, `"timeAgoShort()"`, `"dateTimeAgo()"`, `"dateTimeAgoLong(level:2)"`, `"toLocal()"`, `"toGlobal()"`, beginning and end of (day, week, month, year)

```objective-c
println("Yesterday:  \(NSDate.yesterday())")
println("Tomorrow:  \(NSDate.tomorrow())")
println("3 months ago for NSDate:  \(NSDate.date().ago(3.months))")
```

with Time and Date Ago

```objective-c
println("Time Ago:  \(NSDate.date().timeAgo())")
println("Time Ago Short:  \(NSDate.date().timeAgoShort())")
println("Time Ago Simple:  \(NSDate.date().timeAgoSimple())")
println("Time Ago Long Level 2:  \(NSDate.date().timeAgoLong(level: 2))")
println("Date Time Ago:  \(NSDate.date().dateTimeAgo())")
println("Date Time Ago Short:  \(NSDate.date().dateTimeAgoShort())")
println("Date Time Ago Long Level 2:  \(NSDate.date().dateTimeAgoLong(level: 2))")
```

with Local and Global

```objective-c
println("To Local:  \(NSDate.date().toLocal())")
println("To Global:  \(NSDate.date().toGlobal())")
```

with Beginning and End

```objective-c
println("Beginning Of Day:  \(NSDate.date().beginningOfDay())")
println("End Of Day:  \(NSDate.date().endOfDay())")
println("Beginning Of Week:  \(NSDate.date().beginningOfWeek())")
println("End Of Week:  \(NSDate.date().endOfWeek())")
println("Beginning Of Month:  \(NSDate.date().beginningOfMonth())")
println("End Of Month:  \(NSDate.date().endOfMonth())")
println("Beginning Of Year:  \(NSDate.date().beginningOfYear())")
println("End Of Year:  \(NSDate.date().endOfYear())")
```

with Formatter

```objective-c
var longFormat = "dd-MM-yyyy HH:mm:ss"
println("Long Formatter:  \(NSDate.date().format(longFormat))")
var shortFormat = "dd-MM-yyyy"
println("Short Formatter:  \(NSDate.date().format(shortFormat))")
println("Other Formatter:  \(NSDate.date().format(sdate: .FullStyle, stime: .NoStyle))")
```

with Add and Subtract

```objective-c
println("Add Date:  \(NSDate.date().add(1.day))")
println("Subtract Date:  \(NSDate.date().subtract(1.day))")
```

## Installation

Add MSDateFormatter.swif file to your project and use it

## Author

Michael Vu

- https://github.com/Namvt
- namvt@rubify.com

## License

MSDateFormatter is available under the MIT license. See the LICENSE file for more info.

