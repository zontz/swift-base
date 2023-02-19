
import Foundation

extension DateFormatter {
    convenience init(timeStyle: DateFormatter.Style, timeZone: TimeZone) {
        self.init()
        self.timeStyle = timeStyle
        self.dateStyle = .full
        self.timeZone = timeZone
    }

    /// get Date converted to string
    static var getStringFormattedDate: String {
        let formatter = DateFormatter(timeStyle: .none, timeZone: .current)
        return formatter.string(from: Date().onlyDate)
    }
}
