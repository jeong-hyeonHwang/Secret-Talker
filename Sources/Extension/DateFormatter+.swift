//
//  DateFormatter+.swift
//  SecretTalker
//
//  Created by 황정현 on 7/29/25.
//

import Foundation.NSDateFormatter

extension DateFormatter {
    static let displayDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter
    }()
}
