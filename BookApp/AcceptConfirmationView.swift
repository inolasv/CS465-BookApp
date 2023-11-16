//
//  AcceptConfirmationView.swift
//  BookApp
//
//  Created by admin on 11/10/23.
//

import SwiftUI

struct AcceptConfirmationView: View {
    var book: Book
    var borrower: User
    
    var body: some View {
        VStack{
            Image(book.coverImage ?? "bookCover")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.height*0.3)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 30)
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image(borrower.profilePicture ?? "ProfileIcon")
                    Text("Name").font(.custom("GochiHand-Regular", size: 24))
                }
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ").font(.custom("GochiHand-Regular", size: 16))
            }.padding(.horizontal, 35).padding(.bottom, 5)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt...").padding().font(.custom("GochiHand-Regular", size: 16))
            HStack(alignment: .center) {
                NavigationLink(destination: ProfileView()) {
                    Button("Accept") {
                        print("accept pressed!")
                        scheduleNotification(title: "Your Borrow Reqeust has been Approved!", subtitle: "you can now view contact information for the book you want to borrow", secondsLater: 5, isRepeating: false)
                    }
                }
                .buttonStyle(RoundedButton())
                Button("Decline") {
                    print("decline pressed!")
                    scheduleNotification(title: "Your Borrow Reqeust has been Declined", subtitle: "", secondsLater: 5, isRepeating: false)
                        }
                        .buttonStyle(RoundedButton())
            }.padding()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .background(Color("lightGray"))
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: 25)
            .strokeBorder(Color.black, lineWidth: 3))
        .padding()
    }
}

//struct AcceptConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AcceptConfirmationView()
//    }
//}
