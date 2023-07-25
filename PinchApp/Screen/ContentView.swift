//
//  ContentView.swift
//  PinchApp
//
//  Created by 3rabApp-oday on 25/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnimating:Bool             = false
    @State var imageScale:CGFloat           = 1
    @State var imageOffset:CGSize           = .zero
    
    
    func resetImageState() {
        return withAnimation(.linear(duration: 1)) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {

        NavigationView {
            
            ZStack{
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .animation(.linear(duration: 2), value: isAnimating)
                    .scaleEffect(imageScale)
                
                // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2) {
                        if imageScale != 1 {
                            imageScale = 1
                        }else {
                            imageScale = 5
                        }
                    }
                
                //MARK: - 2. DRAG GESTURE
                
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ value in
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }

                            })
                    )

                    
            }//: ZSTACK
            
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isAnimating = true
            }
        } //: NVAIGATION VIEW
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
