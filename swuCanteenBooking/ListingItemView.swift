//
//  ListingItemView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI

struct ListingItemView: View {
    var body: some View {
        VStack(spacing: 8){
            Rectangle()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            //listing details
            
            HStack (alignment: .top){
                VStack(alignment: .leading) {
                    Text("Canteen 1")
                        .fontWeight(.bold)
                    
                    Text("Description")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("Available 40")
                        .fontWeight(.bold)
                        .foregroundStyle(.green)

                }
                
                Spacer()
                
                HStack(spacing: 2 ){
                    Image(systemName: "star.fill")
                    
                    Text("4.8")
                }

            }
            
            
            //rating
            .font(.footnote)
        }
        .padding()
    }
}

#Preview {
    ListingItemView()
}
