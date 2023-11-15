//
//  BorrowConfirmationView.swift
//  BookApp
//
//  Created by admin on 11/10/23.
//

import SwiftUI



struct BorrowConfirmationView: View {
    @State var borrowingMode = false
    @State private var sideModal: SideModal? = nil


    
    var body: some View {
        VStack {
            HStack() {
//                Button(action: {print("exit clicked")}) {
//                    Image("Exit").padding(.top, 10).padding(.horizontal, 10)
//                 dismiss()
//                }
            }
            Image("book_cover")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.height*0.3)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 30)
            
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image("ProfileIcon")
                    Text("Name").font(.custom("GochiHand-Regular", size: 24))
                }
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ").font(.custom("GochiHand-Regular", size: 16))
            }.padding(.horizontal, 35).padding(.bottom, 5)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt...").padding().font(.custom("GochiHand-Regular", size: 16))
            ZStack(alignment: .center) {
                Button("Borrow") {
                    print("borrow pressed!")
                    sideModal = SideModal(title: "Request Sent", message: "The request has been sent, we will let you know when it is approved.")
                    scheduleNotification(title: "Someone wants to borrow!", subtitle: "user1 wants to borrow book1", secondsLater: 10, isRepeating: false)
                    self.borrowingMode = true
                        }
                        .opacity(borrowingMode ? 0 : 1)
                        .buttonStyle(RoundedButton())
                Button("Cancel") {
                            self.borrowingMode = false
                        }

                .opacity(borrowingMode ? 1 : 0)
                        .buttonStyle(RoundedButton())
            }.padding()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .background(Color("lightGray"))
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: 25)
            .strokeBorder(Color.black, lineWidth: 3))
        .padding()
        .modalView(sideModal: $sideModal)

    }
}

struct BorrowConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowConfirmationView()
    }
}
