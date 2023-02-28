//
//  String++.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import Foundation

public extension String {
    func toCurrencyFormat() -> String {
        if let intValue = Int(self){
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "haw_US")
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
        }
        return ""
    }
    
    func trim() -> Self {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func jwtObject() -> [String: Any] {
        let components = components(separatedBy: ".")
        guard components.count >= 2 else { return [:] }

        // get the payload part of it
        var payload64 = components[1]

        // need to pad the string with = to make it divisible by 4,
        // otherwise Data won't be able to decode it
        while payload64.count % 4 != 0 {
            payload64 += "="
        }

        let payloadData = Data(base64Encoded: payload64,
                               options: .ignoreUnknownCharacters) ?? .init()
        let payload = String(data: payloadData, encoding: .utf8) ?? ""
        debugLog(payload)
        let json = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any]
        return json ?? [:]
    }
}

public extension String {
    func toDate(_ format: CustomDateFormatType = .isoDate) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    // parse date string with format
    func parseDateString(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                         outputFormat: String = "dd-MM-yyyy",
                         timeZoneIdentifier: String = "UTC") -> String {
        
        guard let date = parseDateString(inputFormat: inputFormat,
                                         timeZoneIdentifier: timeZoneIdentifier) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    // parse date string with format
    func parseDateString(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                         timeZoneIdentifier: String = "UTC") -> Date? {
        
        guard let timeZone = TimeZone(identifier: timeZoneIdentifier) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: self)
        }
    }
}

public enum CustomDateFormatType {
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    
    /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
    case rss
    
    /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
    case altRSS
    
    /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    /// A custom date format string
    case custom(String)
    
    /// The local formatted date and time "yyyy-MM-dd HH:mm:ss" i.e. 1997-07-16 19:20:00
    case localDateTimeSec
    
    /// The local formatted date  "yyyy-MM-dd" i.e. 1997-07-16
    case localDate
    
    /// The local formatted  time "hh:mm a" i.e. 07:20 am
    case localTimeWithNoon
    
    /// The local formatted date and time "yyyyMMddHHmmss" i.e. 19970716192000
    case localPhotoSave
    
    case birthDateFormatOne
    
    case birthDateFormatTwo
    
    ///
    case messageRTetriveFormat
    
    ///
    case emailTimePreview
    
    public var stringFormat:String {
        switch self {
            //handle iso Time
        case .birthDateFormatOne: return "dd/MM/yyyy"
        case .birthDateFormatTwo: return "dd-MM-yyyy"
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet: return "/Date(%d%f)/"
        case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .custom(let customFormat): return customFormat
            
            //handle local Time
        case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
        case .localTimeWithNoon: return "hh:mm a"
        case .localDate: return "yyyy-MM-dd"
        case .localPhotoSave: return "yyyyMMddHHmmss"
        case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case .emailTimePreview: return "dd MMM yyyy, h:mm a"
        }
    }
}
