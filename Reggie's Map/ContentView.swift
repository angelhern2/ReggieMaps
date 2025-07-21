import SwiftUI

extension Color {
    static let PrimaryColor = Color("PrimaryColor")
    static let SecondaryColor = Color("SecondaryColor")
}

struct ContentView: View {

    @State private var selection: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            switch selection {
            case 0: AnyView(HomeView())
            case 1: AnyView(MapView())
            case 2: AnyView(DinningView())
            case 3: AnyView(ExploreView())
            case 4: AnyView(SettingsView())
            default: AnyView(HomeView())
            }
            
            // Bottom Tab Bar
            HStack {
                Spacer()
                Button {
                    selection = 1
                } label: {
                    Image(systemName: "map.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selection == 1 ? .PrimaryColor : .gray)
                        .padding(.top, 10)
                }
                Spacer()
                Button {
                    selection = 2
                } label: {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selection == 2 ? .PrimaryColor : .gray)
                        .padding(.top, 10)
                }
                Spacer()
                Button {
                    selection = 0
                } label: {
                    Image("ISU_we_teach_logo.png")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .padding(.top, 7)
                        .opacity(selection == 0 ? 1 : 0.6)
                }
                Spacer()
                Button {
                    selection = 3
                } label: {
                    Image(systemName: "newspaper.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selection == 3 ? .PrimaryColor : .gray)
                        .padding(.top, 10)
                }
                Spacer()
                Button {
                    selection = 4
                } label: {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selection == 4 ? .PrimaryColor : .gray)
                        .padding(.top, 10)
                }
                Spacer()
            }
            .overlay(
                Rectangle()
                    .foregroundColor(.PrimaryColor)
                    .frame(height: 1),
                alignment: .top
            )
            .frame(height: 60)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
