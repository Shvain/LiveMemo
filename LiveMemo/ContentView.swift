//
//  ContentView.swift
//  LiveMemo
//
//  Created by Takuto Oyama on 2025/05/26.
//

import SwiftUI
import ActivityKit

// ❶ 浮かせる丸ボタン ─ 既存のまま
struct FloatingButton: View {
    var systemName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(Color.black)
                .clipShape(Circle())
                .shadow(radius: 6)
        }
    }
}

// ❷ ヘッダー内に置く白枠カード（新コンポーネント）
struct MemoBox: View {
    var text: String
    var trailingSystemName: String = "checkmark"
    
    private let cardWidthToHeightRatio: CGFloat = 371.0 / 160.0
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
                .lineLimit(nil)
            
            Spacer()
            
            Image(systemName: trailingSystemName)
                .foregroundColor(.white)
                .font(.title2)
        }
        .padding(18)
        .frame(maxWidth: .infinity, maxHeight: 160)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.white, lineWidth: 3)
        )
    }
}

struct HeaderCircle: View {
    var body: some View {
        // 端末幅を直接取得
        let screenW = UIScreen.main.bounds.width
        
        Circle()
            .fill(Color.black)
            .frame(width: screenW * 2.0,
                   height: screenW * 2.0)
        
            .position(x: screenW / 2)
            .offset(y: -screenW * 0)      // 好みで上下調整
    }
}

public struct OrderStatusAttributes: ActivityAttributes {
    // ライブ中に更新していくコンテンツの型
    public struct ContentState: Codable, Hashable {
        var value: Int
    }
    
    // 起動時に渡す固定の属性
    public var name: String
}

// ❸ 画面全体
struct ContentView: View {
    @State private var memo = "ダイソーに買いに行く"
    @State private var isShowingInput = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景は真っ白
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // ── 黒い巨大円ヘッダー ───────────────────────
                    GeometryReader { geo in
                        ZStack(alignment: .top) {
                            // ── 黒い巨大円 ────────────────────────────────
                            HeaderCircle()
                            
                            MemoBox(text: memo)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                                .padding(.top, 80)
                        }
                    }
                    .frame(height: 350)
                    
                    Spacer()
                }
                
                // ── 浮く＋ボタン ───────────────────────────────
                VStack {
                    Spacer()
                    FloatingButton(systemName: "plus") {
                        addLiveActivity()
                        isShowingInput = true
                    }
                    .padding(.bottom, 80)
                }
            }
            .navigationTitle("LiveMemo")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .sheet(isPresented: $isShowingInput) {
                InputModal(memo: $memo)
            }
            
        }
        
    }
    private func addLiveActivity() {
        let orderAttributes = OrderStatusAttributes(name: "test")
        let initialState    = OrderStatusAttributes.ContentState(value: 1)
        // ← supply staleDate: nil here
        let activityContent = ActivityContent(state: initialState, staleDate: nil)
        
        do {
            let activity = try Activity<OrderStatusAttributes>.request(
                attributes: orderAttributes,
                content:    activityContent,
                pushType:   nil      // omit if you don’t need push
            )
            print("Activity started! id = \(activity.id)")
        } catch {
            print("Failed to start Live Activity:", error)
        }
    }
}

#Preview {
    ContentView()
}
