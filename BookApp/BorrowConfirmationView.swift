//
//  BorrowConfirmationView.swift
//  BookApp
//
//  Created by admin on 11/10/23.
//

import SwiftUI



struct BorrowConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var sideModal: SideModal? = nil

    
    @Binding var book: Book2
    let lender: Person
    //@Binding var showingBorrowSheet: Bool
    
    
    
    
    var body: some View {
        VStack {
            HStack() {
//                Button(action: {print("exit clicked")}) {
//                    Image("Exit").padding(.top, 10).padding(.horizontal, 10)
//                 dismiss()
//                }
            }
            AsyncImage(url: URL(string: book.coverImage ?? "book_cover")) { phase in
                switch phase {
                    case .empty:
                        ProgressView() // Shown while loading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image("book_cover") // Fallback image in case of failure
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        EmptyView()
                }
            }
            .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.height*0.3)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(.top, 30)

            
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image(lender.profilePicture ?? "ProfileIcon")
                    Text(lender.name + " " + lender.lastname).font(.custom("GochiHand-Regular", size: 24))
                }
                Text(lender.bio).font(.custom("GochiHand-Regular", size: 16))
            }.padding(.horizontal, 35).padding(.bottom, 5)
            Text("Interested in borrowing  \(book.title)? Click the borrow button and we will notify you if your request is approved by the lender. Once this happens, we will provide contact information to set up the lending process. If you wish to cancel, you may do so after clicking the borrow button.").padding().font(.custom("GochiHand-Regular", size: 16))
            ZStack(alignment: .center) {
                Button("Borrow") {
                    print("borrow pressed!")
                    
                    book.someoneInterested = true
                    
                    sideModal = SideModal(title: "Request Sent", message: "The request has been sent, we will let you know when it is approved.", color: "yellow")
                    scheduleNotification(title: "Someone wants to borrow!", subtitle: "Someone wants to borrow " + book.title, secondsLater: 5, isRepeating: false)
                    //showingBorrowSheet.toggle()
                    book.availability = false
                    book.borrowedByMe = true
                    dismiss()
                }
                .opacity(book.borrowedByMe ? 0 : 1)
                .buttonStyle(RoundedButton())
                Button("Cancel") {
                    //showingBorrowSheet.toggle()
                    book.availability = true
                    book.borrowedByMe = false
                    dismiss()
                }
                .opacity(book.borrowedByMe ? 1 : 0)
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

//struct BorrowConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        BorrowConfirmationView()
//    }
//}
