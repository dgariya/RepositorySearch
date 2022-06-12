import Foundation
import Dispatch

class Debounce {
    private init() {}
    static func input(_ input: String,
                      _ debounceInterval : TimeInterval,
                      comparedAgainst current: @escaping @autoclosure () -> (String),
                      perform: @escaping (String) -> ()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval) {
                if input == current() { perform(input) }
            }
        }
}

