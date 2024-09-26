//
//  Untitled.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

//func fetchTasks() {
//    /// 1. Überprüfe, ob eine gültige Benutzer-ID vorhanden ist.
//    ///    Wenn nicht, wird die Funktion sofort beendet.
//    guard let userId = FirebaseManager.shared.userId else { return }
//
//    /// 2. Greife auf die Firestore-Datenbank zu und hole die Sammlung "cars".
//    ///    Filtere die Dokumente, um nur diejenigen zu finden,
//    ///    die dem aktuellen Benutzer gehören (basierend auf der userId).
//    FirebaseManager.shared.database.collection("cars")
//        .whereField("userId", isEqualTo: userId)
//        /// 3. Füge einen Snapshot-Listener hinzu. Dieser wird jedes Mal ausgelöst,
//        ///    wenn sich die Daten in der Datenbank ändern.
//        .addSnapshotListener { querySnapshot, error in
//            /// 4. Prüfe, ob ein Fehler aufgetreten ist.
//            if let error {
//                /// 5. Gib den Fehler in der Konsole aus und beende die Funktion.
//                print(error)
//                return
//            }
//
//            /// 6. Überprüfe, ob die Abfrage Ergebnisse zurückgegeben hat.
//            guard let documents = querySnapshot?.documents else {
//                /// 7. Gib eine Fehlermeldung aus und beende die Funktion.
//                print("Fehler beim Laden der Fahrzeuge")
//                return
//            }
//
//            /// 8. Konvertiere die Abfrageergebnisse in ein Array von FireTask-Objekten.
//            ///    Dabei wird versucht, jedes Dokument in ein FireTask-Objekt umzuwandeln.
//            ///    Wenn ein Fehler auftritt, wird das Element übersprungen.
////            self.cars = documents.compactMap {
////                try? $0.data(as: FireTask.self)
//            }
//        }
////}
