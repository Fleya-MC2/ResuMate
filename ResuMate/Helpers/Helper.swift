//
//  Helper.swift
//  ResuCreate
//
//  Created by Muhammad Adha Fajri Jonison on 12/06/23.
//

import SwiftUI

struct Helper {
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        return dateFormatter.string(from: date)
    }
}
