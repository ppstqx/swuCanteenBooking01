//
//  ListingItemView1.swift
//  swuCanteenBooking
//
//  Created by xqst on 24/11/2566 BE.
//

import SwiftUI
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ListingItemView1: View {
    let canteenData: FirestoreCanteenData

      var body: some View {
          VStack(spacing: 8) {
              TabView {
                  ForEach(canteenData.images, id: \.self) { imageName in
                      Image(imageName)
                          .resizable()
                          .scaledToFill()
                  }
              }
              .frame(height: 150)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .tabViewStyle(.page)

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
    ListingItemView1(canteenData: FirestoreCanteenData(
        name: "Canteen 1",
        images: ["canteen1", "canteen12", "canteen13"],
        description: "โรงเย็น",
        tableCount: 40,
        rating: "4.8"
    )
}
