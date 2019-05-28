pragma solidity ^0.4.19;
import "browser/Roles.sol";
import "browser/OwnShip.sol";
contract School is OwnShip {
    using Roles for Roles.Role;
    mapping (address => bool) studentPays;
    mapping (address => bool) studentGrades;

    Roles.Role private teachers;
    Roles.Role private students;

    function addTeacherRoles(address [] memory _teachers) public onlyOwner {
        for(uint i=0; i< _teachers.length; i++)
        {
            teachers.addRole(_teachers[i]);
        }
    }
    function addStudentRoles(address [] memory _students) public onlyOwner
    {
        for(uint j =0; j< _students.length; j++)
        {
            students.addRole(_students[j]);
        }
    }

    function isPay(uint amount) external pure returns (bool)
    {
        return amount == 8000 ether;

    }
    
    function payFees() public payable {
        require(students.has(msg.sender));
        if(this.isPay(msg.value))
        {
            address(uint160(owner())).transfer(msg.value);
            studentPays[msg.sender] = true;
        }

    }

    function gradeStudent(address student, bool grade) public
    {
        require(teachers.has(msg.sender));
        require(students.has(student));
        studentGrades[student] = grade;
    }

    modifier validAddress(address _address) {
        require(_address != address(0));
        _;
    }

    function hasPaidFees(address account) validAddress(account) public view returns (bool) {
        require(students.has(account));
        return studentPays[account];
    }

    function terminateClass() onlyOwner public {
        selfdestruct(msg.sender);
    }

    function getBalance(address account) public constant returns(uint){
        return account.balance;
    }
}

