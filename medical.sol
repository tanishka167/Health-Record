// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MedicalRecord{

    struct Patient{
    
        string name;
        string phone;
        string gender;
        string dob;
        string bloodgroup;
        string allergies;
        string medication;
        address addr;
    }

    struct Doctor{
        
        string name;
        string phone;
        string gender;
        string dob;
        string speacialist;
        address addr;
    }

    address public owner;
    address[] public patients; //address of the patients 
    string[] records; //stores multiple records of the patients
    uint256[] recordId; 
    

    event setStatus(address addr,string message);
    event editStatus(address addr,string message);
    event editByDoctor(address addr,string message);
    event editedData(string data,string message);

    mapping(address => Patient) public patientsListData; //entire details of the patient
    mapping(address => Doctor) public doctorsListData; //entire details of the doctor
    address[] public doctors;

    mapping(address => string[]) public patientRecords; //stores patients records
    constructor(){
        owner=msg.sender;
    }


    // set details of Patient initially 
    function setDetailsPatient(string memory _name,string memory _phone,string memory _gender,string memory _dob,string memory _bloodgroup,string memory _allergies) public{
        require(!isAvailable(msg.sender),"Already registered");

       

        Patient storage patient=patientsListData[msg.sender];
        patient.addr=msg.sender;
        patient.name=_name;
        patient.phone=_phone;
        patient.gender=_gender;
        patient.dob=_dob;
        patient.bloodgroup=_bloodgroup;
        patient.allergies=_allergies;
        

        patients.push(msg.sender);

        emit setStatus(msg.sender,"Patient's Details Added Successfully");
    }

    modifier onlyMember(address _address){
        require(isAvailable(_address),"Sorry, not the member");
        _;
    }

      // Is the patient is registered or not
    function isAvailable(address _address)public view returns(bool){
        for(uint256 i=0;i<patients.length;i++){
            if(patients[i]==_address){
                return true;
            }
        }
        return false;
    }

    modifier onlyDoctor(address _address){
        require((isAllowed(_address)),"Address not allowed");
        _;
    }

    // Is the doctor is registered or not
    function isAllowed(address _address)public view returns(bool){
        for(uint256 i=0;i<doctors.length;i++){
            if(doctors[i]==_address){
                return true;
            }
        }
        return false;
    }

    // edit Details Patient
    function editDetailsPatient(address _address,string memory _name,string memory _phone,string memory _dob,string memory _bloodgroup,string memory _gender,string memory _allergies,string memory _medication)public onlyMember(_address){
        Patient storage patient=patientsListData[msg.sender];
        
        patient.name=_name;
        patient.phone=_phone;
        patient.dob=_dob;
        patient.bloodgroup=_bloodgroup;
        patient.gender=_gender;
        patient.allergies=_allergies;
        patient.medication=_medication;

        emit editStatus(msg.sender,"Successfully edited the patient's data");
    }


    // set Details Doctor initially
    function setDetailsDoctor(address _addr,string memory _name,string memory _gender,string memory _phone,string memory _dob,string memory _speaclist)public {
        require(!isAllowed(_addr) && !isAvailable(_addr),"Already registered");
        
        Doctor storage doctor=doctorsListData[msg.sender];

        doctor.addr=_addr;
        doctor.name=_name;
        doctor.dob=_dob;
        doctor.gender=_gender;
        doctor.phone=_phone;
        doctor.speacialist=_speaclist;

        doctors.push(_addr);

        emit setStatus(msg.sender,"Doctor's Details Added Successfully");
    }
     
    function editDetailsByDoctor(address _PatAddress,address _DocAddress,string memory _record)public onlyMember(_PatAddress) onlyDoctor(_DocAddress){
        Patient storage patient=patientsListData[_PatAddress];
    
        patient.medication= _record;
        records.push(_record); //sets the multiple records to the patient
        

        // Add the record to the patient's records mapping
        patientRecords[_PatAddress].push(_record);

        emit editedData(patient.medication,"Data Successfully Updated by the verified docotor");
    } 

    // get patients records of medications from start to end medications i.e. all medications till last consumed
    function getMedicationRecords(address _patient) public view returns (string[] memory) {
    return patientRecords[_patient];
    }

    // get the data of the particular patient
    function getDataPatient(address _patient)public view returns(string memory,string memory,string memory,string memory,string memory,string memory,string memory){
        Patient memory singlePatient=patientsListData[_patient];
        
        return (singlePatient.name, singlePatient.phone, singlePatient.dob, singlePatient.bloodgroup, singlePatient.gender, singlePatient.allergies,singlePatient.medication); //medication which is last consumed by the patient
    
    }
}
