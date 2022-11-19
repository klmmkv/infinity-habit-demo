// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/InfinityHabit.sol";
import "../src/HeraCoin.sol";

contract RelationshipTest is Test {
    InfinityHabit public habit;
    HeraToken public heratoken;
    address testPrimaryAccount = address(0xABCD);
    address testSecondaryAccount = address(0xABDC);
    address feaccount = address(0xA2a3AF08736ecbA58A62784908D44eB7590202E4);
    //NFTType nftAward;

    function setUp() public {
        heratoken = new HeraToken();

        habit = new InfinityHabit(address(heratoken));
        //testinsertCommunity();
        //testinsertChallenge();
        //testinsertCohort(); 
      // testinsertMetric();         
    }

   /* function testinsertCommunity() public {
        habit.insertCommunity('Personal Wellness','Community Group focussing on  personal effectiveness', false);
        habit.insertCommunity('Financial Wellness','Community Group focussing on  Financial wellbeing', false);
        habit.insertCommunity('Mental Wellness','Community Group focussing on  mindful living', false);
        habit.insertCommunity('Relationships','Community Group focussing on  building lifelong thriving relationships', false);

        // assertEq(1, 1);
    }

    function testinsertChallenge() public {
        habit.insertChallenge('Personal Wellness',0, 'Become a earlier riser', 'Practice techniques that helps you to become early raiser', 50, false);
        habit.insertChallenge('Personal Wellness',0, 'Get to zone of flow', 'Practice techniques that helps you to become focussed at your work and achieving your goal', 50, false);
        habit.insertChallenge('Personal Wellness',0, 'Blog everyday', 'Practice techniques that helps you to become consistent and not miss out on your daily planned schedules', 50, false);
        habit.insertChallenge('Financial Wellness',1, 'Invest everyday', 'Practice techniques that helps to apply get financial freedom', 50, false);
    }

    function testinsertMetric() public {
        habit.insertMetric( "Picture of watch", "Record the time of rise  and picture of watch", 2, 0);
        habit.insertMetric( "Picture with public proof", "Record the time of rise with a picture on a public clock that displays date and time", 5,  0);
        habit.insertMetric( "Gym attendance report", "Record the time with the attendance to Gym class", 5, 0);
        habit.insertMetric( "Work goals acheived", "% of defined goals achieved in 50 mins", 3, 1);
        habit.insertMetric( "Focussed Work", "Focus on work for 35 mins", 5, 1);
        habit.insertMetric( "Blog links", "Send links to blog", 3, 2);
        habit.insertMetric( "Blog links with likes", "Send links to blog with atleast 3 likes/comments", 5, 2);
        habit.insertMetric( "Assessments", "Record of assessment taken", 3, 3);
        habit.insertMetric( "Blog posts", "Blog posts on new learning", 5, 3);
        habit.insertMetric( "Appreciation", "Appreciation from teacher/instructor/mentor", 5, 3);
    }

    function testinsertCohort() public {
        habit.insertCohort("Cohort1", 0);
    }

    function testinsertNFTRules() public {
    //nftAward = habit.NFTType.Bronze;  
        string memory nftname1;         
        string memory nftname2;         
        string memory nftname3;         
        habit.insertNFTRules ("Bronze", 40); 
        habit.insertNFTRules ("Silver", 70); 
        habit.insertNFTRules ("Gold", 90); 
        (nftname1, nftname2, nftname3) = habit.viewNFTRules();        
        assertEq(nftname1, "Bronze");
        assertEq(nftname2, "Silver");
        assertEq(nftname3, "Gold");

    }

    function testinsertEnrollment() public {
        habit.enrollIntoChallenge(0, 0) ;
		vm.expectRevert("User already enrolled into the challenge");
        habit.enrollIntoChallenge(0, 0) ;
       //habit.insertCohort("Cohort1", 0);
    }

    function testinsertEnrollmentforDifferentuser() public {
        vm.prank(testPrimaryAccount);   
        if (habit.enrollIntoChallenge(0, 0) == 1) {
            assertFalse(false);
        }
        else
            assertFalse(true);
        //habit.insertCohort("Cohort1", 0);
    }

    function testviewenrollmentsbyowner() public{
        uint[] memory returnvalue;
        habit.enrollIntoChallenge(0, 0);
        habit.enrollIntoChallenge(1, 0);
        habit.enrollIntoChallenge(2, 0);
        returnvalue =habit.viewEnrollmentsbyUser() ;
        assertEq(returnvalue.length, 3);
    }

    function testviewenrollmentsbyprimaryowner()  public{
        uint[] memory returnvalue;
        vm.prank(testPrimaryAccount);
        habit.enrollIntoChallenge(1, 0);
        returnvalue = habit.viewEnrollmentsbyUser();
        assertEq(returnvalue.length, 1);

    }

    function testinsertEnrollmentforinvalidchallenge() public {
    	vm.expectRevert("Invalid challenge");
        habit.enrollIntoChallenge(10, 0);
    }        

    function testinsertEnrollmentforinvalidcohort() public {
		vm.expectRevert("Invalid cohort");
        habit.enrollIntoChallenge(0, 1) ;
    }

    function testviewChallengebyCommunity() public {
        uint[] memory challenges;
        challenges = habit.viewChallengebyCommunity(0, "Personal Wellness");
        console.logUint(challenges.length);
        assertEq(challenges.length, 3);

        challenges = habit.viewChallengebyCommunity(1, "Financial Wellness");
        console.logUint(challenges.length);
        assertEq(challenges.length, 1);

   		vm.expectRevert("community doesnt exist");
        challenges = habit.viewChallengebyCommunity(1, "Wrong");

   		vm.expectRevert("Invalid community key");
        challenges = habit.viewChallengebyCommunity(0, "Financial Wellness");

    }

    function testviewMetricsbyChallenge() public {
        uint[] memory metrics;
        metrics = habit.viewMetricbyChallenge(0, "Become a earlier riser");
        console.logUint(metrics.length);
        assertEq(metrics.length, 3);

        metrics = habit.viewMetricbyChallenge(1, "Get to zone of flow");
        console.logUint(metrics.length);
        assertEq(metrics.length, 2);

        metrics = habit.viewMetricbyChallenge(2, "Blog everyday");
        console.logUint(metrics.length);
        assertEq(metrics.length, 2);

        metrics = habit.viewMetricbyChallenge(3, "Invest everyday");
        console.logUint(metrics.length);
        assertEq(metrics.length, 3);

   		vm.expectRevert("metric doesnt exist");
        metrics = habit.viewMetricbyChallenge(1, "Wrong");

   		vm.expectRevert("Invalid metric key");
        metrics = habit.viewMetricbyChallenge(0, "Invest everyday");

    }

    function testuploadImage() public{
        bool result = false;
        result = habit.uploadImage("Watch Image hash", 0, 0, false,"Yes woke-up today", "Early to bed Early to Raise", "Personal Wellness"); 
        assertEq(result, true);        
        result =habit.uploadImage("Watch Image hash", 0, 0, false,"Today was no different", "Manage to keep-up the promise to myself", "Personal Wellness"); 
        assertEq(result, true);        

    }*/


    function testviewPointBalances() view public {
        uint bal;
        bal = habit.viewPointBalances(0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f);
        console.logUint(bal);
    }

    function testviewPointBalancesforotheraccount() view public {
        uint bal;
        bal = habit.viewPointBalances(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        console.logUint(bal);
    }

    

   function testvalidateactivity() public{
        uint result;
        uint bal;
        vm.prank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        bal = habit.viewPointBalances(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        console.logUint(bal);
        console.logUint(heratoken.balanceOf(address(heratoken)));
        heratoken.transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 1);
        // result = habit.validateActivity(0);
        // //console.logBool(habit.images[0].isValidated);
        // assertEq(result, 50);        
        // result = habit.validateActivity(1);
        // //console.logBool(habit.images[1].isValidated);
        // assertEq(result, 50);        

    }



}
