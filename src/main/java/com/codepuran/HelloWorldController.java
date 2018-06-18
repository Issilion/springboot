package com.codepuran;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloWorldController {

  @Value("${welcome.message:test}")
  private String message = "Hello World";

  @RequestMapping("/")
  public String welcomeq(Model model) {
    return "welcome";
  }

    @RequestMapping("/get-data")
    public String getData() {
        return "welcome";
    }
}
