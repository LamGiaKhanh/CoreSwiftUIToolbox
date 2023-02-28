//
//  SizeCalculator.swift
//  
//
//  Created by xuanbach on 28/08/2022.
//

import SwiftUI

public class SizeCalculator {
    public static func width(padding: CGFloat = 0, itemPerRow: Int = 1, spaceBetweenItem: CGFloat = 0) -> CGFloat {
        let widthOfItems = AppConstants.screenSize.width - padding * 2 - spaceBetweenItem * CGFloat((itemPerRow - 1))
        return widthOfItems / CGFloat(itemPerRow)
    }
}
