// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';

contract Swaps {
    ISwapRouter public immutable swapRouter;
    string private tokenOut;
    address public constant DAI = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant USDT = 0x00000000219ab540356cbb839cbe05303d7705fa;
    uint24 public constant poolFee = 3000;
    
    constructor(ISwapRouter _swapRouter, string memory _tokenOut) {
        swapRouter = _swapRouter;
        tokenOut = _tokenOut;
    }

    /// @notice swapExactInputSingle swaps a fixed amount of DAI for a maximum possible amount of USDC
    /// using the DAI/USDC 0.3% pool by calling `exactInputSingle` in the swap router.
    /// @dev The calling address must approve this contract to spend at least `amountIn` worth of its DAI for this function to succeed.
    /// @param amountIn The exact amount of DAI that will be swapped for USDC.
    /// @return amountOut The amount of USDC received.
    function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut) {
        // Transfer the specified amount of DAI to this contract.
        TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountIn);
        // msg.sender approves the router to spend DAI.
        TransferHelper.safeApprove(DAI, address(swapRouter), amountIn);

        // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
        // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: DAI,
                tokenOut: tokenOut,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }



}