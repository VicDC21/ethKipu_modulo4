// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity >=0.8.2 <0.9.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleDEX is Ownable(msg.sender) {
    ERC20 public tokenA;
    ERC20 public tokenB;

    event LiquidityAdded(uint256 amountA, uint256 amountB);
    event LiquidityRemoved(uint256 amountA, uint256 amountB);
    event TokenSwapped(address indexed trader, uint256 amountIn, uint256 amountOut);

    constructor(address _tokenA, address _tokenB) {
        tokenA = ERC20(_tokenA);
        tokenB = ERC20(_tokenB);
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(amountA > 0 && amountB > 0, "Amounts must be greater than 0");
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);
        emit LiquidityAdded(amountA, amountB);
    }

    function removeLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(amountA <= tokenA.balanceOf(address(this)) && amountB <= tokenB.balanceOf(address(this)), "Not enough liquidity");
        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);
        emit LiquidityRemoved(amountA, amountB);
    }

    function getPrice(address _token) external view returns (uint256) {
        require(_token == address(tokenA) || _token == address(tokenB), "Invalid token address");
        
        return _token == address(tokenA)
            ? (tokenB.balanceOf(address(this)) * 1e18) / tokenA.balanceOf(address(this))
            : (tokenA.balanceOf(address(this)) * 1e18) / tokenB.balanceOf(address(this));
    }

    function swapAforB(uint256 amountAIn) external {
        require(amountAIn > 0, "Amount must be > 0");
        uint256 amountBOut = getAmountOut(amountAIn, tokenA.balanceOf(address(this)), tokenB.balanceOf(address(this)));
        tokenA.transferFrom(msg.sender, address(this), amountAIn);
        tokenB.transfer(msg.sender, amountBOut);
        emit TokenSwapped(msg.sender, amountAIn, amountBOut);
    }

    function swapBforA(uint256 amountBIn) external {
        require(amountBIn > 0, "Amount must be > 0");
        uint256 amountAOut = getAmountOut(amountBIn, tokenB.balanceOf(address(this)), tokenA.balanceOf(address(this)));
        tokenB.transferFrom(msg.sender, address(this), amountBIn);
        tokenA.transfer(msg.sender, amountAOut);
        emit TokenSwapped(msg.sender, amountBIn, amountAOut);
    }

    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) private pure returns (uint256) {
        return (amountIn * reserveOut) / (reserveIn + amountIn);
    }
}