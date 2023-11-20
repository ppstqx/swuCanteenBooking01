//
//  BookmarkView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI

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

#Preview {
    BookmarkView()
}
