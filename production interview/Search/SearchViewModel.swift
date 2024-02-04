//
//  SearchViewModel.swift
//  production interview
//
//  Created by Brynne Delaney on 01/02/2024.
//

import Foundation

enum SearchLoadingState {
    case idle
    case loading
    case success(products: [Product])
//    case detailSuccess(TitleDetails: TitleDetails)
    case error(error: Error)
}

enum CommentLoadingState {
    case idle
    case loading
    case success(comments: [Comment])
    case error(error: Error)
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var state: SearchLoadingState = .idle
    @Published var commentState: CommentLoadingState = .idle
    
    func loadSearch() async {
        Task {
            do {
                self.state = .loading
                let response = try await SearchService.getProducts(searchTerm: searchTerm)
                
                self.state = .success(products: response)
            } catch {
                self.state = .error(error: error)
            }
        }
    }
    
    func loadComments() async {
        Task {
            do {
                self.commentState = .loading
                let response = try await SearchService.getComments()
                self.commentState = .success(comments: response)
            } catch {
                self.state = .error(error: error)
            }
        }
    }
}

extension SearchViewModel {
    static let example = Product(id: 1, title: "iPhone", description: "brand new crazy phone", price: 1000, discountPercentage: 8.2, rating: 3.2, stock: 89, brand: "Apple", category: "phones", thumbnail: "", images: ["1", "2", "3"])
}
