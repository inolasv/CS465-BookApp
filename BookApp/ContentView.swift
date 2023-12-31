//
//  ContentView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/3/23.
//

import SwiftUI
import UserNotifications

struct DefaultsKeys {
    static let lenderView = "lenderView"
}


struct ContentView: View {
    @State private var booksFromJson = Book2.allBooks
    @State private var sideModal: SideModal? = nil
    
    @State private var currentUser = Person.allPersons[0]
    
    let defaults = UserDefaults.standard
    @State private var toggleOn: Bool = false

    
    var body: some View {
        ZStack {
        Color("Beige2").ignoresSafeArea()
        Toggle("", isOn: $toggleOn)
            .onChange(of: toggleOn) { value in
                if (toggleOn) {
                    defaults.set(
                        true,
                        forKey: DefaultsKeys.lenderView
                    )
                } else {
                    defaults.set(
                        false,
                        forKey: DefaultsKeys.lenderView
                    )
                }
            }

        TabView {
            MainView2(booksFromJson: $booksFromJson)
                .tabItem {
                    Label("Home", systemImage: "book")
                }
            WishlistView(booksFromJson: $booksFromJson)
                .tabItem {
                    Label("My List", systemImage: "checklist")
                }
            ProfileView(user: $currentUser, booksFromJson: $booksFromJson, editable: true)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            AddListingView(booksFromJson: $booksFromJson, currentUser: $currentUser)
                .tabItem {
                    Label("Add Listing", systemImage: "plus")
                }
        }
        .modalView(sideModal: $sideModal)

        }
        .onAppear {
            sideModal = SideModal(title: "How to use the App", message: "Swipe left and right on the cards to see the next options. Swiping right adds to your wishlist, and left indicates not interested. A green dot means the book is currently available", color: "beige4")
        }
    }
}


func scheduleNotification(title: String, subtitle: String, secondsLater: TimeInterval, isRepeating: Bool) {
    //Request Access
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if error != nil {
                print("Notification access not granted.", error?.localizedDescription ?? "error")
            }
    }
    
    print("sending notifff.....")
    
    // Define the content
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = .default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsLater, repeats: isRepeating)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)

    print("notif sent!")

}

struct SideModalView: View {
    var title: String
    var message: String
    var color: String
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                        
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color(color))
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
        .zIndex(99)

    }
}


struct SideModal: Equatable {
    var title: String
    var message: String
    var color: String
    var duration: Double = 7
}

extension View {
    func modalView(sideModal: Binding<SideModal?>) -> some View {
        self.modifier(SideModalModifier(sideModal: sideModal))
    }
}

struct SideModalModifier: ViewModifier {
    @Binding var sideModal: SideModal?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -10)
                }.animation(.spring(), value: sideModal)
            )
            .onChange(of: sideModal) { value in
                showModal()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let sideModal = sideModal {
            VStack {
                SideModalView(
                    title: sideModal.title,
                    message: sideModal.message, color: sideModal.color) {
                        dismissModal()
                    }
                Spacer()
            }
            .transition(.move(edge: .top))
        }
    }
    
    private func showModal() {
        guard let sideModal = sideModal else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if sideModal.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissModal()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + sideModal.duration, execute: task)
        }
    }
    
    private func dismissModal() {
        withAnimation {
            sideModal = nil
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

