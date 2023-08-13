document.addEventListener('turbolinks:load', function() {
  const toggleVisibilityForm = document.querySelector('.toggle-visibility-form');

  if (toggleVisibilityForm) {
    toggleVisibilityForm.addEventListener('submit', function(event) {
      event.preventDefault();
      const form = event.target;

      fetch(form.action, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-CSRF-Token': form.querySelector('input[name="authenticity_token"]').value,
        },
        credentials: 'same-origin',
        body: new URLSearchParams(new FormData(form)),
      })
      .then(response => response.json())
      .then(data => {
        const button = form.querySelector('input[type="submit"]');
        const visibilityText = data.public ? "Change to Private" : "Change to Public";
        button.value = visibilityText;
      })
      .catch(error => console.error(error));
    });
  }
});
