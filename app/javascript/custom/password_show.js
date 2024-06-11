function showUserPassword() {
  let user_password = document.getElementById("user_password");
  let user_password_btn = document.getElementById("user_password_btn");

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

function showUserPasswordConfirmation() {
  let user_password_confirmation = document.getElementById("user_password_confirmation");
  let user_password_confirmation_btn = document.getElementById("user_password_confirmation_btn");

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

function showUserCurrentPassword() {
  let user_current_password = document.getElementById("user_current_password");
  let user_current_password_btn = document.getElementById("user_current_password_btn");

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

document.addEventListener('turbo:load', function() {
  showUserPassword();
  showUserPasswordConfirmation();
  showUserCurrentPassword();
});

document.addEventListener('turbo:render', function() {
  showUserPassword();
  showUserPasswordConfirmation();
  showUserCurrentPassword();
});
