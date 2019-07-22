//
//  SearchBarView.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding
    var text: String
    
    var body: some View {
        
        ZStack {
            
            Color.blue
            HStack{
                TextField("Type a Book name", text: $text)
                    .padding([.leading,.trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
            }
            .padding([.leading,.trailing], 16)
        }
        .frame(height: 64)
    }
}

#if DEBUG
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
