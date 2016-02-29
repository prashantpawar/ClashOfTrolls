import "contracts/ClashOfTrolls.sol";
import "Test.sol";

contract ClashOfTrollsTest is Test {
    uint FUNDS = 1010134;

    function testDepositFunds() {
        ClashOfTrolls c = new ClashOfTrolls();
        ClashOfTrolls(c).depositFunds.value(12320)();
        ClashOfTrolls(c).totalFunds().assertEqual(0, "Funds weren't accepted");
    }
}
