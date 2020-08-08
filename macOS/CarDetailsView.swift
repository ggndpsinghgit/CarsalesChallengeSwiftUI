//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarDetailsView: View {
    @ObservedObject var provider = DetailsProvider()
    let path: String
    
    var body: some View {
        Group {
            ScrollView {
                if let car = provider.car {
                    CarDetailsInnerView(car: car)
                } else {
                    CarDetailsInnerView(car: .sample)
                        .transition(.scale)
                        .redacted(reason: .placeholder)
                }
            }
            .onAppear {
                provider.fetchDetails(path: path)
            }
            .alert(isPresented: $provider.showFailedAlert) {
                Alert(title: Text("Error!"), message: Text("Failed to load the car details."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct CarDetailsInnerView: View {
    let car: CarsalesAPI.CarDetails
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                PhotoCarousel(photos: car.photos)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(car.title)
                            .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                        
                        Text(car.priceString)
                            .font(Font.system(size: 24, weight: .medium, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "mappin.circle")
                            Text(car.locationString)
                        }
                        .font(Font.system(size: 20, weight: .medium, design: .rounded))
                        
                        HStack {
                            Image(systemName: "car")
                            Text(car.saleStatus.rawValue)
                        }
                        .font(Font.system(size: 20, weight: .medium, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Section(header:
                            Text("Comments:")
                                    .font(Font.system(size: 16, weight: .semibold, design: .rounded))
                        ) {
                            Text(car.comments)
                                .font(Font.system(size: 18, weight: .regular, design: .rounded))
                        }
                    }
                }
                .padding(24)
            }
        }
    }
}

struct PhotoCarousel: View {
    let photos: [String]
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 240, maximum: 360))]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(photos, id: \.self) { path in
                    AsyncImageView(path: path)
                        .aspectRatio(1.5, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding()
        }
        .frame(height: 300)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(path: "")
    }
}
