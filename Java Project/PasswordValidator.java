import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
public class PasswordValidator {
    public static List<String> validate(String password) {
        List<String> failures = new ArrayList<>();
        if (password.length() < 8) {
            failures.add("Too short (minimum 8 characters, yours has " + password.length() + ")");
        }
        boolean hasUppercase = false;
        boolean hasDigit = false;
        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            if (Character.isUpperCase(c)) {
                hasUppercase = true;
            }
            if (Character.isDigit(c)) {
                hasDigit = true;
            }
            if (hasUppercase && hasDigit) {
                break;
            }
        }
        if (!hasUppercase) {
            failures.add("Missing an uppercase letter");
        }
        if (!hasDigit) {
            failures.add("Missing a digit (0-9)");
        }
        return failures;
    }
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            boolean isValid = false;
            System.out.println("============================================");
            System.out.println("   SafeLog Employee Portal — Password Setup");
            System.out.println("============================================");
            System.out.println("Policy: min 8 chars | 1 uppercase | 1 digit");
            System.out.println();
            while (!isValid) {
                System.out.print("Enter a new password: ");
                String input = scanner.nextLine();
                List<String> failures = validate(input);
                if (failures.isEmpty()) {
                    isValid = true;
                    System.out.println();
                    System.out.println("[OK] Password accepted! Your account is now secured.");
                } else {
                    System.out.println();
                    System.out.println("[REJECTED] Password does not meet policy requirements:");
                    for (String reason : failures) {
                        System.out.println("  - " + reason);
                    }
                    System.out.println("Please try again.");
                    System.out.println();
                }
            }
        }
    }
}