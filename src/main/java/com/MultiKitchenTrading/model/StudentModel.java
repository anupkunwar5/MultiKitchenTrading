package com.MultiKitchenTrading.model;

import java.time.LocalDate;

public class StudentModel {

    private int id;
    private String firstName;
    private String lastName;
    private String userName;
    private LocalDate dob;
    private String gender;
    private String email;
    private String number;
    private String password;
    private ProgramModel program;
    private String image_path;

    // Default constructor
    public StudentModel() {}

    // Parameterized constructor
    public StudentModel(int id, String firstName, String lastName, String userName, LocalDate dob, String gender,
                        String email, String number, String password, String image_path, ProgramModel program) {
    	super();
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.userName = userName;
        this.dob = dob;
        this.gender = gender;
        this.email = email;
        this.number = number;
        this.password = password;
        this.image_path = image_path;
        this.program = program;
    }
    
    public StudentModel( String firstName, String lastName, String userName, LocalDate dob, String gender,
            String email, String number, String password, String image_path, ProgramModel program) {
		
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.dob = dob;
		this.gender = gender;
		this.email = email;
		this.number = number;
		this.password = password;
		this.image_path = image_path;
		this.program = program;
	}
    
    

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
    }

    public ProgramModel getprogram() {
        return program;
    }

    public void setprogram(ProgramModel program) {
        this.program = program;
    }
}
