pragma solidity ^0.4.0;

contract decentAR {
    address addr_owner;
    uint N_items;
    uint N_users;
    struct ItemInfo {
        address addr_sender;
        string str_time;
        string str_location;
        string hash_image;
    }
    ItemInfo[] private itemList;
    struct TabInfo {
        // Tab #0: Canvas, #1: Report, #2: Signage
        uint id_tab;
        string str_title;
    }
    TabInfo[] private tabList;
    struct UserInfo {
        string str_name;
        ItemInfo[] items;
        uint reward;
    }
    //UserInfo[] private userList;
    
    mapping (address => UserInfo) userMap;
    
    constructor() public {
        addr_owner = msg.sender;
        N_items = 0;
        N_users = 0;
        
        tabList.push(TabInfo(0, "Canvas"));
        tabList.push(TabInfo(1, "Report"));
        tabList.push(TabInfo(2, "Signage"));
    }
    
    function getOwnder() public view returns (address) {
        return addr_owner;
    }

    function registerItem(uint _id_tab, string _name, string _time, string _location, string _hash_image) public {
        N_items++;
        //ItemInfo tmp_item = ItemInfo(msg.sender, _time, _location, _hash_image);
        itemList.push(ItemInfo(msg.sender, _time, _location, _hash_image));
        userMap[msg.sender].str_name = _name;
        userMap[msg.sender].items.push(ItemInfo(msg.sender, _time, _location, _hash_image));
    }
    
    function getN_items_ofMine() public constant returns(uint) {
        return userMap[msg.sender].items.length;
    }
    
    function getItem_ofMine(uint id_item) public constant returns(string, string, string) {
        return (userMap[msg.sender].items[id_item].str_time, userMap[msg.sender].items[id_item].str_location, userMap[msg.sender].items[id_item].hash_image);    
    }
    
    function getTotalListLength() public constant returns(uint) {
        return itemList.length;
    }
    
    function getItem(uint id_item) public constant returns(string, string, string) {
        return (itemList[id_item].str_time, itemList[id_item].str_location, itemList[id_item].hash_image);    
    }
    
}
