//
//  BookItemView.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rightsx reserved.
//

import SwiftUI

struct BookItemView: View {
    
    private var  displayData: BookDisplayData
    
    @State
    private var bookImage: UIImage? = nil
    
    private let placeHolderImage = UIImage(named: "bookPlaceHolder")
    
    init(displayData: BookDisplayData) {
        self.displayData = displayData
    }
    var body: some View {
        HStack{
            
            Image(uiImage: bookImage ?? placeHolderImage!)
                .resizable()
                .onAppear(perform: {
                    self.displayData.fetchImage(completion: { image in
                        self.bookImage = image
                    })
                })
                .frame(width: 50, height: 65)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.gray,lineWidth: 1))
            
            VStack(alignment: .leading){
                Text(displayData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack{
                    Text("Authors:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    ForEach(displayData.authors, id:  \.self){ e in
                        Text(e)
                            .font(.footnote)
                    }
                }
            }
            Spacer()
            
        }
        .frame(height: 65)
    }
}

#if DEBUG
struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView(displayData: BookDisplayData(id: "1234", title: "Demo Book Demo Book Demo Book Demo Book Demo Book", authors: ["Author1","Author2"], description: "BookDescription", thumbnail: URL(string:"bookDemo")!))
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("BookItemView")
    }
}
#endif
