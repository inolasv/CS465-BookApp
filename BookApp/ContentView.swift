//
//  ContentView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AddListingView()
                .tabItem {
                    Label("Add Listing", systemImage: "plus")
                }
            MainView()
                .tabItem {
                    Label("Home", systemImage: "book")
                }
            WishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "checklist")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

