import "dev.oraclize.it/api.sol";
import "std";
import "helper.sol";
import "ClashOfTrolls.sol";

contract Tugboat is usingOraclize, mortal, interface, refundable {
    function Tugboat() {
        interface(new ClashOfTrolls());
    }
    
    function depositFunds() ifImplemented returns (bool result) {
        if(msg.value == 0) {
            return false;
        }
        
        result = ClashOfTrolls(implementation).depositFunds.value(msg.value)();
        
        if(!result) {
            refund();
        }
        
        return result;
    }
    
    function claimReward(string troll_attempt, string proof) ifImplemented returns (bool result) {
        result = ClashOfTrolls(implementation).claimReward(troll_attempt, proof);
    }
}
