import "dev.oraclize.it/api.sol";
import "std";

contract Tugboat is usingOraclize, mortal {
    address cot;
    
    function Tugboat() {
        cot = new ClashOfTrolls();
    }
    
    function updateContract(address addr) {
        cot = addr;
    }
    
    function depositFunds() returns (bool result) {
        if(msg.value == 0) {
            return false;
        }
        
        if(cot == 0x0) {
            msg.sender.send(msg.value);
            return false;
        }
        
        result = ClashOfTrolls(cot).depositFunds.value(msg.value)();
        
        if(!result) {
            msg.sender.send(msg.value);
        }
        
        return result;
    }
    
    function claimReward(string troll_attempt, string proof) returns (bool result) {
        result = ClashOfTrolls(cot).claimReward(troll_attempt, proof);
    }
}      
