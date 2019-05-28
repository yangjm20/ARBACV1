pragma solidity ^0.4.19;

library Roles {
    struct Role {
        mapping (address => bool) hasRole;
    }

    function addRole(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.hasRole[account] = true;
    }

    function removeRole(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.hasRole[account] = false;
    }

    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.hasRole[account];
    }
}
