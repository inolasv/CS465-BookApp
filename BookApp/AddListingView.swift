//
//  AddListingView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI


struct AddListingView: View {
    
    @State private var bookTitle: String = ""
    @State private var bookAuthor: String = ""
    @State private var bookTag: String = ""
    @State private var tags: [String] = []
    @State private var borrowLength: String = ""
    @State private var condition: String = ""
    @State private var giveOrBorrow: String = ""

    @State private var bookId: String = ""
    
    @State private var showingPreviewSheet = false
    @State private var sideModal: SideModal? = nil


    
    func copyJSONIfNeeded() {
        let fileManager = FileManager.default
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("books.json") else {
            fatalError("Cannot find documents directory")
        }
        
        if !fileManager.fileExists(atPath: url.path) {
            guard let bundleURL = Bundle.main.url(forResource: "books", withExtension: "json", subdirectory: "Data") else {
                fatalError("JSON file not found in bundle")
            }
            
            do {
                try fileManager.copyItem(at: bundleURL, to: url)
            } catch {
                fatalError("Failed to copy JSON file: \(error)")
            }
        }
    }

    init () {
        copyJSONIfNeeded()
//        UISegmentedControl.appearance().selectedSegmentTintColor = Color.pink
//        UISegmentedControl.appearance().backgroundColor = .purple

        //This will change the font size
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .custom("GochiHand-Regular", size: 12))], for: .highlighted)
//
//        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .custom("GochiHand-Regular", size: 12))), for: .normal)

    }

    var body: some View {

        VStack{
            
            Text("Add a Listing")            .font(.custom("GochiHand-Regular", size: 30))
                .padding()
            
            
            Group {

            Text("Title:")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
            
            TextField( "Book Title",
                       text: $bookTitle)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                .font(.custom("GochiHand-Regular", size: 20))
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.leading, 40)
                .padding(.trailing, 40)
            
            }
            Group {

            Text("Author:")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
                .padding(.top, 30)
            
            TextField( "Book Author",
                       text: $bookAuthor)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                .font(.custom("GochiHand-Regular", size: 20))
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.leading, 40)
                .padding(.trailing, 40)
            }
            Group {

            
            Text("Tags:")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
                .padding(.top, 30)
            
            TextField( "Book Author",
                       text: $bookTag)
                .onSubmit {
                    tags.append(bookTag)
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                .font(.custom("GochiHand-Regular", size: 20))
            
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
                                .font(.custom("GochiHand-Regular", size: 13))
                                .foregroundColor(.black)
                                .frame(width: 80, height: 25, alignment: .center)
                                .background(Color("Beige4"))
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
            .background(Color("Beige3"))
            .frame(height: 50, alignment: .center)
                
            }
            
            Group {

            Text("Borrow Length:")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
                .padding(.top, 30)
                
                
            Picker(selection: $borrowLength, label: Text("Pick One")) {
                ForEach(["1 week", "2 weeks", "3 weeks", "4 weeks"], id: \.self) {
                                Text($0)
                            }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.top, 10)
                
            }
            
            Group {

            Text("Condition of Book:")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
                .padding(.top, 30)
                
                Picker(selection: $condition, label: Text("Pick One")) {
                    ForEach(["excellent", "decent", "good", "poor"], id: \.self) {
                                    Text($0)
                                }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.top, 10)
                
            }
            
            Group {

            Text("Type of Listing")            .font(.custom("GochiHand-Regular", size: 25))
                .frame(width: 300, height: 0, alignment: .leading)
                .padding(.top, 30)
                
            Picker(selection: $giveOrBorrow, label: Text("Pick One")) {
                ForEach(["Giving Away", "Lending"], id: \.self) {
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
                    showingPreviewSheet.toggle()

                }
                .onTapGesture {
                }
                .buttonStyle(RoundedButton())
                .sheet(isPresented: $showingPreviewSheet) {
                    BookIconView(isFlipped: false, book: Book(title: bookTitle, coverImage: "cover", author: bookAuthor, tags: tags, description: "description", availability: true, borrowedByMe: false, lendedByMe: true))
                }
                
                Button("Submit"){
                    var books = loadBooks()
                    if let index = books.firstIndex(where: { $0.title == bookTitle }) {
                        books[index].lendedByMe = true
                        saveBooks(books)
                        print("Book lending status updated")
                    } else {
                        sideModal = SideModal(title: "Error", message: "The book that you are trying to submit does not exist in our databases. Please try again.")
                    }
                }
                .buttonStyle(RoundedButton())
            }
            .padding(.top, 25)
            .padding(.bottom, 25)
            
            
        }.frame(maxWidth: 370, alignment: .center)
                .background(Color("lightGray"))
                .cornerRadius(25)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(Color.black, lineWidth: 3))
                .modalView(sideModal: $sideModal)

       
        
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

struct AddListingView_Previews: PreviewProvider {
    static var previews: some View {
        AddListingView()
    }
}
