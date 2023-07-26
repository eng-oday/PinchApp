//
//  InfoPanelView.swift
//  PinchApp
//
//  Created by 3rabApp-oday on 26/07/2023.
//

import SwiftUI

struct InfoPanelView: View {
    
var scale:CGFloat
var offset:CGSize
    
    @State var isInfoPanelVisible:Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            
            HStack(spacing: 2) {
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\((scale))")
                
                Spacer()
                
                
                Image(systemName: "arrow.left.and.right")
                Text("\((offset.width))")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\((offset.height))")
                
            }//: HSTACK
            .font(.footnote)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
        } //: HSTACK
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
