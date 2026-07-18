package com.celestin.appchat.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity(name = "messages")
@Data
public class message {
  
  @Id
  private long id;
  @ManyToOne
  private long idSent;
  @ManyToOne
  private long idReceive;
  private String message;
  private boolean status;
}
