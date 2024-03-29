import SwiftUI
import SwiftData
import UIKit

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}

struct FoodItem: Identifiable {
    let id = UUID() // Unique identifier for each food item
    let name: String
    let portionSize: String
    // Add other properties as needed
}

struct SecondView: View {
    @Binding var isShowing: Bool // Add this line to hold the state

    var body: some View {
        VStack {
            Button("Back") {
                self.isShowing = false // Modify the state to dismiss the view
            }
            .frame(alignment: .topLeading)
            Spacer()
            Text("Full Screen Second View")
            Spacer()
        }
    }

    // Add this initializer
    init(isShowing: Binding<Bool>) {
        self._isShowing = isShowing
    }
}

struct LoginView: View {
    @State private var netID: String = ""
    @State private var password: String = ""

    var body: some View {
            VStack {
                Spacer()

                // Net ID input
                TextField("Net ID", text: $netID)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)

                // Password input
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                // Login button
                Button("Log In") {
                    // Handle the login action
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(5.0)
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()
            }
        }
    }


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the button
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        // Add the button to the view
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        print("button pressed")
    }
}

struct TheAtriumView: View {
    // Assuming you have a way to get the wait time, perhaps from a ViewModel
    @ObservedObject var viewModel: DiningHallViewModel

    var body: some View {
        VStack {
            Text("Welcome to The Atrium")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Display wait time here
            Text("Wait Time: \(viewModel.atriumWaitTime) mins")
                .font(.title2)
                .padding()
            
            // The rest of your view code
        }
    }
}
struct CafeWestView: View {
    @ObservedObject var viewModel: DiningHallViewModel

    var body: some View {
        VStack {
            Text("Welcome to Cafe West")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Display wait time here
            Text("Wait Time: \(viewModel.cafeWestWaitTime) mins")
                .font(.title2)
                .padding()

            // The rest of your view code
        }
    }
}


class DiningHallViewModel: ObservableObject {
    @Published var atriumWaitTime: Int = 0 // Default value, should be updated with actual wait time
    @Published var cafeWestWaitTime: Int = 0 // Default value, should be updated with actual wait time\
    @StateObject var viewModel = DiningHallViewModel()

    // Add methods to fetch or calculate wait times
    func fetchWaitTimes() {
        // Fetch or calculate wait time for The Atrium
        // self.atriumWaitTime = ...

        // Fetch or calculate wait time for Cafe West
        // self.cafeWestWaitTime = ...
    }
}

struct NextPageView: View {
    @StateObject var viewModel = DiningHallViewModel()
    var body: some View {
        VStack { // Ensure there's a VStack here to stack the title and the HStack vertically
            Text("Dining Halls")
                .font(.largeTitle) // Makes the font large
                .fontWeight(.bold) // Makes the font bold
                .padding(.bottom, 20) // Adds some space below the title

            HStack {
                // "The Atrium" button leading to its own page
                NavigationLink(destination: TheAtriumView(viewModel: viewModel)) {
                        Text("The Atrium")
                        .foregroundColor(.white)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 13)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding(.leading) // Adds padding to avoid touching the left border

                Spacer() // Separates the two buttons

                // "Cafe West" button leading to its own page
                NavigationLink(destination: CafeWestView(viewModel: viewModel)) {
                        Text("Cafe West")
                        .foregroundColor(.white)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 13)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding(.trailing) // Adds padding to avoid touching the right border
            }
            .padding(.top, 20) // Adjusts the padding to move the HStack down a bit

            Spacer() // Pushes the HStack to the top of the VStack
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isShowingSecondView = false
    @State private var isShowingWaitTimes = false
    @State private var isShowingNextPage = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("LOGO") // Your logo here
                Text("Rutgers Dining Halls")
                    .font(.title)
                    .fontWeight(.bold)
                
                NavigationLink(destination: NextPageView()) {
                                    Image(systemName: "arrow.right.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                }
                Spacer()
                
            }
        }
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        }
    }

    //private func addItem() {
    // withAnimation {
    // let newItem = Item(timestamp: Date())
    //modelContext.insert(newItem)
    //}
    //}
    
    //private func deleteItems(offsets: IndexSet) {
    //withAnimation {
    //  for index in offsets {
    //       modelContext.delete(items[index])
    //}
    //}
    //}
