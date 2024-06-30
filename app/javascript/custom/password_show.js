const showUserPassword = () => {
  const user_password = document.getElementById("user_password");
  const user_password_btn = document.getElementById("user_password_btn");

  if(user_password) {
    user_password_btn.addEventListener('click', (e) => {
      e.preventDefault();
      if (user_password.type === "password") {
        user_password.type = "text";
        user_password_btn.innerHTML = "<i class='bi bi-eye-slash-fill' aria-label='パスワードを非表示'></i>";
      } else {
        user_password.type = "password";
        user_password_btn.innerHTML = "<i class='bi bi-eye-fill' aria-label='パスワードを表示'></i>";
      }
    });
  };
};

const showUserPasswordConfirmation = () => {
  const user_password_confirmation = document.getElementById("user_password_confirmation");
  const user_password_confirmation_btn = document.getElementById("user_password_confirmation_btn");

  if (user_password_confirmation) {
    user_password_confirmation_btn.addEventListener('click', (e) => {
      e.preventDefault();
      if (user_password_confirmation.type === "password") {
        user_password_confirmation.type = "text";
        user_password_confirmation_btn.innerHTML = "<i class='bi bi-eye-slash-fill' aria-label='パスワードを非表示'></i>";
      } else {
        user_password_confirmation.type = "password";
        user_password_confirmation_btn.innerHTML = "<i class='bi bi-eye-fill' aria-label='パスワードを表示'></i>";
      }
    });
  };
};

const showUserCurrentPassword = () => {
  const user_current_password = document.getElementById("user_current_password");
  const user_current_password_btn = document.getElementById("user_current_password_btn");

  if (user_current_password) {
    user_current_password_btn.addEventListener('click', (e) => {
      e.preventDefault();
      if (user_current_password.type === "password") {
        user_current_password.type = "text";
        user_current_password_btn.innerHTML = "<i class='bi bi-eye-slash-fill' aria-label='パスワードを非表示'></i>";
      } else {
        user_current_password.type = "password";
        user_current_password_btn.innerHTML = "<i class='bi bi-eye-fill' aria-label='パスワードを表示'></i>";
      }
    });
  };
};

document.addEventListener('DOMContentLoaded', () => {
  showUserPassword();
  showUserPasswordConfirmation();
  showUserCurrentPassword();
});

document.addEventListener('turbo:render', () => {
  showUserPassword();
  showUserPasswordConfirmation();
  showUserCurrentPassword();
});
