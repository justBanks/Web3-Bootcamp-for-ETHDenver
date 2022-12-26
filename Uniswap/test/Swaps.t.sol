// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Swaps.sol";

contract SwapsTest is Test {
    Swaps public swap;

    function setUp() public {
        swap = new Swaps("USDC");
    }

    function testAdminSetInConstructor() public {
        assertTrue(swap.swapExactInputSingle(40));
    }
}