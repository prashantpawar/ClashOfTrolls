import "dev.oraclize.it/api.sol";

contract ClashOfTrolls is usingOraclize {
    //Place where we store the total funds available for reward
    uint totalFunds;
    
    struct Troll {
        address addr; //We want to know who the troll is
        string post_id; //The post on Reddit where the troll attempt was made
        uint reward; //The reward given to the troll
    }

    mapping (bytes32 => Troll) trolls;

    //This method is used by people to deposit funds for the reward
    function depositFunds() {
        totalFunds += msg.value;
    }

    //This callback is used by Oraclize to inform us of the response from Reddit API.
    function __callback(bytes32 id, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        if (trolls[id].reward > 0) {
            trolls[id].reward = totalFunds/10;
            totalFunds = totalFunds - trolls[id].reward;
            trolls[id].addr.send(totalFunds/10);
        }
    }
    
    //The method trolls need to call in order to claim the reward.
    //We give 10% of the current pool as the reward. This ensures that for a long time people will be able to claim rewards
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
