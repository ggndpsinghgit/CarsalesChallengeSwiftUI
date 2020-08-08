//  Created by Gagandeep Singh on 6/8/20.

import Combine
import CarsalesAPI

class ListProvider: ObservableObject {
    @Published private(set) var cars: [CarsalesAPI.ListItem] = []
    let api = CarsalesAPI()
    
    func fetchList() {
        api.getList { result in
            // Convert to set to remove duplicates
            if case let .success(value) = result {
                self.cars = value.objects
            }
        }
    }
}
