import "contracts/ClashOfTrolls.sol";

contract ClashOfTrollsTest {
    uint FUNDS = 1010134;

    function testDepositFunds() {
        ClashOfTrolls c = new ClashOfTrolls();
        c.depositFunds.value(FUNDS)();
    }
}
