//
//  HomeView.swift
//  swuCanteenBooking
//
//  Created by xqst on 18/11/2566 BE.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeView: View {
    @State private var canteenDataArray: [CanteenData] = []
    @AppStorage("uid") var userID: String = ""

    
    private func fetchCanteensFromFirestore() async {
        let folderName = "canteenData"
        
        do {
            // Initialize FirebaseApp if not already done
            if FirebaseApp.app() == nil {
                FirebaseApp.configure()
            }
            
            // Initialize Firestore
            let firestore = Firestore.firestore()
            
            // Fetch data from Firestore
            let canteensRef = firestore.collection("CanteenData")
            let querySnapshot = try await canteensRef.getDocuments()
            
            // Map query snapshot to CanteenData
            let canteens = querySnapshot.documents.compactMap { document in
                let imageNames = (1...3).map { "\(folderName)\($0)" }
                let timeArray = document["time"] as? [String] ?? [] 

                return CanteenData(
                    name: document["name"] as? String ?? "",
                    description: document["description"] as? String ?? "",
                    images: imageNames,
                    tableCount: document["tableCount"] as? Int ?? 0,
                    rating: document["rating"] as? String ?? "",
                    folderName: folderName,
                    time: timeArray,
                    canteenImages: imageNames
                )
            }
            
            // Update the @State variable
            canteenDataArray = canteens
        } catch {
            print("Error fetching data from Firestore: \(error)")
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(canteenDataArray, id: \.self) { canteenData in
                        switch canteenData.name {
                        case "Canteen 1":
                            NavigationLink(destination: TableSelectionView(canteenData: canteenData, userId: $userID)) {
                                ListingItemView(canteenData: canteenData)
                                    .frame(height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        case "Canteen 2":
                            NavigationLink(destination: TableSelectionView(canteenData: canteenData, userId: $userID)) {
                                ListingItemView(canteenData: canteenData)
                                    .frame(height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        case "Canteen 3":
                            NavigationLink(destination: TableSelectionView(canteenData: canteenData, userId: $userID)) {
                                ListingItemView(canteenData: canteenData)
                                    .frame(height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .padding(.bottom, 5)
            // Fetch data when the view appears
            .onAppear {
                Task {
                    await fetchCanteensFromFirestore()
                }
            }
        }
    }
}


struct CanteenData: Hashable {
    var name: String
    let description: String
    let images: [String]
    let tableCount: Int
    let rating: String
    let folderName: String
    let time: [String]
    let canteenImages: [String]
}

struct ListingItemView: View {
    let canteenData: CanteenData
    let canteenImages: [String: [String]] = [
           "Canteen 1": ["canteen11", "canteen12", "canteen13"],
           "Canteen 2": ["canteen21", "canteen22", "canteen23"],
           "Canteen 3": ["canteen31", "canteen32", "canteen33"]
       ]

    var body: some View {
        VStack(spacing: 8) {
                  TabView {
                      ForEach(canteenImages[canteenData.name] ?? [], id: \.self) { imageName in
                    Image(imageName)
                    .resizable()
                   .scaledToFill()
                      }
                  }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(height: 150)
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
    HomeView()
}
