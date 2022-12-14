//
//  ItemList.swift
//  ItunesApiCompletionHandler
//
//  Created by Peter Pan on 2022/12/1.
//

import SwiftUI

struct ItemList: View {
    @EnvironmentObject var fetcher: ItunesDataFetcher
    
    var body: some View {
        List {
            ForEach(fetcher.items) { item in
                ItemRow(item: item)
            }
        }
        .alert(isPresented: $fetcher.showError, content: {
            Alert(title: Text(fetcher.error?.localizedDescription ?? ""))
        })
        .onAppear {
            if fetcher.items.isEmpty {
                fetcher.fetchData(term: "張智霖")
            }
        }
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
            .environmentObject(ItunesDataFetcher())
    }
}
