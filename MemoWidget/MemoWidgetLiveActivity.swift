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
                Text(context.attributes.name)
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.name)
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                            Spacer()
                            Button(action: {
                                // ボタンタップ時の処理
                            }) {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.white)
                                    .padding(5)
                            }
                        }
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Image(systemName: "exclamationmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .red)
                        .font(.system(size: 16, weight: .bold))
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
        MemoWidgetAttributes(name: "Worldああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ")
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
