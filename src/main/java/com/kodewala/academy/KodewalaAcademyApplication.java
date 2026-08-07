package com.kodewala.academy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan // This will enable your existing @WebServlet components
public class KodewalaAcademyApplication {

    public static void main(String[] args) {
        SpringApplication.run(KodewalaAcademyApplication.class, args);
    }
}
