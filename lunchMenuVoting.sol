pragma solidity ^0.4.0;

contract lunchMenuVoting {
    address addr_owner;
    uint N_voters;
    struct VoteItem {
        address addr_Voters;
        string str_Name;
        uint votedMenu;
    }
    VoteItem[] private voteList;
    struct MenuItem {
        uint id;
        string menu;
        uint N_voted;
    }
    MenuItem[] private menuList;
    
    function lunchMenuVoting() public {
        addr_owner = msg.sender;

        menuList.push(MenuItem(1, "짜장면", 0));
        menuList.push(MenuItem(2, "비빔밥", 0));
        menuList.push(MenuItem(3, "라면", 0));
    }
    
    function getOwnder() public view returns (address) {
        return addr_owner;
    }

    function registerVoting(string _name, uint _menu_id) public {
        N_voters++;
        voteList.push(VoteItem(msg.sender, _name, _menu_id));
        if(_menu_id >=1 && _menu_id <= menuList.length) {
            menuList[_menu_id-1].N_voted++;
        }
    }
    
    function getNVoters() public constant returns (uint) {
        return N_voters;
    }

    function getResults() public constant returns (string, uint) {
        uint max_count = 0;
        uint winner_id = 0;
        string memory winner_menu;
        
        for(uint i=0;i<menuList.length;i++){
            if(max_count < menuList[i].N_voted){
                max_count = menuList[i].N_voted;
                winner_id = menuList[i].id+1;
                winner_menu = menuList[i].menu;
            }
        }
        
        if(winner_id>0){
            return (winner_menu, max_count);
        }else{
            return ("no voting", 0);
        }
    }
    
    function resetVoting(string _str1, string _str2, string _str3) public {
        if(msg.sender == addr_owner){
            delete voteList;
            delete menuList;
            N_voters = 0;
            
            menuList.push(MenuItem(1, _str1, 0));
            menuList.push(MenuItem(2, _str2, 0));
            menuList.push(MenuItem(3, _str3, 0));
        }
    }
    
    function getMenus() public constant returns (string, string, string) {
        return (menuList[0].menu, menuList[1].menu, menuList[2].menu); 
    }
    
    function getCounts() public constant returns (uint, uint, uint) {
        return (menuList[0].N_voted, menuList[1].N_voted, menuList[2].N_voted); 
    }
}
