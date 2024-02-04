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
            ZStack (alignment: .top){
                Color(.blue)
                    .frame(height: 150)
                    .ignoresSafeArea()
                VStack (spacing: 0){
                    HStack (alignment: .center){
                        Button {} label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.leading)
                        }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                            .frame(height: 40)
                            .overlay {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    TextField("Search", text: $vm.searchTerm)
                                        .foregroundStyle(.black)
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
                            .padding(.trailing)
                    }
                    .padding(.bottom)
                    HStack {
                        Text("How do you want your items? | \(String(format: "%.f", zipcode))")
                            .foregroundStyle(.white)
                            .padding(.leading)
                        Spacer()
                        Button { 
                            //Future challenge allow to change
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.trailing)
                        }
                        
                    }
                    .padding(.bottom)
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
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func searchResult(_ products: [Product]) -> some View {
        VStack (alignment: .leading){
            Text("Results for \"\(vm.searchTerm)\"")
                .fontWeight(.bold)
                .padding(.top)
            ScrollView {
                ForEach(products) { product in
                    NavigationLink {
                        ItemView(product: product)
                            .environmentObject(vm)
                            .task {
                                await vm.loadComments()
                            }
                    } label: {
                        VStack {
                            ProductListing(product: product)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    @ViewBuilder
    public var loadingView: some View {
        Text("Loading...")
    }
    
    @ViewBuilder
    public func errorView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
}

#Preview {
    ContentView()
}
