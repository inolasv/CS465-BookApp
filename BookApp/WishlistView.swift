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
            .font(.custom("Futura", size: 15))
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
    @Binding var booksFromJson: [Book2]
    @State private var showingBorrowSheet = false
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "title2", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "title3", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "title4", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
    
    @State private var currentBook: Book2 = Book2(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)
    
    @State private var user = Person.allPersons[1]
    
    @State private var users = Person.allPersons
    
    var body: some View {
        ZStack {
            VStack {
                Text("My Wishlist")
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(.black)
                    .frame(width: 400, height: 25, alignment: .center)
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Currently Borrowing")
                            .font(.custom("Futura", size: 26))
                            .foregroundColor(.black)
                    }
                    .frame(width: 360, height: 50, alignment: .leading)
                    GeometryReader { geometry in
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach(Book2.allBooks) { book in
                                    if book.borrowedByMe {
                                        VStack() {
                                            Button(action: {print("exit clicked")}) {
                                                Image("Exit")
                                                    .frame(width: 120, height: 1, alignment: .trailing)
                                            }
                                            Text(book.title)
                                                .font(.custom("Futura", size: 25))
                                                .frame(width: 120, height: 20, alignment: .leading)
                                            
                                            Text(book.author)
                                                .font(.custom("Futura", size: 16))
                                                .frame(width: 120, height: 10, alignment: .leading)
                                            
                                            // It is reading the book url in here, but we need to write a image url decoder into the image as XCode does not support displaying image from URL
                                            // Using place holder image for now
                                            AsyncImage(url: URL(string: book.coverImage)) { phase in
                                                switch phase {
                                                    case .empty:
                                                        ProgressView() // Shown while the image is loading
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    case .failure:
                                                        Image(systemName: "photo") // Fallback image or icon in case of failure
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    @unknown default:
                                                        EmptyView()
                                                }
                                            }
                                            .frame(width: 85, height: 130, alignment: .center)
                                            .clipped()
                                        }
                                        .frame(width: 150, height: 230, alignment: .center)
                                        .background(Color("cream"))
                                        .cornerRadius(25)
                                        .overlay(RoundedRectangle(cornerRadius: 25)
                                            .strokeBorder(Color.black, lineWidth: 3))
                                    }
                                }
                            }
                            .frame(width: geometry.size.width, height: 230, alignment: .center)
                        }
                    }
                }
                .frame(width: 460, height: 310)
                .background(Color("yellow"))
                .padding()
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Considering")
                            .font(.custom("Futura", size: 26))
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
                    .frame(width: 360, height: 50, alignment: .leading)
                    ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach(booksFromJson.indices, id: \.self) { i in
                                    if booksFromJson[i].wishlistedByMe {
                                        VStack() {
                                            Button(action: {print("exit clicked")}) {
                                                Image("Exit")
                                                    .frame(width: 120, height: 1, alignment: .trailing)
                                            }
                                            Text(booksFromJson[i].title)
                                                .font(.custom("Futura", size: 25))
                                                .frame(width: 120, height: 20, alignment: .leading)
                                            
                                            Text(booksFromJson[i].author)
                                                .font(.custom("Futura", size: 16))
                                                .frame(width: 120, height: 10, alignment: .leading)
                                            
                                            // Place holder image for now
                                            AsyncImage(url: URL(string: booksFromJson[i].coverImage)) { phase in
                                                switch phase {
                                                    case .empty:
                                                        ProgressView() // Shown while the image is loading
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    case .failure:
                                                        Image(systemName: "photo") // Fallback image or icon in case of failure
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    @unknown default:
                                                        EmptyView()
                                                }
                                            }
                                            .frame(width: 85, height: 110, alignment: .center)
                                            .clipped()
                                            Button(booksFromJson[i].availability ? "Available!" : "Unavailable") {
                                                if booksFromJson[i].availability {
                                                    currentBook = booksFromJson[i]
                                                    showingBorrowSheet.toggle()
                                                }
                                            }
                                            .buttonStyle(RoundedButton())
                                            // You might need to modify this part to work with Book2
                                             .sheet(isPresented: $showingBorrowSheet) {
                                                     BorrowConfirmationView(book: $currentBook, lender: users[Int.random(in: 0..<19)], showingBorrowSheet: $showingBorrowSheet)
                                                 
                                             }
                                        }
                                        .frame(width: 150, height: 230, alignment: .center)
                                        .background(Color("cream"))
                                        .cornerRadius(25)
                                        .overlay(RoundedRectangle(cornerRadius: 25)
                                            .strokeBorder(Color.black, lineWidth: 3))
                                    }
                                }
                            }
                            .frame(width: 460, height: 230, alignment: .center)
                        }
                }
                .frame(width: 460, height: 300)
                .background(Color("yellow"))
            }
        }
    }
} 

//struct WishlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishlistView()
//    }
//}
//struct WishlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a constant binding to an array of 'Book2' which contains the example book
//        let exampleBooks = [Book2(title: "Sample Book", coverImage: "SampleCover", author: "Sample Author", tags: ["Fiction", "Adventure"], description: "This is a sample book description.", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
//        
//        WishlistView(booksFromJson: .constant(exampleBooks))
//    }
//}

