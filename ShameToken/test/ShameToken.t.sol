// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/ShameToken.sol";

contract ShameTokenTest is Test {
    ShameToken public token;
    // address(this) = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;

    function setUp() public {
        token = new ShameToken("ShameToken", "DOH");
    }

    function testAdminSetInConstructor() public {
        // administrator address is set in the constructor
        assertTrue(token.hasRole(keccak256("ADMIN_ROLE"), address(this)));
    }

    function testZeroDecimalsForToken() public  {
        assertEq(token.decimals(), 0);
    }
    
    function testAdminCanSendOneToken() public {
        token.transfer(address(2), 1);
        vm.expectRevert(bytes("Send exactly one token"));
        token.transfer(address(2), 2);
    }
    
    function testShameTransferAsNonAdmin() public {
        uint startingBalance = token.balanceOf(address(3));
        vm.prank(address(3));
        token.transfer(address(4), 1);
        assertEq(token.balanceOf(address(3)), startingBalance + 1);
    }
    
    function testNonAdminCanApproveAdminToSpendOne() public {
        // Non-administrators can approve the administrator (and only the administrator) to spend one token on their behalf 
        token.transfer(address(2), 1);
        vm.startPrank(address(2));
        assertTrue(token.approve(token.owner(), 1));
        //vm.expectRevert(bytes("Allowance must be exactly one token"));
        //token.approve(token.owner(), 2); //amount must equal 1
        vm.expectRevert();
        token.approve(address(3), 1); //can't approve non-admin
        vm.stopPrank();
        assertTrue(token.transferShame(address(2), address(3), 1));
    }
    
    function test_transferFrom() public {
        uint startingBalance = token.balanceOf(address(this));
        token.transferFrom(address(this), address(2), 1);
        assertEq(token.balanceOf(address(this)), startingBalance - 1);
    }
    
    // Document the contract with Natspec, and produce docs from this
}
