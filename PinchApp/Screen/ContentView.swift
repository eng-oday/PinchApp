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
    @State var isDrawerOpen:Bool            = false
    @State var DrawerImage:String           = "chevron.compact.left"
    
    
    func resetImageState() {
        return withAnimation(.linear(duration: 0.5)) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {

        NavigationView {
            
            ZStack{
                
                Color.clear
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
                            imageOffset = .zero
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
                
                //MARK: - 3. MAGNIFICATION
                
                    .gesture(
                    
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5  {
                                        imageScale = value
                                    }else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    imageScale = 1
                                    imageOffset = .zero
                                   // resetImageState()
                                }
                            })
                    )
                

            }//: ZSTACK
            
            
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isAnimating = true
            }
            

        // MARK:  INFO PANEL
            .overlay(InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top,30)
                ,alignment: .top
            )
            
        // MARK:  CONTROLE PANEL
            .overlay(
                Group {
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1 {
                                        imageOffset = .zero
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        } // MINUS BUTTON
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        } // RESET BUTTON
                        
                        Button {
                            
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        } // PLUS BUTTON

                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
             } // MAGNIFICATION VIEW
                .padding(.bottom,30)
                ,alignment: .bottom
            )
            
        // MARK:  PAGE TUMBNAIL
            
            .overlay (
                HStack{
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundColor(.secondary)
                    
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    
                    Spacer()
                } // PAGE THUMBNAIL VIEW
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0 )
                    .frame(width:260)
                    .padding(.top , UIScreen.main.bounds.height / 12)
                    .offset(x:isDrawerOpen ? 20 : 215)
                , alignment : .topTrailing
                
            )
            
            
            
        } //: NVAIGATION VIEW
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
