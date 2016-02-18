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

    function getTotalFundsSize() returns (uint fundSize) {
        fundSize = totalFunds;
    }

    function getRewardSize() returns (uint rewardSize) {
        rewardSize = totalFunds/10;
    }

    function __callback(bytes32 id, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        if (trolls[id].reward > 0) {
            trolls[id].reward = totalFunds/10;
            totalFunds = totalFunds - trolls[id].reward;
            trolls[id].addr.send(totalFunds/10);
        }
    }
    

    function claimReward(string post_id) returns (bytes32 trollID) {
        trollID = oraclize_query("URL", "json(http://www.reddit.com/by_id/t3_469rig.json).data.children.0.data.score");
        trolls[trollID] = Troll({
            addr: msg.sender,
            post_id: post_id,
            reward: 0
        });
    }
}
