//
//  CanteenDataModel.swift
//  swuCanteenBooking
//
//  Created by xqst on 24/11/2566 BE.
//

//import SwiftUI
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import Combine
//
//class FirestoreCanteenViewModel: ObservableObject {
//    @Published var firestoreCanteenDataArray = [FirestoreCanteenData]()
//
//    private var cancellables: Set<AnyCancellable> = []
//
//    init() {
//        fetchData()
//    }
//
//    func fetchData() {
//        let db = Firestore.firestore()
//        db.collection("CanteenData").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching documents: \(error!)")
//                return
//            }
//
//            let newData = documents.compactMap { document in
//                do {
//                    let data = try document.data(as: FirestoreCanteenData.self)
//                    return data
//                } catch {
//                    print("Error decoding Firestore data: \(error)")
//                    return nil
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.firestoreCanteenDataArray = newData
//            }
//        }
//    }
//}
//
//struct FirestoreCanteenData: Identifiable, Decodable {
//    var id: String
//    var name: String
//    var description: String
//    var tableCount: Int
//    var rating: String
//    var images: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case description
//        case tableCount
//        case rating
//        case images
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        description = try container.decode(String.self, forKey: .description)
//        tableCount = try container.decode(Int.self, forKey: .tableCount)
//        rating = try container.decode(String.self, forKey: .rating)
//        images = try container.decode([String].self, forKey: .images)
//    }
//}
