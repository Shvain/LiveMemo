//
//  SharedAttributes.swift
//  LiveMemo
//
//  Created by Takuto Oyama on 2025/05/26.
//

import ActivityKit

public struct MemoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var emoji: String
    }
    public var name: String
}
