//
//  EntryController.swift
//  JournalPracticeOne
//
//  Created by Taylor Bills on 8/13/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: -  Properties
    static let shared = EntryController()
    var entries: [Entry] = []
    
    // MARK: -  Load from persistence
    init (){
        self.entries = loadFromPersistentStorage()
    }
    
    // MARK: -  CRUD Functions
    // Create new entry
    func createEntry(title: String, body: String) {
        let timeStamp = GlobalFunctions.shared.formatTimeStamp()
        let newEntry = Entry(timestamp: timeStamp, title: title, body: body)
        self.entries.append(newEntry)
        saveToPersistence()
    }
    
    func delete(entry: Entry) {
        if let indexOfEntry = entries.index(of: entry) {
            entries.remove(at: indexOfEntry)
            saveToPersistence()
        } else {
            print("Entry not found: \(#file); \(#function)")
        }
    }
    
    // MARK: -  Persistence
    //Save Location
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "entries.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    // Save Files
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(self.entries)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to disk: \(error.localizedDescription)")
        }
    }
    
    // Load Files
    func loadFromPersistentStorage() -> [Entry] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let loadedEntries = try jsonDecoder.decode([Entry].self, from: data)
            return loadedEntries
        } catch let error {
            print("Error loading from disk \(error.localizedDescription)")
            return []
        }
    }
}
