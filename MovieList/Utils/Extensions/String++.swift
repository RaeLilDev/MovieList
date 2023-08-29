//
//  String++.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation

enum DateFormat: String {
    case type1 = "dd MMMM yyyy" // 3 September 2020
    case type2 = "yyyy" //2022
    case type3 = "yyyy, dd MMMM" //2020, 3 September
    case type4 = "MMMM dd, yyyy"
    case type5 = "h:mm a"
    case type6 = "yyyy-MM-dd h:mm a"
}

extension String {
    func toDate(format: DateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}
