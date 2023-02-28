//
//  Deeplinkable.swift
//  Core
//
//  Created by ExecutionLab's Macbook on 06/06/2022.
//

import Foundation

protocol DeepLinkable {
    var children: [DeepLinkable] { get }
}
