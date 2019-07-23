//
//  BookItemView.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rightsx reserved.
//

import SwiftUI

struct BookItemView: View {
    private var displayData: BookDisplayData
    @State private var bookImage: UIImage? = nil
    private let placeholderImge = UIImage(systemName: "camera")!

    init(displayData: BookDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        HStack {
            Image(uiImage: bookImage ?? placeholderImge)
                .resizable()
                .onAppear {
                    self.displayData.fetchImage { image in
                        self.bookImage = image
                    }
                }
                .frame(width: 50, height: 65)
                .clipShape(Rectangle())
            
            VStack(alignment: .leading) {
                Text(displayData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Authors:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)


                    ForEach(displayData.authors, id: \.self){ e in
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
        BookItemView(displayData: BookDisplayData(id: "1234", title: "Book Title", authors: ["Author1","Author2"], description: "Book Description", thumbnail: URL(string:"bookDemo")!))
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("BookItemView")
    }
}
#endif
