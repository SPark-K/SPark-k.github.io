pragma solidity ^0.4.25;

contract decentAR {
    address addr_owner;
    uint balance_vault;
    uint N_items;
    uint N_users;
    struct ItemInfo {
        address addr_sender;
        uint cat_id;    //category
        uint int_time;
        string str_location;    //GPS
        string str_QRcode;      //Aruco code
        string hash_image;
        uint item_value;
        uint view_count;
        bool isParent;
        uint[] idx_sub_item;
        uint N_sub_item;
        //ItemInfo[] sub_item;  //subsidary images
    }
    ItemInfo[] private itemList;
    
    // struct TabInfo {
    //     // Tab #0: Canvas, #1: Report, #2: AD
    //     uint id_tab;
    //     string str_title;
    // }
    // TabInfo[] private tabList;
    struct UserInfo {
    //    string str_name;
        ItemInfo[] items;
        uint reward;
    }
    //UserInfo[] private userList;
    
    mapping (address => UserInfo) userMap;
    
    constructor() public /*payable*/ {
        addr_owner = msg.sender;
        N_items = 0;
        N_users = 0;

        // tabList.push(TabInfo(0, "Canvas"));
        // tabList.push(TabInfo(1, "Report"));
        // tabList.push(TabInfo(2, "Advertisement"));
    }
    
    // function () public payable {
    //     balance_vault += msg.value;
    // }
    
    // function getReward(address giver) payable public {
    //     giver.transfer(0.001 ether);
    //     //giver.call.value(0.001 ether).gas(41254);
    //     balance_vault -= 0.001 ether;
    // }
    
    function getOwnder() public view returns (address) {
        return addr_owner;
    }
    
    function registerItem(uint _cat_id, string _location, string _qrcode, string _hash_image) public {
        N_items++;
        
        //uint memory tmp_subs;
        //ItemInfo tmp_item = ItemInfo(msg.sender, _time, _location, _hash_image);
        itemList.push(ItemInfo(msg.sender, _cat_id, block.timestamp, _location, _qrcode, _hash_image, 0, 0, true, new uint[](0), 1));
        //userMap[msg.sender].str_name = _name;
        //userMap[msg.sender].items.push(ItemInfo(msg.sender, _time, _location, _hash_image));
        userMap[msg.sender].items.push(ItemInfo(msg.sender, _cat_id, block.timestamp, _location, _qrcode, _hash_image, 0, 0, true, new uint[](0), 1));
        //getReward(msg.sender);
    }
    
    function addItem(uint id_item, string _location, string _hash_image) public {
 
        itemList.push(ItemInfo(msg.sender, itemList[id_item].cat_id, block.timestamp, _location, itemList[id_item].str_QRcode, _hash_image, 0, 0, false, new uint[](0), 0));
        itemList[id_item].idx_sub_item.push(itemList.length - 1);
        itemList[id_item].N_sub_item++;
        
        if(itemList[id_item].cat_id==0)
        {
            
        }else if(itemList[id_item].cat_id==1)
        {
            uint tmp_item_value = 0;
            uint adapt_value = 10;
            for(uint i=0; i<itemList[id_item].idx_sub_item.length;i++)
            {
                tmp_item_value += adapt_value;
                adapt_value = adapt_value - 2;
                if (adapt_value<1) adapt_value = 1;
            }
            
            itemList[id_item].item_value = tmp_item_value;
        }
    }
    
    function getN_items_ofMine() public constant returns(uint) {
        return userMap[msg.sender].items.length;
    }
    
    function getItem_ofMine(uint id_item) public constant returns(uint, string, string) {
        return (userMap[msg.sender].items[id_item].int_time, userMap[msg.sender].items[id_item].str_location, userMap[msg.sender].items[id_item].hash_image);    
    }
    
    function getTotalListLength() public constant returns(uint) {
        return itemList.length;
    }
    
    function getItem(uint id_item) public returns(uint, string, string, string, uint) {
        
        //require(itemList[id_item].isParent == true);
        
        itemList[id_item].view_count++;

        return (itemList[id_item].int_time, itemList[id_item].str_location, itemList[id_item].str_QRcode, itemList[id_item].hash_image, itemList[id_item].N_sub_item); 
    }
    
    function getsubItemLength(uint id_item) public constant returns(uint) {
        return itemList[id_item].idx_sub_item.length;
    }
    
    function getsubItem(uint id_item, uint sub_id) public returns(uint, string, string, string) {
        
        require(itemList[id_item].isParent == true);
        
        uint sub_item_idx = itemList[id_item].idx_sub_item[sub_id];
        itemList[sub_item_idx].view_count++;

        return (itemList[sub_item_idx].int_time, itemList[sub_item_idx].str_location, itemList[sub_item_idx].str_QRcode, itemList[sub_item_idx].hash_image); 
    }
    
}
