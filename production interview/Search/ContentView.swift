//
//  ContentView.swift
//  production interview
//
//  Created by Brynne Delaney on 01/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var zipcode: Double = 27516

    @FocusState private var focused: Bool?
    @StateObject private var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Rectangle()
                    .frame(height: 150)
                    .ignoresSafeArea()
                    .foregroundColor(.blue)
                    .overlay {
                        VStack {
                            HStack {
                                Button {} label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                }
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.white)
                                    .frame(height: 40)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                            TextField("Search", text: $vm.searchTerm)
                                                .onSubmit {
                                                    Task {
                                                        await vm.loadSearch()
                                                    }
                                                }
                                            Spacer()
                                            Image(systemName: "barcode")
                                        }
                                        .padding()
                                    }
                                Image(systemName: "cart")
                                    .foregroundStyle(.white)
                            }
                            .padding([.horizontal, .bottom])
                            HStack {
                                Text("How do you want your items? | \(String(format: "%.f", zipcode))")
                                    .foregroundStyle(.white)
                                Spacer()
                                Button { } label: {
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                }

                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        
                    }
                Section {
                    switch vm.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        loadingView
                    case .success(let response):
                        searchResult(response)
                    case .error(let error):
                        errorView(error)
                    }
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func searchResult(_ products: [Product]) -> some View {
        Text("Results for \(vm.searchTerm)")
        ScrollView {
            ForEach(products) { product in
                NavigationLink {ItemView(product: product)} label: {
                    ProductListing(product: product)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    private func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
}

#Preview {
    ContentView()
}
