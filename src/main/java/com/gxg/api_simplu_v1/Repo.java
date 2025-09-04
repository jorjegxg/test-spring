package com.gxg.api_simplu_v1;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Repo {

    @GetMapping("test")
    public String damiCeva(){
        return "Dave";
    }
}
