//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by user on 2024/1/14.
//

@propertyWrapper
struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        wrappedValue.formatted() + "\(suffix)"
    }
}
