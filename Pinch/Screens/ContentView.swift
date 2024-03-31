//
//  ContentView.swift
//  Pinch
//
//  Created by Hasan on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    @State private var isDrawerOpen : Bool = false
    @State private var pageIndex : Int = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                // to force ZStack to fill the entire screen
                Color.clear
                // MARK: - Image
                Image(pages[pageIndex].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2),radius: 12, x:2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(imageOffset)
                    .scaleEffect(imageScale)
                    .animation(.linear(duration: 1), value: isAnimating)
                // MARK: - Tap Gesture
                    .onTapGesture (count: 2){
                        if imageScale == 1 {
                            withAnimation(.spring){
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring){
                                imageScale = 1
                                if imageOffset != .zero {
                                    imageOffset = .zero
                                }
                            }
                        }
                    }
                // MARK: - Drag Gesture
                    .gesture(
                        DragGesture()
                            .onChanged(){ gesture in
                                let width = gesture.translation.width
                                let height = gesture.translation.height
                                withAnimation(.spring){
                                    imageOffset = CGSize(width: width, height: height)
                                }
                            }.onEnded() { _ in
                                withAnimation(.spring){
                                    if imageScale == 1 {
                                        imageOffset = .zero
                                    }
                                }
                            }
                    )
                // MARK: - Magnification Gesture
                    .gesture(MagnificationGesture()
                        .onChanged(){ value in
                            if (value >= 1 && value <= 5){
                                withAnimation(.spring){
                                    imageScale = value
                                }
                            }
                        }.onEnded(){ _ in
                            
                        }
                    )
            }// ZStack
            .navigationTitle("Pinch")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                isAnimating = true
            }
            // MARK: - Info panel
            .overlay(alignment:.top){
                InfoPanelView(imageScale: imageScale, imageOffset: imageOffset)
                    .padding(.horizontal, 10)
            }
            // MARK: - Control panel
            .overlay(alignment:.bottom){
                Group {
                    HStack{
                        // scale down
                        Button{
                            if imageScale > 1{
                                withAnimation(.spring){
                                    imageScale -= 1
                                }
                        
                            }
                        }label: {
                            Image(systemName: "minus.magnifyingglass")
                        }
                        // reset
                        Button{
                            withAnimation(.spring) {
                                imageScale = 1
                                imageOffset = .zero
                            }
                        }label: {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        // scale up
                        Button{
                            if imageScale < 5 {
                                withAnimation(.spring){
                                    imageScale += 1
                                }
                               
                            }
                        }label: {
                            Image(systemName: "plus.magnifyingglass")
                        }
                    }
                    .font(.system(size: 34))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: -20)
                    .animation(.spring, value : isAnimating)
                }
            }
            // MARK: - Drawer
                .overlay(alignment:.topTrailing){
                    HStack(spacing:5){
                        Button{
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        } label: {
                            Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                                .font(.system(size: 34))
                                .foregroundColor(.secondary)
                        }
                        Spacer()

                        ForEach(pages){ page in
                            Image(page.thumbName)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                                .frame(width: 100 , height: 120)
                                .shadow(radius: 10)
                                .opacity(isDrawerOpen ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                                .onTapGesture(){
                                    withAnimation(.easeOut){
                                        pageIndex = page.id
                                    }
                                }
                        }
                        Spacer()
                    }
                    .frame(width: 250)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .offset(x: isDrawerOpen ? 30 : 240 ,y:70)
                        .opacity(isAnimating ? 1 : 0)
                }
        } // NavigationView
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
