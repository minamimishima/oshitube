document.addEventListener('turbo:frame-missing', (e) => {
  const { detail: { response, visit } } = e;
  e.preventDefault();
  visit(response.url);
});
