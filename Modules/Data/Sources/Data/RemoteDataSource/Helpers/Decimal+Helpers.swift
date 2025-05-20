import Foundation

extension Decimal {
    static func fromPOSIX(_ string: String) -> Decimal? {
        Decimal(string: string, locale: Locale(identifier: "en_US_POSIX"))
    }
}
