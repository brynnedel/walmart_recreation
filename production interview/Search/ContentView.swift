//
//  ContentView.swift
//  production interview
//
//  Created by Brynne Delaney on 01/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var searchTerm: String = "laptop"
    @State var zipcode: Int = 27516

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
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.white)
                                    .frame(height: 40)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                            Text(searchTerm)
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
                                Text("How do you want your items? | \(zipcode)")
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
                Text("Results for \"\(searchTerm)\"")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
