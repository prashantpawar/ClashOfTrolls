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


contract refundable {
    function refund(uint value) {
        msg.sender.send(value);
    }
    
    function refund() {
        msg.sender.send(msg.value);
    }
}
