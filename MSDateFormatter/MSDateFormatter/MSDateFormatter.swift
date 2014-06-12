//
//  DateFormatter.swift
//  DateFormatter
//
//  Created by Michael Vu on 10/6/14.
//  Copyright (c) 2014 Michael Vu. All rights reserved.
//

import CoreFoundation
import Foundation

let formatter: NSDateFormatter = NSDateFormatter()
let currentCalendar = NSCalendar.currentCalendar()
let bundle = NSBundle.mainBundle()
let significantUnits = NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.WeekCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit | NSCalendarUnit.SecondCalendarUnit
let localizationTable = "MSDateFormatter"

func calendarUnitFromString(string:String) -> NSCalendarUnit {
    switch string {
        case "year":
            return .YearCalendarUnit
        case "month":
            return .MonthCalendarUnit
        case "week":
            return .WeekCalendarUnit
        case "day":
            return .DayCalendarUnit
        case "hour":
            return .HourCalendarUnit
        case "minute":
            return .MinuteCalendarUnit
        case "second":
            return .SecondCalendarUnit
        default:
            return nil
    }
}

func getNormalizedCalendarUnit(unit:NSCalendarUnit) -> NSCalendarUnit {
    switch unit {
    case NSCalendarUnit.WeekOfMonthCalendarUnit, NSCalendarUnit.WeekOfYearCalendarUnit:
        return .WeekCalendarUnit
    case NSCalendarUnit.WeekdayCalendarUnit, NSCalendarUnit.WeekdayOrdinalCalendarUnit:
        return .DayCalendarUnit
    default:
        return unit;
    }
}

func compareCalendarUnitSignificance(unit:NSCalendarUnit, other:NSCalendarUnit) -> NSComparisonResult {
    let nUnit = getNormalizedCalendarUnit(unit)
    let nOther = getNormalizedCalendarUnit(other)
    
    if (nUnit == .WeekCalendarUnit) ^ (nOther == .WeekCalendarUnit) {
        if nUnit == .WeekCalendarUnit {
            switch nUnit {
            case NSCalendarUnit.YearCalendarUnit, NSCalendarUnit.MonthCalendarUnit:
                return .OrderedAscending
            default:
                return .OrderedDescending
            }
        } else {
            switch nOther {
            case NSCalendarUnit.YearCalendarUnit, NSCalendarUnit.MonthCalendarUnit:
                return .OrderedDescending
            default:
                return .OrderedAscending
            }
        }
    } else {
        if nUnit.value > nOther.value {
            return .OrderedAscending
        } else if (nUnit.value < nOther.value) {
            return .OrderedDescending
        } else {
            return .OrderedSame
        }
    }
}

func localizedStringForNumber(number:NSInteger, unit:NSCalendarUnit, short:Bool = false) -> String {
    let singular = (number == 1)
    switch unit {
        case NSCalendarUnit.YearCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "yr" : "year", value: nil, table: localizationTable)
        case NSCalendarUnit.YearCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "yrs" : "years", value: nil, table: localizationTable)
        case NSCalendarUnit.MonthCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "mo" : "month", value: nil, table: localizationTable)
        case NSCalendarUnit.MonthCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "mos" : "months", value: nil, table: localizationTable)
        case NSCalendarUnit.WeekCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "wk" : "week", value: nil, table: localizationTable)
        case NSCalendarUnit.WeekCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "wks" : "weeks", value: nil, table: localizationTable)
        case NSCalendarUnit.DayCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "day" : "day", value: nil, table: localizationTable)
        case NSCalendarUnit.DayCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "days" : "days", value: nil, table: localizationTable)
        case NSCalendarUnit.HourCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "hr" : "hour", value: nil, table: localizationTable)
        case NSCalendarUnit.HourCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "hrs" : "hours", value: nil, table: localizationTable)
        case NSCalendarUnit.MinuteCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "min" : "minute", value: nil, table: localizationTable)
        case NSCalendarUnit.MinuteCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "mins" : "minutes", value: nil, table: localizationTable)
        case NSCalendarUnit.SecondCalendarUnit where singular:
            return bundle.localizedStringForKey(short ? "s" : "second", value: nil, table: localizationTable)
        case NSCalendarUnit.SecondCalendarUnit where !singular:
            return bundle.localizedStringForKey(short ? "s" : "seconds", value: nil, table: localizationTable)
        default:
            return ""
    }
}

func localizedSimpleStringForComponents(components:NSDateComponents) -> String {
    if (components.year == -1) {
        return bundle.localizedStringForKey("last year", value: nil, table: localizationTable)
    } else if (components.month == -1 && components.year == 0) {
        return bundle.localizedStringForKey("last month", value: nil, table: localizationTable)
    } else if (components.week() == -1 && components.year == 0 && components.month == 0) {
        return bundle.localizedStringForKey("last week", value: nil, table: localizationTable)
    } else if (components.day == -1 && components.year == 0 && components.month == 0 && components.week() == 0) {
        return bundle.localizedStringForKey("yesterday", value: nil, table: localizationTable)
    }
    if (components.year == 1) {
        return bundle.localizedStringForKey("next year", value: nil, table: localizationTable)
    } else if (components.month == 1 && components.year == 0) {
        return bundle.localizedStringForKey("next month", value: nil, table: localizationTable)
    } else if (components.week() == 1 && components.year == 0 && components.month == 0) {
        return bundle.localizedStringForKey("next week", value: nil, table: localizationTable)
    } else if (components.day == 1 && components.year == 0 && components.month == 0 && components.week() == 0) {
        return bundle.localizedStringForKey("tomorrow", value: nil, table: localizationTable)
    }
    return ""
}

extension NSDateComponents {
    func ago() -> NSDate {
        return currentCalendar.dateByAddingComponents(-self, toDate:NSDate.date(), options:nil)
    }
    func fromNow() -> NSDate {
        return currentCalendar.dateByAddingComponents(self, toDate:NSDate.date(), options:nil)
    }
    func add(components: NSDateComponents) -> NSDateComponents {
        let component = NSDateComponents()
        component.second = ((self.second != NSUndefinedDateComponent ? self.second : 0) +
            (components.second != NSUndefinedDateComponent ? components.second : 0))
        component.minute = ((self.minute != NSUndefinedDateComponent ? self.minute : 0) +
            (components.minute != NSUndefinedDateComponent ? components.minute : 0))
        component.hour = ((self.hour != NSUndefinedDateComponent ? self.hour : 0) +
            (components.hour != NSUndefinedDateComponent ? components.hour : 0))
        component.day = ((self.day != NSUndefinedDateComponent ? self.day : 0) +
            (components.day != NSUndefinedDateComponent ? components.day : 0))
        component.weekOfYear = ((self.weekOfYear != NSUndefinedDateComponent ? self.weekOfYear : 0) +
            (components.weekOfYear != NSUndefinedDateComponent ? components.weekOfYear : 0))
        component.month = ((self.month != NSUndefinedDateComponent ? self.month : 0) +
            (components.month != NSUndefinedDateComponent ? components.month : 0))
        component.year = ((self.year != NSUndefinedDateComponent ? self.year : 0) +
            (components.year != NSUndefinedDateComponent ? components.year : 0))
        return component
    }
    func addDate(sdate: NSDate) -> NSDate {
        return currentCalendar.dateByAddingComponents(self, toDate:sdate, options:nil)
    }
    func subtract(components: NSDateComponents) -> NSDateComponents {
        let component = NSDateComponents()
        component.second = ((self.second != NSUndefinedDateComponent ? self.second : 0) -
            (components.second != NSUndefinedDateComponent ? components.second : 0))
        component.minute = ((self.minute != NSUndefinedDateComponent ? self.minute : 0) -
            (components.minute != NSUndefinedDateComponent ? components.minute : 0))
        component.hour = ((self.hour != NSUndefinedDateComponent ? self.hour : 0) -
            (components.hour != NSUndefinedDateComponent ? components.hour : 0))
        component.day = ((self.day != NSUndefinedDateComponent ? self.day : 0) -
            (components.day != NSUndefinedDateComponent ? components.day : 0))
        component.weekOfYear = ((self.weekOfYear != NSUndefinedDateComponent ? self.weekOfYear : 0) -
            (components.weekOfYear != NSUndefinedDateComponent ? components.weekOfYear : 0))
        component.month = ((self.month != NSUndefinedDateComponent ? self.month : 0) -
            (components.month != NSUndefinedDateComponent ? components.month : 0))
        component.year = ((self.year != NSUndefinedDateComponent ? self.year : 0) -
            (components.year != NSUndefinedDateComponent ? components.year : 0))
        return component
    }
    func subtractDate(sdate: NSDate) -> NSDate {
        return currentCalendar.dateByAddingComponents(-self, toDate:sdate, options:nil)
    }
}

extension NSDate {
    class func yesterday() -> NSDate {
        let component = NSDateComponents()
        component.day = -1;
        return currentCalendar.dateByAddingComponents(component, toDate: self.date(), options: nil)
    }
    class func tomorrow() -> NSDate {
        let component = NSDateComponents()
        component.day = +1;
        return currentCalendar.dateByAddingComponents(component, toDate: self.date(), options: nil)
    }
    func ago(components:NSDateComponents) -> NSDate {
        return currentCalendar.dateByAddingComponents(-components, toDate: self, options: nil)
    }
    func timeAgo() -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self)
    }
    func timeAgoShort() -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, short:true)
    }
    func timeAgoLong(level:Int=999) -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, level:level)
    }
    func timeAgoSimple() -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, simple:true)
    }
    func dateTimeAgo() -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, approximate: true)
    }
    func dateTimeAgoShort() -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, approximate: true, short:true)
    }
    func dateTimeAgoLong(level:Int=999) -> String {
        return self.timeDateAgo(NSDate.date(), toDate: self, approximate: true, level:level)
    }
    func timeDateAgo(fromDate:NSDate, toDate:NSDate, simple:Bool = false, approximate:Bool = false, short:Bool = false, level:Int = 0) -> String {
        let seconds = fromDate.timeIntervalSinceDate(toDate)
        if fabs(seconds) < 1 {
            return bundle.localizedStringForKey("just now", value: nil, table: localizationTable);
        }
        
        let components = currentCalendar.components(significantUnits, fromDate: fromDate, toDate: toDate, options: nil)
        if simple {
            let simpleString = localizedSimpleStringForComponents(components)
            if simpleString.isEmpty == false {
                return simpleString
            }
        }
        var string = String()
        var isApproximate:Bool = false
        var numberOfUnits:Int = 0
        let unitList: String[] = ["year", "month", "week", "day", "hour", "minute", "second"]
        for unitName in unitList {
            let unit = calendarUnitFromString(unitName)
            if (significantUnits & unit) && compareCalendarUnitSignificance(.SecondCalendarUnit, unit) != .OrderedDescending {
                let number:NSNumber = NSNumber(float: fabsf(components.valueForKey(unitName).floatValue))
                if Bool(number.integerValue) {
                    let suffix = String(format: bundle.localizedStringForKey("Suffix Expression Format String", value: "%@ %@", table: localizationTable), arguments: [number, localizedStringForNumber(number.unsignedIntegerValue, unit, short:short)])
                    if string.isEmpty {
                        string = suffix
                    } else if numberOfUnits < level {
                        string += String(format: " %@", arguments: [suffix])
                    } else {
                        isApproximate = true
                    }
                    numberOfUnits += 1
                }
            }
        }
        if string.isEmpty == false {
            if seconds > 0 {
                string = String(format: bundle.localizedStringForKey("Date Format String", value: "%@ %@", table: localizationTable), arguments: [string, bundle.localizedStringForKey("ago", value: nil, table: localizationTable)])
            } else {
                string = String(format: bundle.localizedStringForKey("Date Format String", value: "%@ %@", table: localizationTable), arguments: [string, bundle.localizedStringForKey("from now", value: nil, table: localizationTable)])
            }
            
            if (isApproximate && approximate) {
                string = String(format: bundle.localizedStringForKey("about %@", value: nil, table: localizationTable), arguments: [string])
            }
        }
        return string
    }
    func toLocal() -> NSDate {
        let localTimeZone = NSTimeZone.localTimeZone()
        let date = NSDate()
        var secondsFromGMT = NSTimeInterval(localTimeZone.secondsFromGMTForDate(self))
        return self.dateByAddingTimeInterval(secondsFromGMT)
    }
    func toGlobal() -> NSDate {
        let localTimeZone = NSTimeZone.localTimeZone()
        let date = NSDate()
        var secondsFromGMT = -NSTimeInterval(localTimeZone.secondsFromGMTForDate(self))
        return self.dateByAddingTimeInterval(secondsFromGMT)
    }
    func beginningOfDay() -> NSDate {
        let components = currentCalendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit, fromDate: self)
        return currentCalendar.dateFromComponents(components);
    }
    func endOfDay() -> NSDate {
        let components = NSDateComponents()
        components.day = 1
        return currentCalendar.dateByAddingComponents(components, toDate: self.beginningOfDay(), options: nil).dateByAddingTimeInterval(-1)
    }
    func beginningOfWeek() -> NSDate {
        let components = currentCalendar.components(.YearCalendarUnit | .MonthCalendarUnit | .WeekdayCalendarUnit | .DayCalendarUnit, fromDate: self)
        var offset = components.weekday - NSInteger(currentCalendar.firstWeekday)
        components.day = components.day - offset
        return currentCalendar.dateFromComponents(components)
    }
    func endOfWeek() -> NSDate {
        let components = NSDateComponents()
        components.setWeek(1)
        return currentCalendar.dateByAddingComponents(components, toDate: self.beginningOfWeek(), options: nil).dateByAddingTimeInterval(-1)
    }
    func beginningOfMonth() -> NSDate {
        let components = currentCalendar.components(.YearCalendarUnit | .MonthCalendarUnit, fromDate: self)
        return currentCalendar.dateFromComponents(components)
    }
    func endOfMonth() -> NSDate {
        let components = NSDateComponents()
        components.month = 1
        return currentCalendar.dateByAddingComponents(components, toDate: self.beginningOfMonth(), options: nil).dateByAddingTimeInterval(-1)
    }
    func beginningOfYear() -> NSDate {
        let components = currentCalendar.components(.YearCalendarUnit, fromDate: self)
        return currentCalendar.dateFromComponents(components)
    }
    func endOfYear() -> NSDate {
        let components = NSDateComponents()
        components.year = 1
        return currentCalendar.dateByAddingComponents(components, toDate: self.beginningOfYear(), options: nil).dateByAddingTimeInterval(-1)
    }
    func format(sformat:String) -> String {
        formatter.dateFormat = sformat
        return formatter.stringFromDate(self)
    }
    func format(sdate:NSDateFormatterStyle = .NoStyle, stime:NSDateFormatterStyle = .NoStyle) -> String {
        formatter.dateFormat = nil;
        formatter.timeStyle = stime;
        formatter.dateStyle = sdate;
        return formatter.stringFromDate(self)
    }
    func add(components: NSDateComponents) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        return cal.dateByAddingComponents(components, toDate: self, options: nil)
    }
    func subtract(components: NSDateComponents) -> NSDate {
        func negateIfNeeded(i: NSInteger) -> NSInteger {
            if i == NSUndefinedDateComponent {
                return i
            }
            return -i
        }
        components.year         = negateIfNeeded(components.year)
        components.month        = negateIfNeeded(components.month)
        components.weekOfYear   = negateIfNeeded(components.weekOfYear)
        components.day          = negateIfNeeded(components.day)
        components.hour         = negateIfNeeded(components.hour)
        components.minute       = negateIfNeeded(components.minute)
        components.second       = negateIfNeeded(components.second)
        components.nanosecond   = negateIfNeeded(components.nanosecond)
        return self.add(components)
    }
}

extension Int {
    var second: NSDateComponents {
    var components = NSDateComponents()
        components.second = self
        return components
    }
    var seconds: NSDateComponents {
    return self.second
    }
    
    var minute: NSDateComponents {
    var components = NSDateComponents()
        components.minute = self
        return components
    }
    var minutes: NSDateComponents {
    return self.minute
    }
    
    var hour: NSDateComponents {
    var components = NSDateComponents()
        components.hour = self
        return components
    }
    var hours: NSDateComponents {
    return self.hour
    }
    
    var day: NSDateComponents {
    var components = NSDateComponents()
        components.day = self
        return components
    }
    var days: NSDateComponents {
    return self.day
    }
    
    var week: NSDateComponents {
    var components = NSDateComponents()
        components.weekOfYear = self
        return components
    }
    var weeks: NSDateComponents {
    return self.week
    }
    
    var month: NSDateComponents {
    var components = NSDateComponents()
        components.month = self
        return components
    }
    var months: NSDateComponents {
    return self.month
    }
    
    var year: NSDateComponents {
    var components = NSDateComponents()
        components.year = self
        return components
    }
    var years: NSDateComponents {
    return self.year
    }
}

@prefix func -(comps: NSDateComponents) -> NSDateComponents {
    let result = NSDateComponents()
    if(comps.second != NSUndefinedDateComponent) { result.second = -comps.second }
    if(comps.minute != NSUndefinedDateComponent) { result.minute = -comps.minute }
    if(comps.hour != NSUndefinedDateComponent) { result.hour = -comps.hour }
    if(comps.day != NSUndefinedDateComponent) { result.day = -comps.day }
    if(comps.weekOfYear != NSUndefinedDateComponent) { result.weekOfYear = -comps.weekOfYear }
    if(comps.month != NSUndefinedDateComponent) { result.month = -comps.month }
    if(comps.year != NSUndefinedDateComponent) { result.year = -comps.year }
    return result
}

@infix func + (left: NSDate, right:NSDate) -> NSDate {
    return left.dateByAddingTimeInterval(right.timeIntervalSinceNow)
}

@infix func + (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(right)
}

@infix func + (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.add(right);
}

@infix func + (left: NSDateComponents, right:NSDate) -> NSDate {
    return left.addDate(right);
}

@infix func - (left: NSDate, right:NSDate) -> NSDate {
    return left.dateByAddingTimeInterval(-right.timeIntervalSinceNow)
}

@infix func - (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(-right)
}

@infix func - (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.subtract(right);
}

@infix func - (left: NSDateComponents, right:NSDate) -> NSDate {
    return left.subtractDate(right);
}

@infix func + (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    return left.add(right)
}

@infix func - (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    return left.subtract(right)
}