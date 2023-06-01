package com.bettinghouse;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
	
	/*
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut successFile() : call(* BettingHouse.successfulSignUp(..) );
    after() : successFile() {
    	System.out.println("**** User created ****");
    }
    
    pointcut success() : call(* BettingHouse.successfulSignUp(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despues de haber creado un usuario 
    	System.out.println("**** User created ****");
    	
    }
    
    Calendar cal = Calendar.getInstance();
	String str = String.format("**** %s ****",  cal.getTime());
	System.out.println(str);
	
	
	try {
    		BufferedWriter writer = new BufferedWriter(new FileWriter("Register.txt",true));
    		writer.write("Texto");
    		writer.close();
    	} catch (IOException e) {
    		e.printStackTrace();
	}
    
	*/
	
	
	
	pointcut registro(User user, Person person): call(* BettingHouse.successfulSignUp(User, Person) ) && args(user, person);
    after(User user, Person person) returning: registro(user,person) {
    	
        Calendar cal = Calendar.getInstance();
    	
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("Register.txt",true));
			writer.write("Usuario registrado: ["+user.toString()+"] Fecha: ["+cal.getTime()+"]\n");
			writer.close();
			} catch (IOException e) {
				e.printStackTrace();
		}
    	
    }
    
	pointcut loggeo(User user): call(* BettingHouse.effectiveLogIn(User) ) && args(user);
    after(User user) returning: loggeo(user) {
    	
        Calendar cal = Calendar.getInstance();
    	
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("Log.txt",true));
			writer.write("Sesion Iniciada por Usuario: ["+user.getNickname()+"] Fecha: ["+cal.getTime()+"]\n");
			writer.close();
		} catch (IOException e) {
				e.printStackTrace();
		}
    	
    }
    
    pointcut desloggeo(User user): call(* BettingHouse.effectiveLogOut(User) ) && args(user);
    after(User user) returning: desloggeo(user) {
    	
        Calendar cal = Calendar.getInstance();
    	
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("Log.txt",true));
			writer.write("Sesion Cerrada por Usuario: ["+user.getNickname()+"] Fecha: ["+cal.getTime()+"]\n");
			writer.close();
		} catch (IOException e) {
				e.printStackTrace();
		}
    	
    }
	
	
}
