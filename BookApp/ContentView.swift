//
//  ContentView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/3/23.
//

import SwiftUI
import UserNotifications

func scheduleNotification(title: String, subtitle: String, secondsLater: TimeInterval, isRepeating: Bool) {
    //Request Access
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if error != nil {
                print("Notification access not granted.", error?.localizedDescription ?? "error")
            }
    }
    
    // Define the content
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = .default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsLater, repeats: isRepeating)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)


}

struct ContentView: View {
    var body: some View {
        ZStack {
        Color("lightGray").ignoresSafeArea()
        TabView {
            AddListingView()
                .tabItem {
                    Label("Add Listing", systemImage: "plus")
                }
            MainView2()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

