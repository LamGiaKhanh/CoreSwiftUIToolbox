//
//  AppConstants.swift
//  Common
//
//  Created by Phat Le on 12/04/2022.
//

import SwiftUI

public enum AppConstants {
    public static let screenSize: CGSize = UIScreen.main.bounds.size
    public static let safeAreaInsets = UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets ?? .zero
    public static let navBarHeight: CGFloat = 56
    public static let buttonHeight: CGFloat = 44
    public static let bottomViewHeight: CGFloat = AppConstants.navBarHeight + safeAreaInsets.bottom
    public static let contentWithBottomViewPadding = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    public static let buttonTextSize: CGFloat = 16
    public static let topInsetWithNavBar: CGFloat = navBarHeight + safeAreaInsets.top
    public static let environmentMode: String = (Bundle.main.infoDictionary?["Environment"] as? String) ?? "Development"
    
    public static let colorTable: [String: Color] = [
        "Red": Color.red,
        "Green": Color.green,
        "Yellow": Color.yellow,
        "Blue": Color.blue,
        "Amaranth": Color(0x9F2B68),
        "Gold": Color(0xFFD700),
        "Rose": Color(0xFF0080),
        "Emerald": Color(0x319B54),
        "Champagne": Color(0xF7E7CE),
        "Scarlet": Color(0xFF2400),
        "Taupe": Color(0x483C32),
        "Salmon": Color(0xFA8072),
        "Grey": Color(0x808080),
        "Lavender": Color(0xE6E6FA),
        "Erin": Color(0xFF00BF),
        "Azure": Color(0xF0FFFF),
        "Peach": Color(0xFFE5B4),
        "Tan": Color(0xD2B48C)
    ]
    
    public static let maxVariantsCanBeAdded = 2
}

public struct CancelOrder {
    public static let reasons = [
        "Need to change delivery address",
        "Seller is not responsive my inquiries",
        "Modify existing order(color, size, voucher,etc.)",
        "Others/ Change of mind"
    ]
}

public struct MockedData {
    public static let backgroundImage = "https://55tattoo.com/wp-content/uploads/2022/06/top-50-simple-and-beautiful-background-wallpapers.jpg"
    public static let nailImage = "https://cdn.shopify.com/s/files/1/2657/6552/products/726-Pretty-Things.jpg?v=1654061721"
    public static let avatarImage = "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    public static let nipperImage = "https://m.media-amazon.com/images/I/51GT6zT1L6L._SL1500_.jpg"
    public static let email = "thang.ma@gmail.com"
    public static let phoneNumber = "0909888999"

}
