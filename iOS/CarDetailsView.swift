//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarDetailsView: View {
    let path: String
    @ObservedObject var provider = DetailsProvider()
    
    var body: some View {
        ScrollView {
            if let car = provider.car {
                CarDetailsInnerView(car: car)
            } else {
                CarDetailsInnerView(car: .sample)
                    .redacted(reason: .placeholder)
            }
        }
        .navigationTitle(provider.car?.title ?? "")
        .onAppear {
            provider.fetchDetails(path: path)
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


struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(path: "v3/9ea9359e-c29d-4493-ad02-69662dcb5586")
    }
}

struct PhotoCarousel: View {
    let photos: [String]
    
    var body: some View {
        TabView {
            ForEach(photos, id: \.self) { path in
                SyncImageView(path: path)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(10)
            }
        }
        .aspectRatio(1.5, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle())
    }
}
