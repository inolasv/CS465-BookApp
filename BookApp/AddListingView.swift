//
//  AddListingView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

struct AddListingInformation: View {
    
    var bookTitle: String
    @Binding var booksFromJson: [Book2]
    @Binding var currentUser: Person

    
    @State private var bookTag: String = ""
    @State private var tags: [String] = []
    @State private var borrowLength: String = ""
    @State private var condition: String = ""
    @State private var giveOrBorrow: String = ""
    
    @State private var showingPreviewSheet = false
    @State private var sideModal: SideModal? = nil
    
    @State private var selectedPreview: Book2 = Book2(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false, someoneInterested: false)
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            Group {


            Text("Tags:")
                .font(.custom("Futura", size: 22))
                .frame(width: 290, height: 0, alignment: .leading)
                .padding(.top, 20)

            TextField( "Add tags here",
                       text: $bookTag)
                .onSubmit {
                    tags.append(bookTag)
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                .font(.custom("Futura", size: 20))

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.leading, 40)
                .padding(.trailing, 40)



            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        VStack() {
                            Text(tag)
                                .font(.custom("Futura", size: 13))
                                .foregroundColor(.black)
                                .frame(width: 80, height: 25, alignment: .center)
                                .background(Color("yellow"))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.black, lineWidth: 1))
                        }
                    }
                }
            }
            .padding(.top, 12)
            .padding(.leading, 40)
            .background(Color("cream"))
            .frame(height: 40, alignment: .center)

            }

            Group {

            Text("Borrow Length:")            .font(.custom("Futura", size: 22))
                .frame(width: 290, height: 0, alignment: .leading)
                .padding(.top, 20)


            Picker(selection: $borrowLength, label: Text("Pick One")) {
                ForEach(["1w", "2w", "3w", "4w"], id: \.self) {
                                Text($0)
                            }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.top, 10)

            }

            Group {

            Text("Condition:")            .font(.custom("Futura", size: 22))
                .frame(width: 290, height: 0, alignment: .leading)
                .padding(.top, 20)

                Picker(selection: $condition, label: Text("Pick One")) {
                    ForEach(["Unused", "Decent", "Worn"], id: \.self) {
                                    Text($0)
                                }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)

            }

            Group {

            Text("Listing type:")
                .font(.custom("Futura", size: 22))
                .frame(width: 290, height: 0, alignment: .leading)
                .padding(.top, 20)

            Picker(selection: $giveOrBorrow, label: Text("Pick One")) {
                ForEach(["Lending", "Giving away"], id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.top, 10)

            }
            
            HStack(alignment: .center, spacing: 30) {
                Button("Preview"){
                    if let index = booksFromJson.firstIndex(where: { $0.title == bookTitle }) {
                        selectedPreview = booksFromJson[index]
                        showingPreviewSheet.toggle()
                    }
                    else {
                        sideModal = SideModal(title: "Internal Error", message: "We're sorry, please try again.", color: "magenta")
                    }
                }
                .onTapGesture {
                }
                .buttonStyle(RoundedButton())
                .sheet(isPresented: $showingPreviewSheet) {
                    BookIconView(isFlipped: false, book: $selectedPreview)
                }

                Button("Submit") {
                    if let index = booksFromJson.firstIndex(where: { $0.title == bookTitle }) {
                        currentUser.bookListings.append(bookTitle)
                        booksFromJson[index].lendedByMe = true
                        sideModal = SideModal(title: "Listing Added", message: "Congrats! You have added \(booksFromJson[index].title) to your listings", color: "yellow")
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                                    withAnimation {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                    }
                }
                .buttonStyle(RoundedButton())
            }
            .padding(.top, 25)
            .padding(.bottom, 20)
            
            
        }
        .frame(maxWidth: 370, maxHeight: 670, alignment: .center)
                .background(Color("cream"))
                .cornerRadius(25)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(Color.black, lineWidth: 3))
                .modalView(sideModal: $sideModal)
    }
    
}


struct AddListingView: View {
    
    @Binding var booksFromJson: [Book2]
    @Binding var currentUser: Person


    
    @State private var bookTitle: String = ""
    @State private var bookAuthor: String = ""

    @State private var bookId: String = ""
    @State private var sideModal: SideModal? = nil

    
    @State private var suggestedBooks: [Book2] = []
    
    
    @State private var showingInfoSheet = false
    @State private var selectedBook: Book2 = Book2(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false, someoneInterested: false)



    
//    func copyJSONIfNeeded() {
//        let fileManager = FileManager.default
//        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("books.json") else {
//            fatalError("Cannot find documents directory")
//        }
//
//        if !fileManager.fileExists(atPath: url.path) {
//            guard let bundleURL = Bundle.main.url(forResource: "books", withExtension: "json", subdirectory: "Data") else {
//                fatalError("JSON file not found in bundle")
//            }
//
//            do {
//                try fileManager.copyItem(at: bundleURL, to: url)
//            } catch {
//                fatalError("Failed to copy JSON file: \(error)")
//            }
//        }
//    }
//    init () {
//        copyJSONIfNeeded()
//
//        UISegmentedControl.appearance().selectedSegmentTintColor = Color.pink
//        UISegmentedControl.appearance().backgroundColor = .purple
//
//        //This will change the font size
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .custom("Futura", size: 12))], for: .highlighted)
//
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .custom("Futura", size: 12))), for: .normal)
//
//    }

    var body: some View {

        VStack{
            Text("Add a Listing").font(.custom("Futura", size: 30))
                .padding()
            
            
            Group {

            Text("Title:").font(.custom("Futura", size: 22))
                .frame(width: 290, height: 0, alignment: .leading)
            
            TextField( "Book Title",
                       text: $bookTitle)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                .font(.custom("Futura", size: 20))
                .onChange(of: bookTitle) { newValue in
                    suggestedBooks = filterBooks(bookTitle: bookTitle)
                    print(suggestedBooks)
                }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                
            Group {

                Text("Author:")            .font(.custom("Futura", size: 22))
                    .frame(width: 290, height: 0, alignment: .leading)
                    .padding(.top, 20)
                
                TextField( "Book Author",
                           text: $bookAuthor)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top, 10)
                    .font(.custom("Futura", size: 20))
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                }
                
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(suggestedBooks, id: \.self) { book in
                        VStack {
                            Text(book.title)
                                .font(.custom("Futura", size: 13))
                                .foregroundColor(.black)
                                .padding(.leading, 7)
                                .padding(.trailing, 7)
                            Text(book.author)
                                .font(.custom("Futura", size: 10))
                                .foregroundColor(.black)
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
                            .frame(width: 68, height: 88, alignment: .center)
                            .clipped()
                    }
                        .frame(width: .infinity, height: 140, alignment: .center)
                        .background(Color("yellow"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                            .stroke(.black, lineWidth: 1))
                        .onTapGesture {
                            bookTitle = book.title
                            bookAuthor = book.author
                        }
                    }
                }
            }
            .padding(.top, 12)
            .padding(.leading, 40)
            .background(Color("cream"))
            .frame(height: 180, alignment: .center)
            }
            
                Button("Continue"){
                    if let index = booksFromJson.firstIndex(where: { $0.title == bookTitle }) {
                        selectedBook = booksFromJson[index]
                        showingInfoSheet.toggle()
                        bookTitle = ""
                        bookAuthor = ""
                    } else {
                        sideModal = SideModal(title: "Error", message: "The book that you are trying to submit does not exist in our databases. Please try again.", color: "magenta")
                    }
                }
                .buttonStyle(RoundedButton())
                .sheet(isPresented: $showingInfoSheet) {
                    AddListingInformation(bookTitle: selectedBook.title, booksFromJson: $booksFromJson, currentUser: $currentUser)
                }
            
            
        }.frame(maxWidth: 370, maxHeight: 670, alignment: .center)
                .background(Color("cream"))
                .cornerRadius(25)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(Color.black, lineWidth: 3))
                .modalView(sideModal: $sideModal)

       
        
    }
    
    func filterBooks(bookTitle: String) -> [Book2] {
        return booksFromJson.filter { ($0.title).contains(bookTitle) }
    }
    
    
    func loadBooks() -> [Book] {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Documents directory not found")
        }
        let fileURL = documentsDirectory.appendingPathComponent("books.json")

        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Book].self, from: data)
        } catch {
            fatalError("Error decoding JSON: \(error)")
        }
    }

    
    func saveBooks(_ books: [Book]) {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Documents directory not found")
        }
        let fileURL = documentsDirectory.appendingPathComponent("books.json")

        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: fileURL, options: [.atomicWrite])
        } catch {
            fatalError("Error encoding JSON: \(error)")
        }
    }

}

//struct AddListingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListingView()
//    }
//}
//struct AddListingView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a constant binding to an array of 'Book2' which contains the example book
//        let exampleBooks = [Book2(title: "Sample Book", coverImage: "SampleCover", author: "Sample Author", tags: ["Fiction", "Adventure"], description: "This is a sample book description.", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
//        
//        AddListingView(booksFromJson: .constant(exampleBooks))
//    }
//}
