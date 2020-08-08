//  Created by Gagandeep Singh on 6/8/20.

import Combine
import CarsalesAPI

class ListViewModel: ObservableObject {
    @Published private(set) var cars: [CarsalesAPI.ListItem] = []
    @Published var selectedCar: String?
    private let api = CarsalesAPI()
    
    func fetchList() {
        api.getList { result in
            if case let .success(value) = result {
                self.cars = value.objects
            }
        }
    }
}
