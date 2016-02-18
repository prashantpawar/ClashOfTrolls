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

    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        if (trolls[myid].reward > 0) {
            trolls[myid].reward = totalFunds/10;
            totalFunds = totalFunds - trolls[myid].reward;
            trolls[myid].addr.send(totalFunds/10);
        }
    }
    

    function claimReward(string post_id) returns (bool accepted) {
        bytes32 trollID = oraclize_query("URL", "json(http://www.reddit.com/by_id/t3_469rig.json).data.children[0].data.score");
        trolls[trollID] = Troll({
            addr: msg.sender,
            post_id: post_id,
            reward: 0
        });
        accepted = true;
    }
}
