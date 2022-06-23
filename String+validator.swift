//
//  String+validator.swift
//  ReEcho
//
//  Created by carl on 30/07/2020.
//  Copyright © 2020 reecho. All rights reserved.
//

import Foundation
import PhoneNumberKit


extension String {
    public func isValidEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
//    public func isValidPhoneNumber() -> Bool {
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
//            if let res = matches.first {
//                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
//            } else {
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
    
    public func isValidPhoneNumber() -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(self)
            print("PhoneNumberKit countryCode \(phoneNumber.countryCode) format e164 \(phoneNumberKit.format(phoneNumber, toType: .e164)) ")
            return true
        } catch {
            print("PhoneNumberKit parser error")
            return false
        }
    }
    
    public func parsePhoneNumber() -> (String, String) {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let phoneNumber = try phoneNumberKit.parse(self)
            print("PhoneNumberKit countryCode \(phoneNumber.countryCode) format e164 \(phoneNumberKit.format(phoneNumber, toType: .e164)) ")
            let formattedPhone = phoneNumberKit.format(phoneNumber, toType: .e164)
            return (formattedPhone, String(phoneNumber.countryCode))
        } catch {
            print("PhoneNumberKit parser error")
            return ("", "")
        }
    }
    
    // assume phone number with 07 or 08 prefix as UK number and add 44 in the front
    public func formatUKNumber() -> String {
        var formattedPhone = self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        if formattedPhone.count>10 {
            if formattedPhone.starts(with: "+440") {
                formattedPhone = formattedPhone.replacingOccurrences(of: "+440", with: "44")
            } else if formattedPhone.starts(with: "07") || formattedPhone.starts(with: "08") {
                formattedPhone = "44" + String( formattedPhone.dropFirst() )
            }
        } else if formattedPhone.count == 10 {
            formattedPhone = "44" + formattedPhone
        }
        return formattedPhone
    }
    
    public func isValidMMYYY() -> Bool {
        let regEx = "[0-9]{2}\\/[0-9]{4}"
        let datePred = NSPredicate(format:"SELF MATCHES %@", regEx)
//        print("isValidMMYYY \(datePred.evaluate(with: self))")
        return datePred.evaluate(with: self)
    }
    
    public func isNumbers() -> Bool {
        if let _ = Float32(self) {
            print("isNumbers")
            return true
        }
        print("NOT Numbers")
        return false
    }
    
    public func isDigits() -> Bool {
        if self.count == 0 {
            return true
        }
        
        let regEx = "[0-9]+"
        let datePred = NSPredicate(format:"SELF MATCHES %@", regEx)

        return datePred.evaluate(with: self)
    }
}

