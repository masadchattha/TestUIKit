//
//  String+Extension.swift
//  LFW
//
//  Created by Jassie on 28/05/2018.
//  Copyright © 2018 CodingPixel. All rights reserved.
//

import Foundation
import UIKit
//import SwiftyGif
protocol StringType { var get: String { get } }
extension String: StringType { var get: String { return self } }
extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}


extension String{
    
    
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
    }
    
    func decodeUFT8() -> String {
        let data = self.data(using: .utf8)!
        let str = String(data: data, encoding: .nonLossyASCII)
        return str!
    }
    
    func encodeUFT8() -> String {
        let  cmt  = self.data(using: .nonLossyASCII)
        let text = String(data: cmt!, encoding: .utf8)
        return text!
    }
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "^([?=.*?a-z0-9A-Z]).{8,20}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    func getAlphabatic(i : Int) -> Character {
        let startingValue = Int(("A" as UnicodeScalar).value) // 65
        return Character(UnicodeScalar(i + startingValue)!)
    }
   
    func deleteHTMLTag(tag:String) -> String {
            return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
//        dateFormatter.locale = Locale(identifier: "fa-IR")
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
    
    func deleteHTMLTags(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
                mutableString = mutableString.deleteHTMLTag(tag: tag)
            }
            return mutableString
        }
  
        var parseJSONString: AnyObject? {
            
            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)

            if let jsonData = data {
                // Will return an object or nil if JSON decoding fails
                do{
                    if let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary){
                            return json
                    }else{
                    let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)
                            return json
                    }
                    
                }catch{
                    print("Error")
                }
                
            } else {
                // Lossless conversion of the string was not possible
                return nil
            }
            
            return nil
    }
}

extension StringProtocol {
    
    var string: String { return String(self) }
    
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
} 

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func capitalizingFirstLetterRestLowercase() -> String {
        return prefix(1).capitalized + dropFirst().lowercased()
    }
    
    mutating func capitalizeFirstLetterRestLowercase() {
        self = self.capitalizingFirstLetterRestLowercase()
    }

}
extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var mediumFont:UIFont { return UIFont(name: "AvenirNext-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: 16) }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func medium(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : mediumFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func roboto(_ value:String , fontSize : CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /* Other styling methods */
    
    func changePurpleColor(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : mediumFont,
            .foregroundColor : UIColor(named: "TextBlackToPurple"),
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func clearText(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            
            .foregroundColor : UIColor.clear,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func changePurpleNormalColor(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
            .foregroundColor : UIColor(named: "TextBlackToPurple"),
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
}

////
////  String+Extension.swift
////  LFW
////
////  Created by Jassie on 28/05/2018.
////  Copyright © 2018 CodingPixel. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SwiftyGif
//
//import Foundation
//import UIKit
//import var CommonCrypto.CC_MD5_DIGEST_LENGTH
//import func CommonCrypto.CC_MD5
//import typealias CommonCrypto.CC_LONG
//
//protocol StringType { var get: String { get } }
//extension String: StringType { var get: String { return self } }
//extension Optional where Wrapped: StringType {
//    func unwrap() -> String {
//        return self?.get ?? ""
//    }
//}
//

extension String{
    
    
    
//    var floatValue: Float {
//        return (self as NSString).floatValue
//    }
//
//    var localized: String {
//        return NSLocalizedString(self, comment: self)
//    }
//
//    func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
//        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
//    }
//
//    func decodeUFT8() -> String {
//        let data = self.data(using: .utf8)!
//        let str = String(data: data, encoding: .nonLossyASCII)
//        return str!
//    }
//
//    func encodeUFT8() -> String {
//        let  cmt  = self.data(using: .nonLossyASCII)
//        let text = String(data: cmt!, encoding: .utf8)
//        return text!
//    }
//    func currencyInputFormatting() -> String {
//
//        var number: NSNumber!
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currencyAccounting
//        formatter.currencySymbol = ""
//        formatter.maximumFractionDigits = 2
//        formatter.minimumFractionDigits = 2
//
//        var amountWithPrefix = self
//
//        // remove from String: "$", ".", ","
//        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
//        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
//
//        let double = (amountWithPrefix as NSString).doubleValue
//        number = NSNumber(value: (double / 100))
//
//        // if first number is 0 or all numbers were deleted
//        guard number != 0 as NSNumber else {
//            return ""
//        }
//
//        return formatter.string(from: number)!
//    }
//    func isValidEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }
//
//    func isValidPassword() -> Bool {
//        let passwordRegEx = "^([?=.*?a-z0-9A-Z]).{8,20}$"
//        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        return passwordTest.evaluate(with: self)
//    }
//
//    func getAlphabatic(i : Int) -> Character {
//        let startingValue = Int(("A" as UnicodeScalar).value) // 65
//        return Character(UnicodeScalar(i + startingValue)!)
//    }
//
//    func deleteHTMLTag(tag:String) -> String {
//            return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
//    }
//
//    func toDate(withFormat format: String = "h:mm a")-> Date?{
//
//        let dateFormatter = DateFormatter()
////        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
////        dateFormatter.locale = Locale(identifier: "fa-IR")
////        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        dateFormatter.dateFormat = format
//        let date = dateFormatter.date(from: self)
//
//        return date
//
//    }
//
//    func deleteHTMLTags(tags:[String]) -> String {
//        var mutableString = self
//        for tag in tags {
//                mutableString = mutableString.deleteHTMLTag(tag: tag)
//            }
//            return mutableString
//        }
//
//        var parseJSONString: AnyObject? {
//
//            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
//
//            if let jsonData = data {
//                // Will return an object or nil if JSON decoding fails
//                do{
//                    if let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary){
//                            return json
//                    }else{
//                    let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)
//                            return json
//                    }
//
//                }catch{
//                    print("Error")
//                }
//
//            } else {
//                // Lossless conversion of the string was not possible
//                return nil
//            }
//
//            return nil
//    }
//}
//
//extension StringProtocol {
//
//    var string: String { return String(self) }
//
//    subscript(offset: Int) -> Element {
//        return self[index(startIndex, offsetBy: offset)]
//    }
//
//    subscript(_ range: CountableRange<Int>) -> SubSequence {
//        return prefix(range.lowerBound + range.count)
//            .suffix(range.count)
//    }
//    subscript(range: CountableClosedRange<Int>) -> SubSequence {
//        return prefix(range.lowerBound + range.count)
//            .suffix(range.count)
//    }
//
//    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
//        return prefix(range.upperBound.advanced(by: 1))
//    }
//    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
//        return prefix(range.upperBound)
//    }
//    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
//        return suffix(Swift.max(0, count - range.lowerBound))
//    }
//}
//
//extension Substring {
//    var string: String { return String(self) }
//}
//
//extension String {
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
//
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//
//    func capitalizingFirstLetterRestLowercase() -> String {
//        return prefix(1).capitalized + dropFirst().lowercased()
//    }
//
//    mutating func capitalizeFirstLetterRestLowercase() {
//        self = self.capitalizingFirstLetterRestLowercase()
//    }
//
//}
//extension NSMutableAttributedString {
//    var fontSize:CGFloat { return 14 }
//    var mediumFont:UIFont { return UIFont(name: "AvenirNext-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: 16) }
//    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
//    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
//
//    func medium(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : mediumFont
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func bold(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : boldFont
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func normal(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : normalFont,
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func roboto(_ value:String , fontSize : CGFloat) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : UIFont(name: "Roboto", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    /* Other styling methods */
//
//    func changePurpleColor(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : mediumFont,
//            .foregroundColor : UIColor(named: "TextBlackToPurple"),
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func clearText(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//
//            .foregroundColor : UIColor.clear,
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//    func changePurpleNormalColor(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font : normalFont,
//            .foregroundColor : UIColor(named: "TextBlackToPurple"),
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .foregroundColor : UIColor.white,
//            .backgroundColor : UIColor.orange
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func blackHighlight(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .foregroundColor : UIColor.white,
//            .backgroundColor : UIColor.black
//
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//
//    func underlined(_ value:String) -> NSMutableAttributedString {
//
//        let attributes:[NSAttributedString.Key : Any] = [
//            .font :  normalFont,
//            .underlineStyle : NSUnderlineStyle.single.rawValue
//
//        ]
//
//        self.append(NSAttributedString(string: value, attributes:attributes))
//        return self
//    }
//}
//
//extension String {
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.height
//    }
//
//    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.width
//    }
}
//
//  String+Extensions.swift
//  PMMT
//
//  Created by Haspinder on 19/07/16.
//  Copyright © 2016 Haspinder Singh. All rights reserved.
//





extension String {
    
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
   
    
    func isValidZipCode() -> Bool {
            let emailRegEx = "^[0-9]{6}$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self.trimmingCharacters(in: .whitespaces))
        }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func boldString(fontSize : CGFloat ,font : UIFont?) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 8)]
        return NSMutableAttributedString(string:self, attributes:attrs)
    }
    
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    func getDateFormat(inputFormat:String,outPutFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let dt = dateFormatter.date(from: self)
        if dt != nil{
            let formatter = DateFormatter();
            formatter.dateFormat = outPutFormat
            let mnth_name =  formatter.string(from: dt!)
            return mnth_name
        }
        return  "18-10-2018"
    }
    
//    func MD5() -> Data {
//        let length = Int(CC_MD5_DIGEST_LENGTH)
//        let messageData = self.data(using:.utf8)!
//        var digestData = Data(count: length)
//
//        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
//            messageData.withUnsafeBytes { messageBytes -> UInt8 in
//                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
//                    let messageLength = CC_LONG(messageData.count)
//                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
//                }
//                return 0
//            }
//        }
//        return digestData
//    }
    
//    func md5Encryption() -> String{
//        let md5Data = self.MD5()
//        return md5Data.map { String(format: "%02hhx", $0) }.joined()
//    }
    
   
    
    func getAgeFormDOB() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy"
        let birthday: Date = formatter.date(from: self)!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        return String(age)
    }
    
    func convertStringToDate(formatter: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"//formatter
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")//TimeZone(name: "GMT")
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    
    
    
}

extension String {
    
//    var parseJSONString: AnyObject? {
//
//        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
//
//        if let jsonData = data {
//            // Will return an object or nil if JSON decoding fails
//            do{
//                if let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary){
//                        return json
//                }else{
//                let json = try (JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)
//                        return json
//                }
//
//            }catch{
//                print("Error")
//            }
//
//        } else {
//            return nil
//        }
//
//        return nil
//}
    
    var parseJSONStringArray: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let json:NSArray
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do{
                json  = try  JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)  as! NSArray
                
                return json
            }catch{
                print("Error")
            }
            
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
        
        return nil
    }
}
extension String
{
//    func toDate( dateFormat format  : String) -> Date
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        dateFormatter.amSymbol = "AM"
//        dateFormatter.pmSymbol = "PM"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        return dateFormatter.date(from: self)!
//    }
    
    
    func convertToUTC(isDatee: Bool = true) -> String {
        let formatter = DateFormatter()

        if isDatee{
            formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        } else {
            formatter.dateFormat = "hh:mm a"

        }

        let convertedDate = formatter.date(from: self)

        formatter.timeZone = TimeZone(identifier: "UTC")

//        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)

    }
   
    func UTCToLocal(inputFormate : String , outputFormate : String) -> String {
        if self.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  inputFormate  //Input Format "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            guard let UTCDate = dateFormatter.date(from: self) else {return ""}
            dateFormatter.dateFormat =  outputFormate // Output Format "MM.dd.yyyy hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            let UTCToCurrentFormat = dateFormatter.string(from: UTCDate)
            print(UTCToCurrentFormat)
            return UTCToCurrentFormat
        }else{
            return "Empty Date"
        }
    }
    func getRanges(of string: String) -> [NSRange] {
        var ranges:[NSRange] = []
        if contains(string) {
            let words = self.components(separatedBy: " ")
            var position:Int = 0
            for word in words {
                if word.lowercased() == string.lowercased() {
                    let startIndex = position
                    let endIndex = word.count
                    let range = NSMakeRange(startIndex, endIndex)
                    ranges.append(range)
                }
                position += (word.count + 1)
            }
        }
        return ranges
    }
    
    func getRemidersRemainingDays() -> String{
        let dateRangeStart = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dt = dateFormatter.date(from: self)
//        dt = dt?.toLocalTime()
        let calendar = Calendar.current
        if calendar.isDateInTomorrow(dt!) {
            return "Tomorrow"
        }else if  calendar.isDateInToday(dt!){
             return "Today"
        }else{
            var diffInDays = calendar.dateComponents([.day], from: dateRangeStart, to: dt!).day
            if diffInDays! > 0 {
                diffInDays = (diffInDays!) + 1
            }
            if diffInDays! <= 0{
                return "Today"
            }else{
                return "\(String(describing: diffInDays!)) Days"
            }
        }
    }
    
}
extension String {
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
//
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
    
    var extractURLs: [URL] {
        var urls : [URL] = []
        var error: NSError?
        do{
            let detector = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let text = self
            detector.enumerateMatches(in: text, range: NSMakeRange(0, text.count), using: { (result: NSTextCheckingResult!, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                //            println("\(result)")
                //            println("\(result.URL)")
                urls.append(result.url!)
            })
        }catch let error1 as NSError {
            error = error1
            print(error!.description)
        } catch {
            // Catch any other errors
            print(error.localizedDescription)
        }
            
            return urls
        
    }
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}

extension String {
    
    func getDateWithMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: dateFromServerDateString)
        

    }
    
    func getChatDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: dateFromServerDateString)
        

    }
    
   
    
    func getRoundDate_ddMMyyy() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateFromServerDateString)
    
    }
    
    func getRoundDateTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        return dateFormatter.string(from: dateFromServerDateString)
    
    }
    
    
    func getRoundDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateFromServerDateString)
    
    }
    
    func getRoundDateSpecficFormate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: dateFromServerDateString)
    }
    
    func getRoundTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateFromServerDateString = dateFormatter.date(from: self) else { return nil}
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: dateFromServerDateString)
    
    }

    func getRelativeTimeStamp() -> String? {
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let formattedTime = dateFormatter.string(from: date)
        
        let units = Set<Calendar.Component>([.day, .weekOfYear, .weekday, .weekOfMonth, .weekdayOrdinal, .weekOfMonth])

        let components = NSCalendar.current.dateComponents(units, from: date, to: todayDate)
        print(components)
        dateFormatter.dateFormat = "MM dd yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return "\(formattedDate), \(formattedTime)"
//        if components.weekOfYear! > 0 || components.weekOfYear! < 0{
//            dateFormatter.dateFormat = "MM dd yyyy"
//            let formattedDate = dateFormatter.string(from: date)
//            return "\(formattedDate), \(formattedTime)"
//        } else {
//            if components.day! > 0  {
//                if components.day! >= 1  {
//                    dateFormatter.dateFormat = "MM dd yyyy"
//                    let formattedDate = dateFormatter.string(from: date)
//                    //let dayName = dateFormatter.string(from: date)
//                    return "\(formattedDate) \(formattedTime)"
//                }
//                //else {
////                    return "Yesterday \(formattedTime)"
////                }
//            } else if components.day! < 0 || components.day == 0 {
//                dateFormatter.dateFormat = "MM dd yyyy"
//                let formattedDate = dateFormatter.string(from: date)
//                //let dayName = dateFormatter.string(from: date)
//                return "\(formattedDate) \(formattedTime)"
//            } else {
//
//                if components.day! < -1 {
//                    dateFormatter.dateFormat = "MM dd yyyy"
//                    let formattedDate = dateFormatter.string(from: date)
//                   // let dayName = dateFormatter.string(from: date)
//                    return "\(formattedDate) \(formattedTime)"
//                }
//        }
//    }
        return formattedTime
}

}



extension Dictionary where Value: Any {
    public func mergeOnto(target: [Key: Value]?) -> [Key: Value] {
        guard let target = target else { return self }
        return self.merging(target) { current, _ in current }
    }
}


extension ContiguousArray where Element: Hashable {

    func countForElements() -> [Element: Int] {
        var counts = [Element: Int]()
        for element in self {
            counts[element] = (counts[element] ?? 0) + 1
        }
        return counts
    }

}


