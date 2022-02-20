package com.ulick;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackages = {"com.uclick.web"})
@ComponentScan(basePackages = {"com.uclick.service"})
@EntityScan("com.uclick.domain")
@EnableJpaRepositories(basePackages = {"com.uclick.repository"})
public class UclickProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(UclickProjectApplication.class, args);
	}

}
