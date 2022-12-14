//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Justin Wells on 12/13/22.
//

import SwiftUI

enum SortType {
    case none, alphabetical, country
}

struct ContentView: View {
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var sort: SortType = .none
    @State private var isShowingSort = false
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts.sorted(by: sortFilteredResorts)) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSort = true
                    } label: {
                        Text("Sort")
                    }
                }
            }
            .confirmationDialog("Sort", isPresented: $isShowingSort) {
                Button("None") { sort = .none }
                Button("Alphabetically") { sort = .alphabetical }
                Button("Country") { sort = .country }
            } message: {
                Text("Select a way to sort the results.")
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyStackNavigationView()
        // Require iPhones to always use stack navigation. Extension DisableSlideOver-iPhone.swift houses the tweak.
    }
    
    func sortFilteredResorts(this: Resort, that: Resort) -> Bool {
        switch sort {
        case .none:
            return false
        case .alphabetical:
            return this.name < that.name
        case .country:
            return this.country < that.country
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
