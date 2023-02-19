import UIKit

extension Date {

    /// Get Current Year, month, day, time
    var onlyDate: Date {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents) ?? Date()
        }
    }


}

