//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListView: View {
    @ObservedObject var provider = ListProvider()
    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 400, maximum: 600))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    if provider.cars.isEmpty {
                        ForEach(makeRedactedViews()) { car in
                            CarListCellView(car: car)
                        }.redacted(reason: .placeholder)
                    } else {
                        ForEach(provider.cars) { car in
                            NavigationLink(destination: CarDetailsView(path: car.detailsURL)) {
                                CarListCellView(car: car)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Carsales.com.au")
        }
        .onAppear {
            provider.fetchList()
        }
    }
}

extension CarListView {
    private func makeRedactedViews() -> [CarsalesAPI.ListItem] {
        [.sample, .sample, .sample, .sample]
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
