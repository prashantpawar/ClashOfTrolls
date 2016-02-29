import "dev.oraclize.it/api.sol";
import "std";

contract ClashOfTrolls is usingOraclize, mortal {
    //Place where we store the total funds available for reward
    uint public totalFunds;

    struct Troll {
        address addr; //We want to know who the troll is
        string troll_post_id; //The post on Reddit where the troll attempt was made
        string proof_comment_id; //The proof on Reddit where the troll attempt was made
        uint reward; //The reward given to the troll
    }

    mapping (string => Troll) trolls;
    mapping (bytes32 => string) post_cb_index;
    mapping (bytes32 => string) proof_cb_index;

    //This method is used by people to deposit funds for the reward
    function depositFunds() returns (bool result) {
        totalFunds += msg.value;
        result = true;
    }

    //This callback is used by Oraclize to inform us of the response from Reddit API.
    function __callback(bytes32 id, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        Troll memory t;
        //Figure out which callback is it
        //If post callback
        if (bytes(post_cb_index[id]).length == 0) { //Callback
            t = trolls[post_cb_index[id]];
            string memory verification_url = strConcat("json(http://www.reddit.com/api/info.json?id=t1_", t.troll_post_id, ").data.children.0.data.body");
            bytes32 proof_cb_id = oraclize_query("URL", verification_url);
            proof_cb_index[proof_cb_id] = t.troll_post_id;
        }
        //If proof callback 
        if (bytes(proof_cb_index[id]).length == 0) { //Callback
            t = trolls[proof_cb_index[id]];
            payReward(t);
        }
        //If verification callback then payout if verification is successful
    }

    function payReward(Troll t) internal {
        if (t.reward > 0) {
            t.reward = totalFunds/10;
            totalFunds = totalFunds - t.reward;
            t.addr.send(totalFunds/10);
        }
    }

    //The method trolls need to call in order to claim the reward.
    //We give 10% of the current pool as the reward. This ensures that for a long time people will be able to claim rewards
    function claimReward(string troll_post_id, string proof_comment_id) returns (bool result) {
        string memory post_url = strConcat("json(http://www.reddit.com/by_id/t3_", troll_post_id, ".json).data.children.0.data.score");
        bytes32 post_cb_id = oraclize_query("URL", post_url);
        post_cb_index[post_cb_id] = troll_post_id;
        trolls[troll_post_id] = Troll({
            addr: msg.sender,
            troll_post_id: troll_post_id,
            proof_comment_id: proof_comment_id,
            reward: 0
        });
        
        return true;
    }
}
