//
//  BookmarkView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BookmarkView: View {

    var body: some View {
        ScrollView (.vertical, showsIndicators: false, content: {
            
            HStack {
                
                Spacer()
            }
            .overlay(
                Text("My saved places")
                    .font(.title2)
                    .fontWeight(.semibold)
            )
            .padding()
            .padding(.top,10)
            
        })
        .background(Color .white)
    }
}

struct ListingItemBookmarkView: View {
    let canteenData: CanteenData

    var body: some View {
        VStack(spacing: 8) {
//            TabView {
//                ForEach(canteenData.canteenImages, id: \.self) { imageName in
//                    Image("canteen11")
//                        .resizable()
//                        .scaledToFill()
//                }
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .frame(height: 150)
//            .tabViewStyle(.page)
            
            // Listing details
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(canteenData.name)
                        .fontWeight(.bold)
                    
                    Text(canteenData.description)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("Available \(canteenData.tableCount)")
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                    Text(canteenData.rating)
                }
            }
            .font(.footnote)
        }
        .padding()
    }
}

#Preview {
    BookmarkView()
}
