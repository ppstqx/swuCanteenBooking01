//
//  HomeView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI

struct HomeView: View {
    var body: some View {

        NavigationStack{
            ScrollView {
                LazyVStack {
                    ForEach(0...3, id: \.self) { listing in
                        ListingItemView()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
            }
        }
  }
}

#Preview {
    HomeView()
}
