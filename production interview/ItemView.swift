//
//  ItemView.swift
//  production interview
//
//  Created by Brynne Delaney on 01/02/2024.
//

import SwiftUI

struct ItemView: View {
    var product: Product
    var originalPrice: Double { Double(product.price)/(1-(product.discountPercentage/100))
    }
    @EnvironmentObject private var vm: SearchViewModel
    
    var body: some View {
        VStack (alignment:.leading){
            ScrollView (.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 200))]) {
                    ForEach(product.images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: product.images[index])) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .shadow(color: .gray, radius: 1)
                        } placeholder: {
                            Color.gray
                                .shadow(color: .gray, radius: 1)
                        }
                    }
                }
            }
                
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.white)
            
            ScrollView {
                VStack (alignment: .leading){
                    details()
                        .padding(.bottom)
                    
                    Text("Comments")
                        .fontWeight(.bold)
                    Section {
                        switch vm.commentState {
                        case .idle:
                            EmptyView()
                        case .loading:
                            Text("Loading...")
                        case .success(let response):
                            comments(response)
                        case .error(let error):
                            Text(error.localizedDescription)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    private func comments(_ comments: [Comment]) -> some View {
        VStack (alignment: .leading){
            ForEach(comments) { comment in
                VStack (alignment: .leading){
                    HStack{
                        Image(systemName: "person.fill")
                            .font(.callout)
                        Text(comment.user.username)
                        Spacer()
                    }
                    Text(comment.body)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.primary)
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    @ViewBuilder
    private func details() -> some View {
        VStack (alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(product.brand)
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
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
            }
            Text(product.description)
            HStack {
                starBuilder()
                Text(String(format: "%.2f", product.rating))
                    .font(.footnote)
            }
            .padding(.vertical)
            
            Text("How do you want your item?")
                .font(.headline)
                .fontWeight(.bold)
            HStack {
                VStack {
                    Image(systemName: "box.truck.fill")
                        .foregroundStyle(.blue)
                        .font(.callout)
                    
                    Text("Shipping")
                        .padding(2)
                    Text("Arrives feb 5")
                        .font(.caption)
                    Text("Free")
                        .font(.caption)
                }
                .padding()
                .frame(width: 120, height: 115)
                .border(.gray)
                
                VStack {
                    Image(systemName: "car.fill")
                        .foregroundStyle(.gray)
                        .font(.callout)
                    
                    Text("Pickup")
                        .padding(5)
                    
                    Text("Not Available")
                        .font(.caption)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 120, height: 115)
                .border(.gray)
                
                VStack {
                    Image(systemName: "bag.fill")
                        .foregroundStyle(.gray)
                        .font(.callout)
                    
                    Text("Delivery")
                        .padding(4)
                    
                    Text("Not Available")
                        .font(.caption)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 120, height: 115)
                .border(.gray)
            }
            .padding(.bottom)
            
            Text("Delivery to Chapel Hill, 27516")
                .padding(.bottom)
            HStack {
                Spacer()
                Text("Buy Now")
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.primary)
                            .frame(width: 150, height: 40)
                        
                    }
                Spacer()
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150, height: 40)
                    .foregroundStyle(.blue)
                    .overlay {
                        Text("Add to cart")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
            }
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
    ItemView(product: SearchViewModel.example)
}
