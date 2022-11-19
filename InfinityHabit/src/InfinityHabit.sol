// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

//import "../src/Counter.sol";

import "../src/HeraCoin.sol";

contract InfinityHabit 
{

    address public owner;
    HeraToken public hera;
    address heraTokenContract;


    constructor(address _heratokenaddress){
        insertCommunity('Personal Wellness','Community Group focussing on  personal effectiveness', false);
        insertCommunity('Financial Wellness','Community Group focussing on  Financial wellbeing', false);
        insertCommunity('Mental Wellness','Community Group focussing on  mindful living', false);
        insertCommunity('Relationships','Community Group focussing on  building lifelong thriving relationships', false); 
        insertChallenge('Personal Wellness',0, 'Become a earlier riser', 'Practice techniques that helps you to become early raiser', 50, false);
        insertChallenge('Personal Wellness',0, 'Get to zone of flow', 'Practice techniques that helps you to become focussed at your work and achieving your goal', 50, false);
        insertChallenge('Personal Wellness',0, 'Blog everyday', 'Practice techniques that helps you to become consistent and not miss out on your daily planned schedules', 50, false);
        insertChallenge('Financial Wellness',1, 'Invest everyday', 'Practice techniques that helps to apply get financial freedom', 50, false);
        insertCohort("Cohort1", 0) ;  

        insertMetric( "Picture of watch", "Record the time of rise  and picture of watch", 2, 0);
        insertMetric( "Picture with public proof", "Record the time of rise with a picture on a public clock that displays date and time", 5,  0);
        insertMetric( "Gym attendance report", "Record the time with the attendance to Gym class", 5, 0);
        insertMetric( "Work goals acheived", "% of defined goals achieved in 50 mins", 3, 1);
        insertMetric( "Focussed Work", "Focus on work for 35 mins", 5, 1);
        insertMetric( "Blog links", "Send links to blog", 3, 2);
        insertMetric( "Blog links with likes", "Send links to blog with atleast 3 likes/comments", 5, 2);
        insertMetric( "Assessments", "Record of assessment taken", 3, 3);
        insertMetric( "Blog posts", "Blog posts on new learning", 5, 3);
        insertMetric( "Appreciation", "Appreciation from teacher/instructor/mentor", 5, 3);

        enrollIntoChallenge(0, 0);
        enrollIntoChallenge(1, 0);
        enrollIntoChallenge(2, 0);

        uploadImage("Watch Image hash", 0, 0, false,"Yes woke-up today", "Early to bed Early to Raise", "Personal Wellness"); 
        uploadImage("Watch Image hash", 0, 0, false,"Today was no different", "Manage to keep-up the promise to myself", "Personal Wellness"); 

    //    hera = new HeraToken();


        heraTokenContract = _heratokenaddress;
     
        //we need different constructors for different contracts!!
       // s_tokenCounter = 0;
       owner = msg.sender;
    }


    //struct for community
    struct HabitCommunity {
        string name;
        string description;
        bool isClosed;
        uint numberEnrolled;
        uint indexKey;
    }
    //locate community record by name 
    mapping (string => HabitCommunity) public nameToCommunity;
    //locate community record by indexkey 
    mapping (uint => HabitCommunity) public indexKeyToCommunity;
    //emit event for front-end
    event CommunityAdded(string name, string description,uint keyindex);
    //public array to hold community record
    HabitCommunity[] public communities;
    //primary key for community
    uint public  communityKey=0; 

    function insertCommunity (string memory _name, string memory  _description, bool  _isclosed) public returns (uint) {
        //local variable for record
        HabitCommunity memory communityRecord;
        //setup all the values of struct
        communityRecord.name = _name;
        communityRecord.description = _description;
        communityRecord.isClosed = _isclosed;
        communityRecord.numberEnrolled = 0;
        communityRecord.indexKey = communityKey;
        //create a map for access through name
        nameToCommunity[_name] = communityRecord;
        //create a map for access through indexkey
        indexKeyToCommunity[communityKey] = communityRecord;
        //Add to array
        communities.push(communityRecord);
        //emit event
        emit CommunityAdded(_name,  _description, communityKey);
        //increment the primarykey
        communityKey++;
        return (communityKey-1);
    }

    struct CommunityChallenge {
        string name;
        string description;
        uint maxEnroll;
        uint currentEnroll;
        bool isClosed;
        uint communityId;
        uint indexKey;
    }

     //locate challenge record by Community name 
    mapping (string => uint[]) public CommunityNameToChallenge;
     //locate community record by name 
    mapping (string => CommunityChallenge) public nameToChallenge;
    
    //locate community record by indexkey 
    mapping (uint => CommunityChallenge) public indexKeyToChallenge;
    //emit event for front-end
    event ChallengeAdded(string name, string description, uint keyIndex, string communityname, uint communityIndex);
    //public array to hold community record
    CommunityChallenge[] public challenges;
    //primary key for community
    uint public  challengeKey=0; 


    function insertChallenge (string memory _communityName, uint _communityId, string memory _name, string memory  _description, uint _maxEnroll, bool  _isclosed) public returns (uint) {
        //uint[] memory ChallengesForCommunity;
        CommunityChallenge memory challengeRecord;
        challengeRecord.name = _name;
        challengeRecord.description = _description;
        challengeRecord.isClosed = _isclosed;
        challengeRecord.maxEnroll = _maxEnroll; 
        challengeRecord.communityId = _communityId;
        challengeRecord.indexKey = challengeKey;
        CommunityNameToChallenge[_communityName].push(challengeKey);
        nameToChallenge[_name] = challengeRecord;
        indexKeyToChallenge[challengeKey] = challengeRecord;
        challenges.push(challengeRecord);
        emit ChallengeAdded(_name,  _description, challengeKey, _communityName,  _communityId);
        challengeKey++;
        return (challengeKey-1);
    }

    //struct for Metric
    struct ChallengeMetric {
        string name;
        string description;
        uint metricPoints;
        uint challengeId;
        uint indexKey;
    }

    //locate metric record by name 
    mapping (string => uint[]) public ChallengeNameToMetric;

    //locate metric record by name 
    mapping (string => ChallengeMetric) public nameToMetric;
    //locate metrc record by indexkey 
    mapping (uint => ChallengeMetric) public indexKeyToMetric;
    //emit event for front-end
    event MetricAdded(string name, string description,uint metricPoints, uint challengeId, uint indexKey);
    //public array to hold community record
    ChallengeMetric[] public metrics;
    //primary key for community
    uint public  metricKey=0; 

    function insertMetric (string memory _name, string memory  _description, uint _metricPoints, uint _challengeId) public returns (uint) {
        //local variable for record
        ChallengeMetric memory metricRecord;
        //setup all the values of struct
        metricRecord.name = _name;
        metricRecord.description = _description;
        metricRecord.metricPoints = _metricPoints;
        metricRecord.challengeId = _challengeId;
        metricRecord.indexKey = metricKey;
        ChallengeNameToMetric[indexKeyToChallenge[_challengeId].name].push(metricKey);
        //create a map for access through name
        nameToMetric[_name] = metricRecord;
        //create a map for access through indexkey
        indexKeyToMetric[metricKey] = metricRecord;
        //Add to array
        metrics.push(metricRecord);
        //emit event
        emit MetricAdded(_name,  _description, _metricPoints, _challengeId, metricKey);

         //increment the primarykey
        metricKey++;
        return (metricKey-1);
    }

    //struct for Cohorts
    struct ChallengeCohort {
        string name;
        uint challengeId;
        uint indexKey;
    }
    //locate cohort record by name 
    mapping (string => ChallengeCohort) public nameToCohort;
    //locate cohort record ChallengeCohort indexkey 
    mapping (uint => ChallengeCohort) public indexKeyToCohort;
    //emit event for front-end
    event CohortAdded(string name, uint indexKey);
    //public array to hold community record
    ChallengeCohort[] public cohorts;
    //primary key for community
    uint public  cohortKey=0; 

    function insertCohort (string memory _name, uint _challengeId) public returns (uint) {
        //local variable for record
        ChallengeCohort memory cohortRecord;
        //setup all the values of struct
        cohortRecord.name = _name;
        cohortRecord.challengeId = _challengeId;
        cohortRecord.indexKey = cohortKey;
        //create a map for access through name
        nameToCohort[_name] = cohortRecord;
        //create a map for access through indexkey
        indexKeyToCohort[cohortKey] = cohortRecord;
        //Add to array
        cohorts.push(cohortRecord);
        //emit event
        emit CohortAdded(_name, cohortKey);

         //increment the primarykey
        cohortKey++;
        return (cohortKey-1);
    }

        
    //struct for Cohorts
    struct NFTRule {
        string nftType;
        uint nftPrice;
    }
    //locate cohort record by name 
    mapping (string => NFTRule) public nameToNFTRule;
    //emit event for front-end
    event NFTRuleAdded(string name, uint _priceValue);
    //public array to hold community record
    NFTRule[] public nftrules;

    function insertNFTRules (string memory _name, uint _priceValue) public returns (string memory) {
        //local variable for record
        NFTRule memory ruleRecord;
        //setup all the values of struct
        ruleRecord.nftType = _name;
        ruleRecord.nftPrice = _priceValue;
        //create a map for access through name
        nameToNFTRule[_name] = ruleRecord;
        //Add to array
        nftrules.push(ruleRecord);
        //emit event
        emit NFTRuleAdded(_name, _priceValue);

        return (_name);
    }

    function viewNFTRules() view public returns(string memory rule1, string memory rule2, string memory rule3) {
        return (nftrules[0].nftType,nftrules[1].nftType, nftrules[2].nftType );
    }

    struct UserEnrollment {
        address user;
        uint challengeId;
        uint cohortId;
        bool isActive;
        bool isExist;
        uint indexKey;
    }

    UserEnrollment[] public enrollments;
    mapping (address => uint[]) public ownerToEnrollments;
    //locate cohort record ChallengeCohort indexkey 
    mapping (uint => UserEnrollment) public indexKeyToEnrollment;
    event EnrollmentAdded(address user, uint _challengeId, uint _cohortId, uint _enrollmentKey);
   //primary key for enrollment
    uint public  enrollmentKey=0; 

    function enrollIntoChallenge(uint _challengeId, uint _cohortId) public returns(uint) {
        //check if the user has already enrolled into the challge
        if (ownerToEnrollments[msg.sender].length>0) {
            for(uint i=0; i<ownerToEnrollments[msg.sender].length; i++){
                if (enrollments[ownerToEnrollments[msg.sender][i]].challengeId ==_challengeId ){
                    revert("User already enrolled into the challenge");
                }
            }
        }
        bytes memory tempEmptyStringTest = bytes(indexKeyToChallenge[_challengeId].name); // Uses memory
        if (tempEmptyStringTest.length == 0) {
            revert("Invalid challenge");
        }
        tempEmptyStringTest = bytes(indexKeyToCohort[_cohortId].name); // Uses memory
        if (tempEmptyStringTest.length == 0) {
            revert("Invalid cohort");
        }        
        //local variable for record
        UserEnrollment memory EnrollmentRecord;
        //setup all the values of struct
        EnrollmentRecord.challengeId = _challengeId;
        EnrollmentRecord.cohortId = _cohortId;
        EnrollmentRecord.isActive = true;
        EnrollmentRecord.isExist = true;
        EnrollmentRecord.user = msg.sender;

        //create a map to get challenge the user has enrolled to
        ownerToEnrollments[msg.sender].push(enrollmentKey) ;

        //create a map for access through indexkey
        indexKeyToEnrollment[enrollmentKey] = EnrollmentRecord;
        //Add to array
        enrollments.push(EnrollmentRecord);
        //emit event
        emit EnrollmentAdded(msg.sender, _challengeId, _cohortId, enrollmentKey);

         //increment the primarykey
        enrollmentKey++;
        return(enrollmentKey-1);      

    }

    
    struct UploadActivity{
        address user;
        uint enrollmentId;
        uint metricsId;
        string description;
        string uploadURL;
        uint activityDate;
        bool voteforValidity;
    }
    //locate community record by indexkey 
    mapping (uint => UploadActivity) public indexKeyToActivity;
    //emit event for front-end
    event ActivityAdded(address user,uint enrollmentId, uint metricsId, string description, string uploadURL, uint activityDate);
    //public array to hold community record
    UploadActivity[] public activities;
    //primary key for community
    uint public  activityKey=0; 

    function insertActivity (uint _enrollmentId, uint _metricsId, string memory _description, string memory _uploadURL, uint _activityDate) public returns (uint) {
        
        //local variable for record
        UploadActivity memory ActivityRecord;
        //setup all the values of struct
        ActivityRecord.user = msg.sender;
        ActivityRecord.enrollmentId = _enrollmentId;
        ActivityRecord.metricsId = _metricsId;
        ActivityRecord.description = _description;
        ActivityRecord.uploadURL = _uploadURL;
        ActivityRecord.activityDate = _activityDate;
        ActivityRecord.voteforValidity = false;

        //create a map for access through indexkey
        indexKeyToActivity[activityKey] = ActivityRecord;
        //Add to array
        activities.push(ActivityRecord);
        //emit event
        emit  ActivityAdded(msg.sender,_enrollmentId, _metricsId, _description, _uploadURL, _activityDate);
        //increment the primarykey
        activityKey++;
        return (activityKey-1);
    }

    struct ActivityVote{

        uint indexKey;
    }

    function viewChallengebyCommunity(uint _communityId,string memory _communityname )  public view returns( uint[] memory)   {
        //Check if the community exists
        bytes memory stringTest = bytes(nameToCommunity[_communityname].name);
        require (stringTest.length != 0, "community doesnt exist");
        //Check if the community name and id match
        require (nameToCommunity[_communityname].indexKey ==_communityId, "Invalid community key" );
        return (CommunityNameToChallenge[_communityname]);
    }

    function viewMetricbyChallenge(uint _challengeId, string memory _challengename ) public view returns( uint[] memory){
        //Check if the community exists
        bytes memory stringTest = bytes(nameToChallenge[_challengename].name);
        require (stringTest.length != 0, "metric doesnt exist");
        //Check if the community name and id match
        require (nameToChallenge[_challengename].indexKey ==_challengeId, "Invalid metric key" );
        return (ChallengeNameToMetric[_challengename]);
    }

    struct EnrollmentbyUser{
        address user;
        string challengeName;
        string challengeDescription;
        uint enrollmentId;
        uint challengeId;
    }
    uint[] ownerEnrollment;
    uint enrollmentId;

    EnrollmentbyUser enrollmentbyUser;
    EnrollmentbyUser[]  enrollmentsbyuser;

    function viewEnrollmentsbyUserFe()  public returns(EnrollmentbyUser[] memory){


        ownerEnrollment = ownerToEnrollments[msg.sender];
        for (uint i=0; i<ownerEnrollment.length; i++)
        {
            enrollmentId = ownerEnrollment[i];
            enrollmentbyUser.user = msg.sender;
            enrollmentbyUser.challengeName = challenges[enrollments[enrollmentId].challengeId].name;
            enrollmentbyUser.challengeDescription = challenges[enrollments[enrollmentId].challengeId].description;
            enrollmentbyUser.enrollmentId = enrollmentId;
            enrollmentbyUser.challengeId = enrollments[enrollmentId].challengeId;
            enrollmentsbyuser.push(enrollmentbyUser);
        }
        return (enrollmentsbyuser);
    }

 //Image is Acivity Upload
    struct Image {
        
        string ipfsHash;        // IPFS hash
        uint256 enrollmentId;   // EnrollmentId
        uint256 metricId;       // Metric ID 
        bool isValidated;       // Valid or Not 
        string title;           // Image title
        string description;     // Image description
        string tags;            // Image tags in comma separated format
        uint256 uploadedOn;     // Uploaded timestamp
        uint keyIndex;          //primary key

    }


    // Maps owner to their images
    mapping (address => Image[]) public ownerToImages;

    //Mapping from enrollmentId to the Activity Upload (Image)
    mapping (uint256 => Image[]) public enrollmentIdToImages;
    uint keyIndex;
    Image[] public images;
    event LogImageUploaded(
        address indexed _owner, 
        string _ipfsHash,
        uint256 _enrollmentId,  
        uint256 _metricId,       
        bool _isValidated,      
        string _title, 
        string _description, 
        string _tags,
        uint256 _uploadedOn

    );
 
    function uploadImage(string memory _ipfsHash, uint256 _enrollmentId, uint256 _metricId, bool _isValidated, string memory _title, string memory _description, string memory _tags) public returns (bool _success) {
            
        //require(bytes(_ipfsHash).length == 46);
        require(bytes(_title).length > 0 && bytes(_title).length <= 256);
        require(bytes(_description).length < 1024);
        require(bytes(_tags).length > 0 && bytes(_tags).length <= 256);

        uint256 uploadedOn = block.timestamp;
        Image memory image = Image(
            _ipfsHash,
            _enrollmentId,
            _metricId,
            _isValidated,
            _title,
            _description,
            _tags,
            uploadedOn,
            keyIndex
        );

        ownerToImages[msg.sender].push(image);
        images.push(image);
        enrollmentIdToImages[_enrollmentId].push(image);

        emit LogImageUploaded( msg.sender,_ipfsHash, _enrollmentId, _metricId,_isValidated, _title, _description, _tags, uploadedOn);

        keyIndex++;
        _success = true;
    }

    function viewActivitybyEnrollment(uint _enrollmentid) view public returns(Image[] memory) {
        return(enrollmentIdToImages[_enrollmentid]);
    }

    function viewEnrollmentsbyUser()  public view returns(uint[] memory){
        return(ownerToEnrollments[msg.sender]);
    }

    function validateActivity(uint activityId) public returns(uint) {
        HeraToken ht = HeraToken(heraTokenContract);
       
        //require(msg.sender == owner);
        images[activityId].isValidated = true;

        ht.transfer(msg.sender, 5);
        return(50);        
    }

    function viewPointBalances(address accnt) view public returns (uint){
         HeraToken ht = HeraToken(heraTokenContract);
         accnt = msg.sender;
        return (ht.balanceOf(accnt));
    }

    function accumulatePointsByUser() public {
    }

 /*   //Get Current User Balance
    //uint currentCoin = balanceOf(msg.sender);

    //Get the Boundries for the Amount of Coins for Bronze, Silver, Gold NFT
    uint priceBronze = nameToNFTRule[NFTType(1)[1]];
    uint priceSilver = nameToNFTRule[NFTType(2)[1]];
    uint priceGold = nameToNFTRule[NFTType(3)[1]];

    NFTType nfttype; 
    mapping(address => nfttype) UserToCurrentType;
    event CurrentNFT(address user, NFTType nft);

    function returnEligibleNFTByUser() public {
        //Map the current NFT Type to the User according to the amount of Coins the user currently has

        if(currentCoin >= priceBronze && currentCoin < priceSilver) {
            nfttype = NFTType(1);
            UserToCurrentType[msg.sender] = nfttype;

        } else if(currentCoin >= priceSilver && currentCoin < priceGold) {
            nfttype = NFTType(2);
            UserToCurrentType[msg.sender] = nfttype;

        } else if(currentCoin >= priceGold) {
            nfttype = NFTType(3);
            UserToCurrentType[msg.sender] = nfttype;
        } else {
            nfttype = NFTType(0);
        }

        //Return which NFT Type (Bronze, Silver, Gold) the User is eligible for
        return UserToCurrentType[msg.sender]; 
        emit CurrentNFT(msg.sender, nfttype);



    }

    string public token_URI;
    uint256 private s_tokenCounter;

    string[] public TOKEN_URI_ARRAY = [
        "",
        "https://ipfs.io/ipfs/QmWu3YEauufy8PFgqhdeoxLs75PhDF8woTwgXC9xyQJHAJ", 
        "https://ipfs.io/ipfs/QmUh78gwwdqg58Zv6EQdHFWTN4odidsEF5aTsAe2247ABY",
        "https://ipfs.io/ipfs/QmYZmiRcom5NxruUPeD5K5qKQ6He7biKUHuhraaN9ToCwu"];


    function claimNFTByPoints() public {

        //mint function, depending on what EligibleNFTByUser returns (None, Bronze, Silver,Gold)
 
        require(coinCount > priceBronze, "Sorry, you have insufficient Coins"); 

        if (UserToCurrentType[msg.sender] == NFTType(1)) {
            //deduct coins from balance
            balanceOf(msg.sender) -= priceBronze;
            //Set token URI to mint the correct token
            token_URI = TOKEN_URI_ARRAY[1];
            
        } else if (UserToCurrentType[msg.sender] == NFTType(2)) {
            balanceOf(msg.sender) -= priceSilver;
            token_URI = TOKEN_URI_ARRAY[2];

        } else if (UserToCurrentType[msg.sender] == NFTType(3)) {
            balanceOf(msg.sender) -= priceGold;
            token_URI = TOKEN_URI_ARRAY[3];
        }

        //mint NFT
        _safeMint(msg.sender, s_tokenCounter);
        
        //increase token Counter
        s_tokenCounter = s_tokenCounter + 1;

    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return token_URI;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

        */
    



}
