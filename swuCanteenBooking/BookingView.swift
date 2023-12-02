//
//  BookingView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BookingView: View {
    @ObservedObject var bookingViewModel = BookingViewModel()

    var body: some View {
           ScrollView(.vertical, showsIndicators: false) {
               HStack {
                   Spacer()
               }
               .overlay(
                   Text("My Booking")
                       .font(.title2)
                       .fontWeight(.semibold)
               )
               .padding()
               .padding(.top, 10)

               ForEach(bookingViewModel.bookings) { booking in
                   ListingItemBookingView(booking: booking)
               }
           }
        
           .background(Color.white)
           .onAppear {
               // Fetch bookings when the view appears
               if let currentUserID = Auth.auth().currentUser?.uid {
                   bookingViewModel.fetchBookings(forUserID: currentUserID)
               }
           }
       }
   }


struct ListingItemBookingView: View {
//    let canteenData: CanteenData
    let booking: Booking

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
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
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(booking.canteenName)
                        .fontWeight(.bold)
                    
                    Text(dateFormatter.string(from: booking.date))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("Table: \(booking.table)")
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                    Text(booking.time)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                }
                
                Spacer()
            }
        }
        .padding()
    }
}

struct Booking: Identifiable, Codable {
    @DocumentID var id: String?
    var table: Int
    var date: Date
    var time: String
    var userID: String
    var canteenName: String
}

class BookingViewModel: ObservableObject {
    @Published var bookings: [Booking] = []

        func fetchBookings(forUserID userID: String) {
            // ดึงข้อมูลการจองจาก Firestore ที่มีเงื่อนไขตรงกับ userID
            let db = Firestore.firestore()
            db.collection("Bookings")
                .whereField("userID", isEqualTo: userID)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching bookings: \(error.localizedDescription)")
                        return
                    }

                    guard let documents = snapshot?.documents else {
                        print("No documents found.")
                        return
                    }

                    // แปลงข้อมูล Firestore เป็น struct Booking
                    self.bookings = documents.compactMap { queryDocumentSnapshot in
                        try? queryDocumentSnapshot.data(as: Booking.self)
                    }
                }
        }
    }


#Preview {
    BookingView()
}

