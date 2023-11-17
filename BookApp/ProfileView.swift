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
            .font(.custom("GochiHand-Regular", size: 15))
            .foregroundColor(.black)
            .frame(width: 100, height: 30)
            .background(Color("Beige1"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1))
    }
}


struct ProfileView: View {
    
    @State private var showingBorrowSheet = false
    
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false),
         Book(title: "title2", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false),
         Book(title: "title3", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title4", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false)]

    
    @State private var user = User(name: "name1", lastname: "lname1", bio: "this is a bio1.", favoriteGenre: "genre1")
    
    @State private var users = [User(name: "name2", lastname: "lname2", bio: "this is a bio2.", favoriteGenre: "genre2"),
         User(name: "name3", lastname: "lname3", bio: "this is a bio3.", favoriteGenre: "genre3"),
         User(name: "name4", lastname: "lname4", bio: "this is a bio4.", favoriteGenre: "genre4"),
         User(name: "name4", lastname: "lname4", bio: "this is a bio4.", favoriteGenre: "genre4"),
         User(name: "name5", lastname: "lname5", bio: "this is a bio5.", favoriteGenre: "genre5"),
         User(name: "name6", lastname: "lname6", bio: "this is a bio6.", favoriteGenre: "genre6")]

    
    
    var body: some View {
        ZStack {
        Color("lightGray").ignoresSafeArea()
        VStack {
                            
            VStack {
                Image(user.profilePicture ?? "ProfileIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 196, height: 196, alignment: .center)
                    .clipShape(Circle())
                Text(user.name + " " + user.lastname)
                    .font(.custom("GochiHand-Regular", size: 30))
                    .foregroundColor(.black)
                Text(user.bio)
                    .font(.custom("GochiHand-Regular", size: 17))
                    .frame(width: 300, height: .infinity, alignment: .leading)
                    .foregroundColor(.black)
            }
            VStack {
                LazyHStack(alignment: .center, spacing: 130) {
                    Text("Listings")
                        .font(.custom("GochiHand-Regular", size: 26))
                        .foregroundColor(.black)
                }
                .frame(width: 330, height: 40, alignment: .leading)
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(Book2.allBooks) { book in
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
                            .frame(width: 150, height: 230, alignment: .center)
                            .background(Color("Beige2"))
                            .cornerRadius(25)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.black, lineWidth: 3))
                        }
                    }
                }
                .frame(width: .infinity, height: 230, alignment: .center)

            }
            .frame(width: 460, height: 330)
            .background(Color("Beige3"))
        }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
