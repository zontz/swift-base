
import Foundation

struct FeatureFlag: Codable {
    var featureFlagName: String
    var featureFlagDescription: String
    var isFeatureFlagEnabled: Bool
}

var isFeatureFlagMenuEnabled: Bool = {
    #if DEBUG
    return true
    #else
    return false
    #endif
}()
 
