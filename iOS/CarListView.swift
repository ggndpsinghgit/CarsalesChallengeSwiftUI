//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListView: View {
    @ObservedObject var provider = ListProvider()
    @State var isShowingDetails: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                CarsGridView(cars: provider.cars) { path in
                    provider.selectedCar = path
                    isShowingDetails = true
                }
                .navigationTitle("Carsales.com.au")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            /// Blur the background on iPad
            if isShowingDetails && UIDevice.current.userInterfaceIdiom == .pad {
                Blur(style: .systemUltraThinMaterial)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear(perform: provider.fetchList)
        .sheet(isPresented: $isShowingDetails) {
            CarDetailsView()
                .environmentObject(provider)
        }
    }
}

struct CarsGridView: View {
    let cars: [CarsalesAPI.ListItem]
    let tapHandler: (String) -> Void
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 400, maximum: 600))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                if cars.isEmpty {
                    ForEach(makeRedactedViews()) { car in
                        CarListCellView(car: car)
                    }
                    .redacted(reason: .placeholder)
                } else {
                    ForEach(cars) { car in
                        CarListCellView(car: car)
                        .onTapGesture {
                            tapHandler(car.detailsURL)
                        }
                    }
                }
            }
        }
    }
    
    private func makeRedactedViews() -> [CarsalesAPI.ListItem] {
        [.sample, .sample, .sample, .sample]
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
            .preferredColorScheme(.dark)
    }
}
