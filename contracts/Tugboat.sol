import "dev.oraclize.it/api.sol";
import "std";

contract interface is owned {
    address implementation;
    function interface(address addr) {
        implementation = addr;
    }
    
    function updateContract(address addr) onlyowner {
        implementation = addr;
    }
    
    modifier ifImplemented { 
        if(implementation == 0x0) {
            msg.sender.send(msg.value);
            return;
        }
        _ 
    }
}

contract Tugboat is usingOraclize, mortal, interface {
    function Tugboat() {
        interface(new ClashOfTrolls());
    }
    
    function depositFunds() ifImplemented returns (bool result) {
        if(msg.value == 0) {
            return false;
        }
        
        result = ClashOfTrolls(implementation).depositFunds.value(msg.value)();
        
        if(!result) {
            msg.sender.send(msg.value);
        }
        
        return result;
    }
    
    function claimReward(string troll_attempt, string proof) ifImplemented returns (bool result) {
        result = ClashOfTrolls(implementation).claimReward(troll_attempt, proof);
    }
}      
