//
//  ListingItemView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

//import SwiftUI
//
//struct ListingItemView: View {
//    
//    let canteenData: CanteenData
//
//    var body: some View {
//        VStack(spacing: 8) {
//            TabView{
//                ForEach(canteenData.images, id: \.self) { image in
//               Image(image)
//                        .resizable()
//                        .scaledToFill()
//                    
//                }
//            }
//            .frame(height: 150)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .tabViewStyle(.page)
//
//            //listing details
//            
//            HStack(alignment: .top){
//                VStack(alignment: .leading) {
//                    Text(canteenData.name)
//                        .fontWeight(.bold)
//                    
//                    Text(canteenData.description)
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                    
//                    Text("Available \(canteenData.tableCount)")
//                        .fontWeight(.bold)
//                        .foregroundStyle(.green)
//
//                }
//                
//                Spacer()
//                
//                HStack(spacing: 2 ){
//                    Image(systemName: "star.fill")
//                    Text(canteenData.rating)
//                }
//
//            }
//            
//            
//            //rating
//            .font(.footnote)
//        }
//        .padding()
//    }
//}
//
//
//struct CanteenData: Hashable {
//    let name: String
//    let images: [String]
//    let description: String
//    let tableCount: Int
//    let rating: String
//
//    // Implement Hashable
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//        // You can combine other properties here if needed
//    }
//}
//
//#Preview {
//    ListingItemView(canteenData: CanteenData(
//        name: "Canteen 1",
//        images: ["canteen11", "canteen12", "canteen13"],
//        description: "โรงเย็น",
//        tableCount: 40,
//        rating: "4.8"
//    ))
//}
