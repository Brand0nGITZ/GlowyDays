package model;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "USER")
public class Login {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // This works with GENERATED ALWAYS AS IDENTITY in Derby
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    // Constructors
    public Login() {}

    public Login(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}