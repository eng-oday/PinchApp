//
//  ControlImageView.swift
//  PinchApp
//
//  Created by 3rabApp-oday on 27/07/2023.
//

import SwiftUI

struct ControlImageView: View {
    
    var icon:String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
