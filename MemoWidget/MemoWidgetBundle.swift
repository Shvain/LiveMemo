//
//  MemoWidgetBundle.swift
//  MemoWidget
//
//  Created by Takuto Oyama on 2025/05/26.
//

import WidgetKit
import SwiftUI

@main
struct MemoWidgetBundle: WidgetBundle {
    var body: some Widget {
        MemoWidget()
        MemoWidgetControl()
        MemoWidgetLiveActivity()
    }
}
