//
//  ContentView.swift
//  NavigationStackTutorial
//
//  Created by Yasser Hajlaoui on 12/22/24.
//

import SwiftUI

struct CarBrand: Identifiable,Hashable {
    let name: String
    let id = NSUUID().uuidString
}

struct Car: Identifiable,Hashable {
    let id = NSUUID().uuidString
    let make: String
    let model: String
    let year: Int
    
    var description: String {
        return "\(make) \(model) \(year)"
    }
}

struct ContentView: View {
    let brands: [CarBrand] = [
        .init(name: "Ferrari"),
        .init(name: "Lamborghini"),
        .init(name: "Mercedes"),
        .init(name: "Aston Martin"),
    ]
    
    let cars: [Car] = [
        .init(make: "Ferrari", model: "F8 Tributo", year: 2020),
        .init(make: "Ferrari", model: "SF90 Stradale", year: 2020),
        .init(make: "Lamborghini", model: "Aventador", year: 2020),
        .init(make: "Lamborghini", model: "Huracan", year: 2020),
        .init(make: "Mercedes", model: "AMG GT", year: 2020),
        .init(make: "Mercedes", model: "SLS AMG", year: 2020),
        .init(make: "Aston Martin", model: "DB11", year: 2020),
        .init(make: "Aston Martin", model: "Vantage", year: 2020),
    ]
    
    @State private var navigationPath = [CarBrand]()
    @State private var showFullStack = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturers") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand) {
                                Text(brand.name)
                            }
                        }
                    }
                    Section("Cars") {
                        ForEach(cars) { car in
                            NavigationLink(value: car) {
                                Text(car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { brand in
                    VStack {
                        viewForBrand(brand)
                        
                        Button{
                            navigationPath = []
                        } label: {
                            Text("Go to root")
                        }
                        
                    }
                }
                .navigationDestination(for: Car.self) { car in
                    Color(.systemRed)
            }
                
                Button {
                    showFullStack.toggle()
                    
                    if showFullStack {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2], brands[1]]
                    }
                   
                } label: {
                    Text("View all")
                }
                
                
                
            }
        }
    }
    
    func viewForBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
            case "Ferrari":
                return AnyView(Color(.systemRed))
            case "Lamborghini":
                return AnyView(Color(.systemYellow))
            case "Mercedes":
                return AnyView(Color(.systemGray))
            case "Aston Martin":
                return AnyView(Color(.systemGreen))
                
            default:
                return AnyView(Color(.systemBlue))
        }
    }
}

#Preview {
    ContentView()
}
