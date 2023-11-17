//
//  WishlistView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI
import Foundation

//import BookApp

struct WhiteRoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("GochiHand-Regular", size: 15))
            .foregroundColor(.black)
            .frame(width: 100, height: 30)
            .background(Color(UIColor.white))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1))
    }
}

struct WishlistView: View {
    
    @State private var showingBorrowSheet = false
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title2", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title3", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title4", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false)]
    
    @State private var books2: [Book2] = Book2.allBooks
    
    @State private var user = User(name: "name3", lastname: "lname3", bio: "this is a bio3.", favoriteGenre: "genre1")
    
    @State private var users = [User(name: "name2", lastname: "lname2", bio: "this is a bio2.", favoriteGenre: "genre2"),
         User(name: "name1", lastname: "lname1", bio: "this is a bio1.", favoriteGenre: "genre1"),
         User(name: "name4", lastname: "lname4", bio: "this is a bio4.", favoriteGenre: "genre4"),
         User(name: "name4", lastname: "lname4", bio: "this is a bio4.", favoriteGenre: "genre4"),
         User(name: "name5", lastname: "lname5", bio: "this is a bio5.", favoriteGenre: "genre5"),
         User(name: "name6", lastname: "lname6", bio: "this is a bio6.", favoriteGenre: "genre6")]
    
    var body: some View {
        ZStack {
            VStack {
                Text("My Wishlist")
                    .font(.custom("GochiHand-Regular", size: 30))
                    .foregroundColor(.black)
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Current Borrowing")
                            .font(.custom("GochiHand-Regular", size: 26))
                            .foregroundColor(.black)
                    }
                    .frame(width: 330, height: 40, alignment: .leading)
                    GeometryReader { geometry in
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach(Book2.allBooks) { book in
                                    VStack() {
                                        Button(action: {print("exit clicked")}) {
                                            Image("Exit")
                                                .frame(width: 120, height: 1, alignment: .trailing)
                                        }
                                        Text(book.title)
                                            .font(.custom("GochiHand-Regular", size: 25))
                                            .frame(width: 120, height: 20, alignment: .leading)
                                        
                                        Text(book.author)
                                            .font(.custom("GochiHand-Regular", size: 16))
                                            .frame(width: 120, height: 10, alignment: .leading)
                                        
                                        // It is reading the book url in here, but we need to write a image url decoder into the image as XCode does not support displaying image from URL
                                        // Using place holder image for now
                                        Image("book_cover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 85, height: 110, alignment: .center)
                                            .clipped()
                                    }
                                    .frame(width: 150, height: 230, alignment: .center)
                                    .background(Color("lightGray"))
                                    .cornerRadius(25)
                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(Color.black, lineWidth: 3))
                                }
                            }
                            .frame(width: geometry.size.width, height: 230, alignment: .center)
                        }
                    }
                }
                .frame(width: 460, height: 310)
                .background(Color("Beige3"))
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Considering")
                            .font(.custom("GochiHand-Regular", size: 26))
                            .foregroundColor(.black)
//                        Button("Add Books")
//                        {
//                            showingBorrowSheet.toggle()
//                        }
//                        .buttonStyle(WhiteRoundedButton())
//                        .sheet(isPresented: $showingBorrowSheet) {
//                            BorrowView()
//                        }
                    }
                    .frame(width: 330, height: 40, alignment: .leading)
                    ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach(books2.indices, id: \.self) { i in
                                    VStack() {
                                        Button(action: {print("exit clicked")}) {
                                            Image("Exit")
                                                .frame(width: 120, height: 1, alignment: .trailing)
                                        }
                                        Text(books2[i].title)
                                            .font(.custom("GochiHand-Regular", size: 25))
                                            .frame(width: 120, height: 20, alignment: .leading)
                                        
                                        Text(books2[i].author)
                                            .font(.custom("GochiHand-Regular", size: 16))
                                            .frame(width: 120, height: 10, alignment: .leading)
                                        
                                        // Place holder image for now
                                        Image("book_cover") // Placeholder image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 85, height: 110, alignment: .center)
                                            .clipped()
                                        Button(books2[i].availability ? "Available!" : "Unavailable") {
                                            showingBorrowSheet.toggle()
                                        }
                                        .buttonStyle(RoundedButton())
                                        // You might need to modify this part to work with Book2
                                         .sheet(isPresented: $showingBorrowSheet) {
                                             BorrowConfirmationView(book: $books2[i], lender: users[Int.random(in: 0..<5)], showingBorrowSheet: $showingBorrowSheet)
                                         }
                                    }
                                    .frame(width: 150, height: 230, alignment: .center)
                                    .background(Color("lightGray"))
                                    .cornerRadius(25)
                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(Color.black, lineWidth: 3))
                                }
                            }
                            .frame(width: .infinity, height: 230, alignment: .center)
                        }
                }
                .frame(width: 460, height: 330)
                .background(Color("Beige3"))
            }
        }
    }
    
    init() {
        self.books2 = Book2.allBooks
//        print("book2allbooks: \(Book2.allBooks)")
        print("books2: \(books2)")
    
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
