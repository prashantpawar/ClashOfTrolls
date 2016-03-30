import "contracts/ClashOfTrolls.sol";
import "Test.sol";

contract ClashOfTrollsTest is Test {
    uint FUNDS = 1010134;

    function testDepositFunds() {
        ClashOfTrolls c = new ClashOfTrolls();
        c.depositFunds.gas(500).value(123414)();
        c.totalFunds().assertEqual(0, "Funds weren't accepted");
    }
}
