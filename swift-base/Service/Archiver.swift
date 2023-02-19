
import Foundation

protocol ArchiverInput: AnyObject {
    /// Save generic data to userdefaults
    func saveFromUserDefaults<T: Encodable>(data: T, forkey key: String)
    /// Retrive data from userdefaults by key
    func loadFromUserDefaults<T: Decodable>(type: T.Type, forKey key: String) -> T?
    /// Delete object from userdefaults by key
    func deleteFromUserDefaults(forKey key: String)
}

enum Keys: String {
    case score
    case game
}

enum SettingKey: String, CaseIterable {
    case hint
    case theme
    case sound
}

final class Archiver: ArchiverInput {

    //MARK: - Private Properties

    private let userDefaults: UserDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    //MARK: - Public methods

    func saveFromUserDefaults<T: Encodable>(data: T, forkey key: String) {
        do {
            let data = try encoder.encode(data)
            userDefaults.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadFromUserDefaults<T: Decodable>(type: T.Type, forKey key: String) -> T? {
        if let data = userDefaults.object(forKey: key) as? Data,
           let object = try? decoder.decode(T.self, from: data) {
            return object
        }
        return nil
    }

    func deleteFromUserDefaults(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
