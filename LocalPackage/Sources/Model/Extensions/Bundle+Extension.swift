import Foundation

extension Bundle {
    private func bundleString(key: String) -> String {
        guard let string = object(forInfoDictionaryKey: key) as? String else {
            fatalError("\(key) is not found.")
        }
        return string
    }

    var bundleName: String { bundleString(key: "CFBundleName") }
    var bundleVersion: String { bundleString(key: "CFBundleVersion") }
}
