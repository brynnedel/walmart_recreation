//
//  ProductListing.swift
//  production interview
//
//  Created by Brynne Delaney on 02/02/2024.
//

import SwiftUI

struct ProductListing: View {
    var product: Product
    var originalPrice: Double { Double(product.price)/(1-(product.discountPercentage/100))
    }
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray
            }
            .frame(width: 160, height: 150)
            .padding()
            VStack (alignment: .leading){
                HStack {
                    Text("$\(product.price)")
                        .foregroundStyle(.green)
                        .fontWeight(.bold)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    Text("$\(String(format: "%.2f", originalPrice))")
                        .font(.footnote)
                        .strikethrough()
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 4)
                Text(product.title)
                    .fontWeight(.light)
                    .padding(.bottom, 4)
                HStack {
                    starBuilder()
                    Text(String(format: "%.2f", product.rating))
                        .font(.footnote)
                }
                .padding(.bottom)
                Button {} label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 40)
                        .padding(.trailing)
                        .overlay {
                            Text("Add to Cart")
                                .foregroundStyle(.white)
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                }
            }
            .frame(height: 175)
        }
    }
    
    @ViewBuilder
    private func starBuilder() -> some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= Int(product.rating) ? "star.fill" : "star")
                    .frame(width: 5)
                    .font(.footnote)
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    ProductListing(product: SearchViewModel.example)
}
