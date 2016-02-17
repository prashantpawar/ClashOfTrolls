import "dev.oraclize.it/api.sol";

contract ClashOfTrolls is usingOraclize {
    uint totalFunds;
    struct Troll {
        address addr;
        string post_id;
        uint reward;
    }

    mapping (uint => Troll) trolls;
    uint numTrolls;

    function depositFunds() {
        totalFunds += msg.value;
    }

    function claimReward(string post_id) returns (bool accepted) {
        uint trollID = numTrolls++;
        trolls[trollID] = Troll({
            addr: msg.sender,
            post_id: post_id,
            reward: totalFunds/10
        });
        totalFunds = totalFunds - trolls[trollID].reward;
        trolls[trollID].addr.send(trolls[trollID].reward);
        return true;
    }
}
