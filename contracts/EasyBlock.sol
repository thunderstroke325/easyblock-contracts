// SPDX-License-Identifier: MIT

//    //   / /                                 //   ) )
//   //____     ___      ___                  //___/ /  //  ___      ___     / ___
//  / ____    //   ) ) ((   ) ) //   / /     / __  (   // //   ) ) //   ) ) //\ \
// //        //   / /   \ \    ((___/ /     //    ) ) // //   / / //       //  \ \
////____/ / ((___( ( //   ) )      / /     //____/ / // ((___/ / ((____   //    \ \
// Developed by Dogu Deniz UGUR (https://github.com/DoguD)

pragma solidity ^0.8.0;

// LIBRARIES START
// OpenZeppelin Contracts v4.4.1 (utils/math/SafeMath.sol) Source: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol
library SafeMath {
    function tryAdd(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(uint256 a, uint256 b)
        internal
        pure
        returns (bool, uint256)
    {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard}
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(
            data
        );
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data)
        internal
        view
        returns (bytes memory)
    {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.3._
     */
    function functionDelegateCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.3._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// ERC20 Interface
interface IERC20 {
    function decimals() external view returns (uint8);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function totalSupply() external view returns (uint256);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}

// LIBRARIES END

// PREVIOUS EASYBLOCK CONTRACT INTERFACE
interface Easyblock {
    function holders(uint256 _index) external view returns (address);
    function shareCount(address _address) external view returns (uint256);
}

contract EasyBlock {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // Shareholder Info
    address[] public holders;
    uint256 public holderCount;
    mapping(address => uint256) public shareCount;
    mapping(address => uint256) public claimableReward;
    mapping(address => bool) public isShareHolder;

    uint256 public totalShareCount = 0;
    // Manager Info
    address public manager;
    uint256 public fee = 0; // per 1000
    uint256 public accumulatedFees = 0;
    address public feeCollector;
    // Deposit Token
    address public rewardToken;
    // Purchase Tokens
    address[] public purchaseTokens;
    uint256 public purchaseTokensCount;
    mapping(address => uint256) public purchaseTokensPrice; // In decimals
    mapping(address => uint256) public newInvestments;
    // StrongBlock Node Holders
    address[] public nodeHolders;
    uint256 public nodeHoldersCount;
    uint256 public nodeCount;
    // Statistic Variables
    uint256 public totalInvestmentsInUSD;
    uint256 public totalRewardsDistributedInUSD;
    mapping(address => uint256) public totalUserRewards;
    // Protocol controllers
    bool public sharePurchaseEnabled;
    // Migartion
    bool public isMigrating = true;
    address public previousContract;

    /* ======== EVENTS ======== */
    event Investment(
        uint256 shareAmount,
        uint256 investmentInUSD,
        address shareHolder
    );
    event RewardCollected(uint256 amount, address shareHolder);

    constructor(uint256 _fee, address _previousContract, uint _totalInvestment, uint _totalRewards) {
        manager = msg.sender;
        fee = _fee;
        feeCollector = msg.sender;

        totalInvestmentsInUSD = _totalInvestment;
        totalRewardsDistributedInUSD = _totalRewards;
        sharePurchaseEnabled = false;

        // Migration
        previousContract = _previousContract;
    }

    // Controller toggles
    function toggleSharePurchaseEnabled(bool _enabled) external onlyOwner {
        sharePurchaseEnabled = _enabled;
    }

    // Deposit to Purchase Methods
    function addPurchaseToken(address _tokenAddress, uint256 _tokenPrice)
        external
        onlyOwner
    {
        require(
            !listContains(purchaseTokens, _tokenAddress),
            "Token already added."
        );

        purchaseTokens.push(_tokenAddress);
        purchaseTokensCount += 1;
        purchaseTokensPrice[_tokenAddress] = _tokenPrice;
        newInvestments[_tokenAddress] = 0;
    }

    function editPurchaseToken(address _tokenAddress, uint256 _tokenPrice)
        external
        onlyOwner
    {
        require(
            listContains(purchaseTokens, _tokenAddress),
            "Token is not a purchase asset."
        );

        purchaseTokensPrice[_tokenAddress] = _tokenPrice;
    }

    // Deposit to Share Rewards Methods
    function setDepositToken(address _tokenAddress) external onlyOwner {
        rewardToken = _tokenAddress;
    }

    // NodeHolders
    function setNodeHolder(address _address) external onlyOwner {
        require(!listContains(nodeHolders, _address), "Address already added.");
        nodeHolders.push(_address);
        nodeHoldersCount += 1;
    }

    function setNodeCount(uint256 _count) external onlyOwner {
        nodeCount = _count;
    }

    // Manager Related Methods
    function setManager(address _address) external onlyOwner {
        manager = _address;
    }

    function setFeeCollector(address _address) external onlyOwner {
        feeCollector = _address;
    }

    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }

    function withdrawToManager(address _token, uint256 _amount)
        external
        onlyOwner
    {
        require(listContains(purchaseTokens, _token), "Not a purchase token.");
        require(newInvestments[_token] >= _amount, "Not enough investment.");
        IERC20(_token).safeTransfer(manager, _amount);
        newInvestments[_token] = newInvestments[_token].sub(_amount);
    }

    function depositRewards(uint256 _amount) external {
        // Execute Deposit
        IERC20(rewardToken).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );
        // Stats
        uint256 tenToThePowerDecimals = 10**IERC20(rewardToken).decimals();
        totalRewardsDistributedInUSD = totalRewardsDistributedInUSD.add(
            _amount.div(tenToThePowerDecimals)
        );
        // Fees
        uint256 _feeAmount = fee.mul(_amount).div(1000);
        accumulatedFees = accumulatedFees.add(_feeAmount);
        _amount = _amount.sub(_feeAmount);
        // Reward per share
        uint256 _rewardPerShare = _amount.div(totalShareCount);
        for (uint256 _i = 0; _i < holders.length; _i++) {
            address _currentHolder = holders[_i];
            uint256 _userReward = _rewardPerShare.mul(
                shareCount[_currentHolder]
            );
            claimableReward[_currentHolder] = claimableReward[_currentHolder]
                .add(_userReward);

            totalUserRewards[_currentHolder] = totalUserRewards[_currentHolder]
                .add(_userReward);
        }
    }

    function transferSharesFromManager(
        address _targetAddress,
        uint256 _shareAmount
    ) external onlyOwner {
        require(shareCount[msg.sender] >= _shareAmount, "Not Enough Shares.");
        if (!isShareHolder[_targetAddress]) {
            holders.push(_targetAddress);
            isShareHolder[_targetAddress] = true;
            holderCount += 1;
        }
        shareCount[msg.sender] = shareCount[msg.sender].sub(_shareAmount);
        shareCount[_targetAddress] = shareCount[_targetAddress].add(
            _shareAmount
        );
    }

    function claimFees() external {
        require(msg.sender == feeCollector, "Not fee collector");
        IERC20(rewardToken).safeTransfer(feeCollector, accumulatedFees);
        accumulatedFees = 0;
    }

    // Shareholder Methods
    function claimRewards() external {
        require(isShareHolder[msg.sender], "msg.sender is not a shareholder.");
        IERC20(rewardToken).safeTransfer(
            msg.sender,
            claimableReward[msg.sender]
        );

        emit RewardCollected(claimableReward[msg.sender], msg.sender);

        claimableReward[msg.sender] = 0;
    }

    function buyShares(address _token, uint256 _shareCount) external {
        require(listContains(purchaseTokens, _token), "Not a Purchase Token.");
        require(
            sharePurchaseEnabled,
            "Shares are not purchasable at the moment."
        );

        uint256 _tokenDecimals = IERC20(_token).decimals();
        uint256 _tenToThePowerDecimals = 10**_tokenDecimals;
        uint256 _price = purchaseTokensPrice[_token];
        IERC20(_token).safeTransferFrom(
            msg.sender,
            address(this),
            _price.mul(_shareCount)
        );

        totalInvestmentsInUSD = totalInvestmentsInUSD.add(
            _shareCount.mul(_price).div(_tenToThePowerDecimals)
        );

        if (!isShareHolder[msg.sender]) {
            holders.push(msg.sender);
            isShareHolder[msg.sender] = true;
            holderCount += 1;
            shareCount[msg.sender] = 0;
        }
        shareCount[msg.sender] = shareCount[msg.sender].add(_shareCount);
        totalShareCount = totalShareCount.add(_shareCount);
        newInvestments[_token] = newInvestments[_token].add(
            _price.mul(_shareCount)
        );

        emit Investment(_shareCount, _price.mul(_shareCount), msg.sender);
    }

    // MIGRATION START
    function endMigartion() external onlyOwner {
        isMigrating = false;
    }

    function addHolder(address _holder, uint256 _shareCount) public onlyOwner{
        require(isMigrating, "Migration is not in progress.");
        if (!isShareHolder[_holder]) {
            holders.push(_holder);
            isShareHolder[_holder] = true;
            holderCount += 1;
            shareCount[_holder] = 0;
            
            claimableReward[_holder] = 0;
            totalUserRewards[_holder] = 0;
        }
        shareCount[_holder] = shareCount[_holder].add(_shareCount);
        totalShareCount = totalShareCount.add(_shareCount);
    }

    function copyFromPrevious(
        uint32 _start,
        uint32 _end
    ) external onlyOwner {
        require(isMigrating, "Migration is not in progress.");
        // Access the contract
        Easyblock _easyContract = Easyblock(previousContract);

        for (uint32 _i = _start; _i < _end; _i++) {
            // Calculate the reward
            address _currentHolder = _easyContract.holders(_i);
            uint256 _shareCount = _easyContract.shareCount(_currentHolder);
            
            addHolder(_currentHolder, _shareCount);
        }
    }

    // MIGRATION END

    // HELPERS START
    /**
        @notice checks array to ensure against duplicate
        @param _list address[]
        @param _token address
        @return bool
     */
    function listContains(address[] storage _list, address _token)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < _list.length; i++) {
            if (_list[i] == _token) {
                return true;
            }
        }
        return false;
    }

    // HELPERS END

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == manager);
        _;
    }
}
