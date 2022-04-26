//
//  AppService.swift
//  JsonParse
//
//  Created by TDCC_IFD on 2022/4/26.
//

import Foundation

struct List: Codable {
    var response: Int?
    var message: String?
    var data: [ String: [Broker]? ]?
}

struct Broker: Codable {
    var billNum: String?
    var total: String?
}

class AppService {
    static let shared = AppService()
    var list: List?
    var brokers: [Broker]? {
        if let brokers = AppService.shared.list?.data?.values.first  {
            return brokers
        }
        return nil
    }
    
    init() { }
    
    func loadData() {
        readFile()
    }
    
    func insert(row: Int) {
        let new = Broker(billNum: String(row), total: "APP新增\(row)")
        list?.data?["broker"]??.insert(new, at: row)
    }
    
    func delete(row: Int) {
        list?.data?["broker"]??.remove(at: row)
    }
    
    func save() {
        let fileName = "myjson"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return
        }
        
        do {
            let jsonData = try JSONEncoder().encode(list)
            try jsonData.write(to: URL(fileURLWithPath: path), options: .noFileProtection)            
        } catch {
            print(error)
        }
    }
    
    private func readFile() {
        let fileName = "myjson"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            list = try JSONDecoder().decode(List.self, from: data)
            
        } catch {
            print(error)
        }
    }
}
