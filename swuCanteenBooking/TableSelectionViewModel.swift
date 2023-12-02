//
//  TableSelectionViewModel.swift
//  swuCanteenBooking
//
//  Created by xqst on 24/11/2566 BE.
//


import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreCanteenViewModel: ObservableObject {
    @Published var firestoreCanteenDataArray = [FirestoreCanteenData]()

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchData()
    }

    func fetchData() {
        let db = Firestore.firestore()
        db.collection("CanteenData").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }

            self.firestoreCanteenDataArray = documents.compactMap { document in
                do {
                    let data = try document.data(as: FirestoreCanteenData.self)
                    return data
                } catch {
                    print("Error decoding Firestore data: \(error)")
                    return nil
                }
            }
        }
    }
}
