//
//  File.swift
//
//
//  Created by Aung Ko Min on 17/1/22.
//

import UIKit

public struct PaginatedScrollViewSettings {
    
    public var moreLoaderThreshold: CGFloat
    public var reloaderThreshold: CGFloat
    
    public static let defaultSettings = PaginatedScrollViewSettings(moreLoaderThreshold: 50, reloaderThreshold: 140)
}
