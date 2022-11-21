// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title Shame Token
 * @author Darryl Banks
 * @notice This contract to be used by administrators to dole out Shame for 
 * policy infractions. Users may approve individual administrators to adjust 
 * their Shame balances on their behalf.
 * @dev Inherits openzeppelin AccessControl and Ownable contracts
 * to implement role-based access control mechanisms (ADMIN_ROLE)
*/
contract ShameToken is ERC20, AccessControl, Ownable {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    /// @dev administrator address is set in the constructor
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _mint(msg.sender, 1000);
    }

    /// @dev pure function returns zero
    function decimals() public override pure returns(uint8) {
        return 0;
    }

    /// @dev Administrators may send 1 token at a time to other addresses.
    /// If non-administrators try to transfer their shame coin, their balance
    /// will instead be increased by 1
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(amount == 1, "Send exactly one token");
        if (!hasRole(ADMIN_ROLE, msg.sender)) {
            _mint(msg.sender, 1);
            return false;
        }
        return super.transfer(to, amount);
    }

    /// @dev transferFrom override only reduces the balance of the holder
    function transferFrom(address from, address to, uint256 amount) public override onlyRole(ADMIN_ROLE) returns (bool) {
        /// There is already a _burn() function for reducing a balance.
        /// Changing the implementation of this function makes no sense.
        _burn(from, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _checkRole(ADMIN_ROLE, spender);
        require(amount == 1, "Allowance must be exactly one token");
        return super.approve(spender, amount);
    }

    function transferShame(address from, address to, uint256 amount) public onlyRole(ADMIN_ROLE) returns (bool) {
        return super.transferFrom(from, to, amount);
    }
}
