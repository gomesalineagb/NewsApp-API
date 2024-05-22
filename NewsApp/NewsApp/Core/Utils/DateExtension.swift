//
//  DateExtension.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import Foundation
extension Date {
    static func getFormattedDate(string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: string) {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
}
