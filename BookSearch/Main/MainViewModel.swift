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
    
    private (set) var searchCancellable: Cancellable? {
        didSet {  oldValue?.cancel() }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init() {
        print("Init ViewModel")
        
        searchCancellable =  willChange.eraseToAnyPublisher()
        .map{
            $0.searchText
        }
        .debounce(for: 0.5, scheduler: DispatchQueue.main)
        .removeDuplicates()
        .filter({!$0.isEmpty &&  $0.first != " "})
            .flatMap({(searchString) -> AnyPublisher<[Book], Never> in
                print("searching: \(searchString)")
                
                return APIService.searchBy(title: searchString)
                .replaceError(with: [])
                .eraseToAnyPublisher()
            })
        .map{
            self.booksToBookDisplayData(books: $0)
        }
        .replaceError(with: [])
        .assign(to: \.items, on: self)
    }
    
    private func booksToBookDisplayData(books: [Book]) -> [BookDisplayData]  {
            var displayDataItems = [BookDisplayData]()
            
            books.forEach {
                let displayData = BookDisplayData(id: $0.id, title: $0.volumeInfo?.title ?? "", authors: $0.volumeInfo?.authors ?? [], description: $0.volumeInfo?.description ?? "", thumbnail: $0.volumeInfo?.imageLinks?.thumbnail)
                displayDataItems.append(displayData)
            }
            return displayDataItems
        }
}
