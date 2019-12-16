//
//  String+Extensions.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

extension String {
    // returns a 8601 Date formatter
  static func getISOFormatter() -> ISO8601DateFormatter {
    let isoDateFormatter = ISO8601DateFormatter()
      isoDateFormatter.timeZone = .current
      isoDateFormatter.formatOptions = [
        .withInternetDateTime,
        .withFullDate,
        .withFullTime,
        .withFractionalSeconds, // must have this option
        .withColonSeparatorInTimeZone
      ]
    return isoDateFormatter
  }
  
  // String.getISOTimeStamp 
  static func getISOTimestamp() -> String {
    let isoDateFormatter = getISOFormatter()
    let timestamp = isoDateFormatter.string(from: Date())  // gets current date and time
    return timestamp
  }
    
  func convertISODate() -> String {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return self
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d yyyy, h:mm a"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
  }
  
  func isoStringToDate() -> Date {
    let isoDateFormatter = String.getISOFormatter()
    guard let date = isoDateFormatter.date(from: self) else {
      return Date()
    }
    return date
  }
}
