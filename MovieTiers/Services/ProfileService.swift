//
//  ProfileService.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 06.08.2023.
//

import Foundation

//MARK: ProfileModel
struct ProfileModel: Codable {
    var inventory = [Item]()
    var tierListArray = [TierList]()
}
//MARK: Subscriber Protocol - ProfileServiceSubscriber
protocol ProfileServiceSubscriber: AnyObject {
    func refresh(model: ProfileModel)
}

final class ProfileService {
    //MARK: Parameters
    public static let shared = ProfileService()
    private var subscribers = [ProfileServiceSubscriber]()
    private var model = ProfileModel()
    
    //MARK: Init
    private init(){
        model = FileService.shared.readModel()
    }
    //Subscribe a object
    func subscribe(subscriber: ProfileServiceSubscriber){
        subscribers.append(subscriber)
        subscriber.refresh(model: model)
    }
    //Add Item to the inventory
    func addItemToInventory(item: Item){
        model.inventory.append(item)
        refreshAll()
    }
    //Add tier list to an inventory
    func addTierList(tierList: TierList){
        model.tierListArray.append(tierList)
        refreshAll()
    }
    //Add Item To Tier List
    func addItemToTierList(item: Item, tierListIndex: Int, tierIndex: Int){
        model.tierListArray[tierListIndex].tierList[tierIndex].items.append(item)
        refreshAll()
    }
    // Remove Item From Inventory
    func removeItemFromInventory(index: Int){
        model.inventory.remove(at: index)
        refreshAll()
    }
    // Inventory Getter
    func getModelInventory() -> [Item] {
        return model.inventory
    }
    //TierList Getter
    func getTierList(index: Int) -> TierList {
        return model.tierListArray[index]
    }
    //Delete a tier list
    func deleteTierList(index: Int){
        model.tierListArray.remove(at: index)
        refreshAll()
    }
    //Delete an item from a tier list
    func deleteTierItem(tierListIndex: Int, tierIndex: Int, deleteIndex: Int){
        model.tierListArray[tierListIndex].tierList[tierIndex].items.remove(at: deleteIndex)
        refreshAll()
    }
    //Refresh the subscribers
    func refreshAll(){
        FileService.shared.writeModel(model: model)
        subscribers.map{
            $0.refresh(model: model)
        }
    }
}
