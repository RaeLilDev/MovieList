//
//  Preference.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
enum PreferenceKeys: String {
    case isOldUser
    case sortByName
}

class Preference {
    
    static func setValue(_ value: Any?, forKey key: PreferenceKeys) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    static func getBool(forKey key: PreferenceKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
