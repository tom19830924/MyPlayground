//
//  ContentView.swift
//  FoodPicker
//
//  Created by user on 2024/1/8.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    
    let food = Food.examples
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                foodImage
                
                Text("今天吃什麼？")
                    .bold()
                
                selectedFoodInfoView

                Spacer().layoutPriority(1)
                
                selectFoodButton
                
                cancelButton
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .animation(.mySprint, value: shouldShowInfo)
            .animation(.myEase, value: selectedFood)
        }
        .background(Color.bg2)
    }
}

// MARK: - Subviews
private extension ContentView {
    var foodImage: some View {
        Group {
            if let selectedFood {
                Text(selectedFood.image)
                    .lineLimit(1)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    
            }
            else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(height: 250)
        .border(.red)
    }
    
    var footNameView: some View {
        HStack {
            Text(selectedFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.green)
                .id(selectedFood!.name)
                .transition(.delayInsertionOpacity)
            
            Button {
                shouldShowInfo.toggle()
            } label: {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }
    
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白質")
                        Text("脂肪")
                        Text("碳水")
                    }
                    .frame(minWidth: 60)
                    
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    
                    GridRow {
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .roundedRectBacground()
                .transition(.moveUpWithOpacity)
            }
        }
        .frame(maxWidth: .infinity)
        .border(.green)
        .clipped()
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if let selectedFood {
            footNameView
            
            Text("熱量 \(selectedFood.$calorie)")
                .font(.title2)
                  
            foodDetailView
        }
    }
    
    var selectFoodButton: some View {
        Button {
            selectedFood = food.shuffled().first { $0 != selectedFood }
        } label: {
            Text(selectedFood == .none ? "告訴我！" : "換一個").frame(width: 200)
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
        }
        .padding(.bottom, -15)
    }
    
    var cancelButton: some View {
        Button {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200)
        }
        .buttonStyle(.bordered)
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

#Preview {
    ContentView(selectedFood: .examples.first!)
}
