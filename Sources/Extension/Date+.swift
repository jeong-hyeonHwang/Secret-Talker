//
//  Date+.swift
//  SecretTalker
//
//  Created by 황정현 on 7/29/25.
//

import Foundation.NSDate

extension Date {
    func displayDateTimeString() -> String {
        return DateFormatter.displayDateTime.string(from: self)
    }
}
