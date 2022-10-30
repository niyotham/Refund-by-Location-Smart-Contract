const RefundContract = artifacts.require("RefundContract") ;
  
contract("RefundContract" , () => {
    it("creating employee testing" , async () => {
       const refundContract = await RefundContract.deployed() ;
       await refundContract.setEmployeeAccount(
        "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",0,0,5,1,0 ) ;
       const result = await refundContract.getEmployees() ;

       assert(result.length > 0) ;
    });
it("getting admin testing" , async () => {
       const refundContract = await RefundContract.deployed() ;
        const admin = await refundContract.getAdmin();
       assert(admin.length > 0);
    });
    it("listing employees testing" , async () => {
       const refundContract = await RefundContract.deployed() ;
        const employees = await refundContract.getEmployees();
       assert(employees.length > 0);
    });
    it("update employee's status testing" , async () => {
       const refundContract = await RefundContract.deployed() ;
        const result = await refundContract.updateCompCountStatus(1,1);
       assert(result.receipt.status == true);
    });
    
});