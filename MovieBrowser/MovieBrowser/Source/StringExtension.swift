//
//  StringExtension.swift
//  MovieBrowser
//
//  Created by Ke Liu on 10/15/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension String {
    func dateFormatting() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
}

