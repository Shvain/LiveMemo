//
//  InputModal.swift
//  LiveMemo
//
//  Created by Takuto Oyama on 2025/05/26.
//

import SwiftUI

struct InputModal: View {
    // 既存のメモを双方向バインディングで受け取る
    @Binding var memo: String
    // シートを閉じるための環境変数
    @Environment(\.dismiss) private var dismiss
    // 編集用の下書きテキスト
    @State private var draft: String

    // イニシャライザで下書きに既存メモをコピー
    init(memo: Binding<String>) {
        self._memo = memo
        self._draft = State(initialValue: memo.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            VStack {
                // 大きめの TextEditor を丸角ボックスで囲む
                TextEditor(text: $draft)
                    .scrollContentBackground(.hidden)
                    .font(.system(size: 20, weight: .bold))
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(24)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                
                Spacer()
            }
            .navigationTitle("めもを入力")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 左に「キャンセル」
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .tint(.black)
                }
                // 右に「完了」
                ToolbarItem(placement: .confirmationAction) {
                    Button("完了") {
                        memo = draft     // 下書きを本体に反映
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    // プレビュー用ダミー
    InputModal(memo: .constant("プレビュー"))
}
