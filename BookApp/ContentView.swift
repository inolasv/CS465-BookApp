//
//  ContentView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/3/23.
//

import SwiftUI
import UserNotifications


struct ContentView: View {

    var body: some View {
        ZStack {
        Color("beige3").ignoresSafeArea()
            
        TabView {
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
            AddListingView()
                .tabItem {
                    Label("Add Listing", systemImage: "plus")
                }
        }
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
    
    // Define the content
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = .default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsLater, repeats: isRepeating)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)


}

struct SideModalView: View {
    var title: String
    var message: String
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
                .fill(Color.blue)
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
                    message: sideModal.message) {
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

