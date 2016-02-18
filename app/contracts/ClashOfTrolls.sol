import "dev.oraclize.it/api.sol";

contract ClashOfTrolls is usingOraclize {
    //Place where we store the total funds available for reward
    uint totalFunds;
    
    struct Troll {
        address addr;
        string post_id;
        uint reward;
    }

    mapping (bytes32 => Troll) trolls;

    //This method is used by people to deposit funds for the reward
    function depositFunds() {
        totalFunds += msg.value;
    }

    function __callback(bytes32 id, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        if (trolls[id].reward > 0) {
            trolls[id].reward = totalFunds/10;
            totalFunds = totalFunds - trolls[id].reward;
            trolls[id].addr.send(totalFunds/10);
        }
    }
    
    function claimReward(string post_id) returns (string url) {
        url = strConcat("json(http://www.reddit.com/by_id/t3_", post_id, ".json).data.children.0.data.score");
        bytes32 trollID = oraclize_query("URL", url);
        trolls[trollID] = Troll({
            addr: msg.sender,
            post_id: post_id,
            reward: 0
        });
    }
}   
