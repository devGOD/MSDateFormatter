//
//  DateFormatter.swift
//  DateFormatter
//
//  Created by Michael Vu on 10/6/14.
//  Copyright (c) 2014 Michael Vu. All rights reserved.
//

import Foundation

let formatter: NSDateFormatter = NSDateFormatter()
let currentCalendar = NSCalendar.currentCalendar()

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