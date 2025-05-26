//
//  MemoWidgetLiveActivity.swift
//  MemoWidget
//
//  Created by Takuto Oyama on 2025/05/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MemoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MemoWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MemoWidgetAttributes {
    fileprivate static var preview: MemoWidgetAttributes {
        MemoWidgetAttributes(name: "World")
    }
}

extension MemoWidgetAttributes.ContentState {
    fileprivate static var smiley: MemoWidgetAttributes.ContentState {
        MemoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MemoWidgetAttributes.ContentState {
         MemoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MemoWidgetAttributes.preview) {
   MemoWidgetLiveActivity()
} contentStates: {
    MemoWidgetAttributes.ContentState.smiley
    MemoWidgetAttributes.ContentState.starEyes
}
