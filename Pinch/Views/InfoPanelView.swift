//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Hasan on 3/30/24.
//

import SwiftUI

struct InfoPanelView: View {
    var imageScale : CGFloat
    var imageOffset : CGSize
    @State private var showInfoPanel : Bool = false
    var body: some View {
        HStack(spacing:20){
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 34))
                .onLongPressGesture(minimumDuration: 1){
                    withAnimation(.easeOut){
                        showInfoPanel.toggle()
                    }
                }
            HStack{
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text(String(format: "%.4f", imageScale))
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text(String(format: "%.4f", imageOffset.width))
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text(String(format: "%.4f", imageOffset.height))
                Spacer()
            }//: HStack
            .font(.footnote )
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .opacity(showInfoPanel ? 1 : 0)
            Spacer()
        }//: HStack
    }
}

#Preview {
    InfoPanelView(imageScale: 1, imageOffset: .zero)
        .preferredColorScheme(.light)
        .previewLayout(.sizeThatFits)
}
