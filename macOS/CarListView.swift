//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListView: View {
    @ObservedObject var provider = ListProvider()
    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 400, maximum: 600))]
    
    var body: some View {
        NavigationView {
            Group {
                if provider.cars.isEmpty {
                    List(provider.cars) { car in
                        CarListCellView(car: car)
                    }
                    .redacted(reason: .placeholder)
                } else {
                    List {Section(header: ListHeader()) {
                            ForEach(provider.cars) { car in
                                NavigationLink(destination: CarDetailsView(path: car.detailsURL)) {
                                    CarListCellView(car: car)
                                }
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 300)
            .listStyle(SidebarListStyle())
            .navigationTitle("Carsales.com.au")
            .padding(.top, 24)
            
            Text("Select a car to start").font(.title)
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

struct ListHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Carsales.com.au").font(.largeTitle).foregroundColor(.primary)
            Divider()
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
