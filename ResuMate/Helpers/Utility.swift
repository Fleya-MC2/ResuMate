//
//  Utility.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 12/06/23.
//

import Foundation

//function to date formatter
enum DateFormat {
    case year
    case yearMonth
    case yearMonthDay
}

func dateToString(_ date: Date, format: DateFormat) -> String {
    let dateFormatter = DateFormatter()
    
    switch format {
    case .year:
        dateFormatter.dateFormat = "yyyy"
    case .yearMonth:
        dateFormatter.dateFormat = "yyyy-MM"
    case .yearMonthDay:
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    return dateFormatter.string(from: date)
}

func stringToDate(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
}
