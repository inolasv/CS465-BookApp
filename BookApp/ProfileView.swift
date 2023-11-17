//
//  ProfileView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

//struct BorrowView: View {
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        BorrowConfirmationView()
//    }
//}

struct RoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Futura", size: 15))
            .foregroundColor(.white)
            .frame(width: 100, height: 30)
            .background(Color("magenta"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1))
    }
}


struct ProfileView: View {
    
    @State private var showingBorrowSheet = false
    
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title2", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title3", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title4", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
    
    @State private var user = User(name: "Name1", lastname: "Lname1", bio: "This is a bio1.", favoriteGenre: "genre1")
    
    @State private var users = [User(name: "Name2", lastname: "Lname2", bio: "This is a bio2.", favoriteGenre: "genre2"),
         User(name: "Name3", lastname: "Lname3", bio: "This is a bio3.", favoriteGenre: "genre3"),
         User(name: "Name4", lastname: "Lname4", bio: "This is a bio4.", favoriteGenre: "genre4"),
         User(name: "Name4", lastname: "Lname4", bio: "This is a bio4.", favoriteGenre: "genre4"),
         User(name: "Name5", lastname: "Lname5", bio: "This is a bio5.", favoriteGenre: "genre5"),
         User(name: "Name6", lastname: "Lname6", bio: "This is a bio6.", favoriteGenre: "genre6")]

    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
        VStack {
                            
            VStack {
                Image(user.profilePicture ?? "alt_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 180, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("magenta"), lineWidth: 10))
                    .padding()
            
                Text(user.name + " " + user.lastname)
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(.black)
                Text(user.bio)
                    .font(.custom("Futura", size: 18))
                    .frame(width: 310, height: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .padding(.vertical)

            }
            VStack {
//                LazyHStack(alignment: .center, spacing: 130) {
//                    Text("Listings")
//                        .font(.custom("Futura", size: 26))
//                        .foregroundColor(.black)
//                }
//                .frame(width: 340, height: 50, alignment: .leading)
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(Book2.allBooks) { book in
                            if book.lendedByMe {
                                VStack() {
                                    Button(action: {print("delete book")}) {
                                        Image("Exit")
                                            .frame(width: 120, height: 1, alignment: .trailing)
                                    }
                                    Text(book.title)
                                        .font(.custom("GochiHand-Regular", size: 25))
                                        .frame(width: 120, height: 20, alignment: .leading)

                                    Text(book.author)
                                        .font(.custom("GochiHand-Regular", size: 16))
                                        .frame(width: 120, height: 10, alignment: .leading)

                                    Image("book_cover") // Placeholder image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 85, height: 110, alignment: .center)
                                        .clipped()
                                    Button(book.availability ? "Available" : "Borrowed") {
                                        showingBorrowSheet.toggle()
                                    }
                                    .buttonStyle(RoundedButton())
                                    // Adjust the sheet logic as needed for Book2
                                    .sheet(isPresented: $showingBorrowSheet) {
                                        // You need to modify AcceptConfirmationView to use Book2
                                        // AcceptConfirmationView(book: book, borrower: users[Int.random(in: 0..<4)], showingBorrowSheet: $showingBorrowSheet)
                                    }

                                }
                                .frame(width: 150, height: 240, alignment: .center)
                                .background(Color("cream"))
                                .cornerRadius(25)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.black, lineWidth: 3))
                            }
                        }
                    }
                }
                .frame(width: .infinity, height: 230, alignment: .center)

            }
            .frame(width: 460, height: 300)
            .background(Color("yellow"))
        }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
