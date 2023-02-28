//
//  File.swift
//  
//
//  Created by ExecutionLab's Macbook on 20/07/2022.
//

import SwiftUI

public struct EnumeratedForEach<ItemType, ContentView: View>: View {
    public let data: [ItemType]
    public let content: (Int, ItemType) -> ContentView
    
    public init(_ data: [ItemType], @ViewBuilder content: @escaping (Int, ItemType) -> ContentView) {
        self.data = data
        self.content = content
    }
    
    public var body: some View {
        ForEach(Array(self.data.enumerated()), id: \.offset) { idx, item in
            self.content(idx, item)
        }
    }
}
