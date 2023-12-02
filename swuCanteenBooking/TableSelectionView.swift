//
//  TableSelectionView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


struct TableSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var bookingViewModel = BookingViewModel()


    let canteenData: CanteenData
    
    @Binding var userId: String

    @State var bookedTable: [Int] = []
    @State var selectedTable : [Int] = []

    @State var date: Date = Date()
    @State var selectedTime = ""



    init(canteenData: CanteenData, userId: Binding<String>) {
         self.canteenData = canteenData
         self._userId = userId
     }
    
    var body: some View {

        VStack {
        HStack {
            Button(action: {
                               presentationMode.wrappedValue.dismiss()
                           }, label: {
                               Image(systemName: "chevron.left")
                                   .font(.title2)
                                   .foregroundColor(.black)
                                   .fontWeight(.medium)
                           })
            
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "bookmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            })
        }
    }
                    .overlay(
                        Text("Select Table")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                    )
                    .padding()
        
                    
                    // Table
            let totalTable = canteenData.tableCount // Use canteenData.tableCount directly

                    // Move these lines outside the ScrollView
                    let leftSide = 0..<totalTable/2
                    let rightSide = totalTable/2..<totalTable
            ScrollView (.vertical, showsIndicators: false, content: {

                    HStack(spacing: 38) {
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                        
                        LazyVGrid(columns: columns, spacing: 13, content: {
                            ForEach(leftSide, id: \.self) { index in
                                
                                //Getting correct table..
                                
                                let table = index + 1

                                tableView(index: index, table: table, canteenData: canteenData, selectedTable: $selectedTable, bookedTable: $bookedTable)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                    print(table)
                                        if selectedTable.contains(table) {
                                            selectedTable.removeAll { (removeTable) -> Bool in
                                                return removeTable == table
                                                
                                            }
                                            return
                                        }
                                        
//                                        selectedTable.append(table)
                            }
                                // disable if table is booked..
                                        .disabled(bookedTable.contains(table))
                            }
                        })
                        LazyVGrid(columns: columns, spacing: 13, content: {
                            ForEach(rightSide, id: \.self) { index in
                                //Getting correct table..
                                
                                let table = index + 1
                                
                                tableView(index: index, table: table, canteenData: canteenData, selectedTable: $selectedTable, bookedTable: $bookedTable)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                                                            print(table)
                                        
                                        if selectedTable.contains(table) {
                                            selectedTable.removeAll { (removeTable) -> Bool in
                                                return removeTable == table
                                                
                                            }
                                            return
                                        }
                                        
                                        selectedTable.append(table)
                                    }
                                // disable if table is booked..
                                        .disabled(bookedTable.contains(table))
                            }
                        })
                    }
                    .padding()
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
           
              HStack(spacing: 12){
                
                RoundedRectangle (cornerRadius: 4)
                    .stroke(Color.red,lineWidth: 2)
                    .frame(width: 40, height: 15)
                    .overlay(
                    
                        Image(systemName: "xmark")
                            .font(.caption)
                            .foregroundColor(.red)
                    )
                
                Text("Booked")
                      .font(.caption)
                    .foregroundColor(.black)
                    .offset(x: -3)
                
                RoundedRectangle (cornerRadius: 4)
                    .stroke(Color.green,lineWidth: 2)
                    .frame(width: 40, height: 15)
                  
                
                Text("Available")
                      .font(.caption)
                    .foregroundColor(.black)
                    .offset(x: -3)

                  
                RoundedRectangle (cornerRadius: 4)
                    .stroke(Color.green,lineWidth: 2)
                    .frame(width: 40, height: 15)
                    .background(Color.green)
                    .offset(x: -3)

                
                Text("Selected")
                      .font(.caption)
                    .foregroundColor(.black)
                    .offset(x: -3)

            }
              .padding(.vertical, 10)
              .padding(.horizontal,5)

            
            
            
            HStack{
                
                Text("Date:")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                
                Spacer()
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
              let time = canteenData.time
            ScrollView(.horizontal, showsIndicators:false,content: {
                HStack(spacing: 15) {
                    ForEach(time,id:\ .self) {timing in
                        
                        Text(timing)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color .green .opacity(selectedTime == timing ? 1 : 0.5))
                            .cornerRadius(12)
                            .onTapGesture {
                                selectedTime = timing
                            }
                        
                    }
                }
                .padding(.horizontal)
            })
            
            HStack{
                Button(action: {
                    if let selectedTable = selectedTable.first, !bookedTable.contains(selectedTable) {
                                        addBookingTable(table: selectedTable, date: date, time: selectedTime, userID: userId, canteenName: canteenData.name)
                                           }                }, label :{
                    Text("Book table")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: 280, height: 55)
                        .background(Color(.green))
                        .cornerRadius(12)
                })
            }
            .padding()
                
        })
            .navigationBarBackButtonHidden(true) // Hide system back button gesture
            .onAppear {
                        // เรียกใช้ fetchBookings เมื่อ view ปรากฏ
                bookingViewModel.fetchBookings(forUserID: userId)
                    }
            }
}


struct tableView: View {
    var index: Int
    var table: Int
    var canteenData: CanteenData


    @Binding var selectedTable: [Int]
    @Binding var bookedTable: [Int]
    
    

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(bookedTable.contains(table) ? Color.red : Color.green, lineWidth: 3)
                .frame(height: 28)
                .background(
                RoundedRectangle(cornerRadius: 8)
                .fill(selectedTable.contains(table) ? Color.green : Color.clear)
                )
            
            if bookedTable.contains(table) {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
            }
        }
        .onTapGesture {
            // Remove previously selected tables
            selectedTable.removeAll()

            // Add the newly selected table
            selectedTable.append(table)
        }
    }
}



   func addBookingTable(table: Int, date: Date, time: String, userID: String, canteenName: String) {
       let timestamp = Timestamp(date: date)

       let db = Firestore.firestore()
       db.collection("Bookings").document().setData([
           "table": table,
           "date": timestamp,
           "time": time,
           "userID": userID,
           "canteenName": canteenName
       ]) { error in
           if let error = error {
               print("Error adding booking: \(error.localizedDescription)")
           } else {
               print("Booking added successfully!")
           }
       }
   }



#Preview {
    TableSelectionView(canteenData: CanteenData(name: "Canteen 1", description: "โรงเย็น", images: ["canteen11", "canteen12", "canteen13"], tableCount: 40, rating: "4.8", folderName: "canteen1", time: ["11:25", "11:55", "12:20", "12:45", "13:05", "13:30"], canteenImages: ["canteen11", "canteen12", "canteen13"]), userId: .constant(""))

}
