//
//  DateFormatter.swift
//  FinalReema
//
//  Created by Reema Mousa on 19/06/1443 AH.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
