//
//  Date+Extension.swift
//  Clout
//
//  Created by CodingPixel on 09/01/2020.
//  Copyright © 2020 CP. All rights reserved.
//

import Foundation

extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    func getDateFormat(outPutFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = outPutFormat
        let mnth_name =  formatter.string(from: self)
        return mnth_name
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff < 0 ? 0: diff)" + (diff == 1 ? " sec" : " secs")
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff < 0 ? 0: diff)" + (diff == 1 ? " min" : " mins")
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff < 0 ? 0: diff)" + (diff == 1 ? " hour" : " hours")
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff < 0 ? 0: diff)" + (diff == 1 ? " day" : " days")
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff < 0 ? 0: diff)" + (diff == 1 ? " week" : " weeks")
    }
    
    
    
    
    func toString(withFormat format: String = "yyyy-MM-dd") -> String {
        
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "fa-IR")
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
//        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
    

}

//extension String{
//    func getTime() -> String {
//        let formatter = DateFormatter.init(withFormat: "yyyy-MM-dd HH:mm:ss", locale: "GMT")
//        let date = formatter.date(from: self)?.toGlobalTime() ?? Date()
//        return formatter.string(from: date)
//    }
//}
