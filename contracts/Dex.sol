pragma solidity 0.8.9;
pragma abicoder v2;

import "../Contracts/Wallet.sol";

contract Dex is Wallet{

    enum Side{
        BUY,
        SELL
    }

    struct Order{
        uint id;
        address trader;
        Side side;
        bytes32 ticker;
        uint amount;
        uint price;
    }

    mapping(bytes32=>mapping(uint=>Order[])) orderBook;

    //no me queda claro el return del orderbook que no está definido en otro lado
    function getOrderBook(bytes32 ticker, Side side)view public returns(Order[]memory){
        return orderBook[ticker][uint(side)];
    } 

}