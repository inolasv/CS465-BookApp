//
//  AcceptConfirmationView.swift
//  BookApp
//
//  Created by admin on 11/10/23.
//

import SwiftUI

struct AcceptConfirmationView: View {
    
    @Binding var booksFromJson: [Book2]
    let bookTitle: String
    @Binding var borrower: Person
    @Binding var showingBorrowSheet: Bool
    
    @State private var i: Int = 0

    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: booksFromJson[i].coverImage)) { phase in
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
                    AsyncImage(url: URL(string: borrower.profilePicture)) { phase in
                        switch phase {
                            case .empty:
                                ProgressView() // Shown while loading
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image("ProfileIcon") // Fallback image in case of failure
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            @unknown default:
                                EmptyView()
                        }
                    }
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("magenta"), lineWidth: 3))
//                    .padding()                    Text(borrower.name + " " + borrower.lastname).font(.custom("GochiHand-Regular", size: 24))
                }
                Text(borrower.bio).font(.custom("GochiHand-Regular", size: 16))
            }.padding(.horizontal, 35).padding(.bottom, 5)
            Text("This user is interested in borrowing  \(booksFromJson[i].title). Once you accept, you can send over your contact information to set up the lending process. If you wish to decline, you may do so by clicking that button").padding().font(.custom("GochiHand-Regular", size: 16))
            HStack(alignment: .center) {
                Button("Accept") {
                    booksFromJson[i].borrowedByMe = true
                    booksFromJson[i].wishlistedByMe = false
                    booksFromJson[i].availability = false
                    booksFromJson[i].someoneInterested = false
                    print("accept pressed!")
                    scheduleNotification(title: "Your Borrow Request has been Approved!", subtitle: "you can now view contact information for the book you want to borrow", secondsLater: 5, isRepeating: false)
                    showingBorrowSheet = false
//                    print(book)

                }
                .buttonStyle(RoundedButton())
                Button("Decline") {
                    print("decline pressed!")
                    booksFromJson[i].someoneInterested = false
                    scheduleNotification(title: "Your Borrow Request has been Declined", subtitle: "", secondsLater: 5, isRepeating: false)
                    showingBorrowSheet = false
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
        .onAppear() {
            if let index = booksFromJson.firstIndex(where: { $0.title == bookTitle }) {
                i = index
            }
        }
    }
}

//struct AcceptConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AcceptConfirmationView(book: Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false), borrower: User(name: "name1", lastname: "lname1", bio: "this is a bio1.", favoriteGenre: "genre1"))
//    }
//}
