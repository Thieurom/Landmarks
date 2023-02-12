//
//  DataManager.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import Dependencies
import Foundation
import Models

public enum Error: Swift.Error {

    case fileNotFound
    case failToReadFile
    case decoding
}

public struct DataManager: Sendable {

    public var loadLandmarks: @Sendable (String, Bundle) throws -> [Landmark]
}

extension DataManager {

    private static func load<T: Decodable>(_ filename: String, in bundle: Bundle) throws -> T {
        guard let file = bundle.url(forResource: filename, withExtension: nil)
            else {
            throw Error.fileNotFound
        }

        let data: Data

        do {
            data = try Data(contentsOf: file)
        } catch {
            throw Error.failToReadFile
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw Error.decoding
        }
    }
}

extension DataManager: DependencyKey {

    public static let liveValue = DataManager(
        loadLandmarks: { filename, bundle in
            try load(filename, in: bundle)
        }
    )

    public static let testValue = DataManager(
        loadLandmarks: unimplemented("\(Self.self).loadLandmarks")
    )

    public static let mock = DataManager(
        loadLandmarks: { _, _ in
            return Landmark.sampleData
        }
    )
}

extension DependencyValues {

    public var dataManager: DataManager {
        get { self[DataManager.self] }
        set { self[DataManager.self] = newValue }
    }
}
