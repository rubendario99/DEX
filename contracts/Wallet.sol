pragma solidity 0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Wallet {

    using SafeMath for uint256;

    struct Token{
        bytes32 ticker;
        address tokenAddress;
    }

    mapping(bytes32=>Token) public tokenMapping;
    bytes32[]public tokenList;

    mapping (address=>mapping(bytes32=>uint256)) public balances;



    //mejor permitir que esto solo lo pueda hacer el owner
    function addToken(bytes32 ticker, address tokenAddress) external {
        tokenMapping[ticker] = Token(ticker,tokenAddress);
        tokenList.push(ticker);
    }

    function deposit(uint amount, bytes32 ticker) external{

        require(tokenMapping[ticker].tokenAddress!=address(0));
        require(amount>0, "necesitas depositar mqs de 0");
        
        //deberíamos añadir un allowance para antes de permitir que se depositen los fondos

        balances[msg.sender][ticker]= balances[msg.sender][ticker].add(amount);
        IERC20(tokenMapping[ticker].tokenAddress).transferFrom(msg.sender, address(this), amount);

    }

    function withdraw(uint amount, bytes32 ticker) external{

        require(tokenMapping[ticker].tokenAddress!=address(0));
        require(balances[msg.sender][ticker]>=amount, "balance not sufficient");
        
        balances[msg.sender][ticker]= balances[msg.sender][ticker].sub(amount);
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender,amount);
    }

}