//
//  ContentView.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObjectBinding
    private var viewModel = MainViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBarView(text: $viewModel.searchText)
                
                List{
                    Text("Item")
                }
            }
            .navigationBarTitle(Text("Book Search"))
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
