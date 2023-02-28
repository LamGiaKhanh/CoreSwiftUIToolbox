//
//  PageListener.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 06/06/2022.
//

import Foundation

class PagesListener {
    var currentPage: Int = 1 {
        didSet {
            loadPage()
        }
    }
    
    func loadPage() {
        
    }
}
