//
//  FileService.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 27.07.2023.
//

import Foundation

final class FileService {
    
    public static let shared = FileService()
    
    private init(){}
    
    func writeModel(items: [Item]){
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("cannot access documents directory")
            return
        }
        let fileURL = documentsURL.appendingPathComponent("savedInventory")
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL)
        } catch {
            print("cannot write to file")
        }
    }
    
    func readModel() -> [Item]{
        guard let documentsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return []
        }
        let fileURL = documentsURL.appendingPathComponent("savedInventory")
        do {
            let data = try Data(contentsOf: fileURL)
            let object = try JSONDecoder().decode([Item].self, from: data)
            return object
            
        } catch {
            return []
        }
    }
}
