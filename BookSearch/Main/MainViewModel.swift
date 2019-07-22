//
//  MainViewModel.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import SwiftUI
import Combine

final class MainViewModel: BindableObject {
    
    var willChange = PassthroughSubject<MainViewModel, Never>()
 
    @Published
    var searchText = "" {
        didSet { willChange.send(self) }
    }
    
    private (set) var items = [BookDisplayData]() {
        didSet { willChange.send(self) }
    }
}
