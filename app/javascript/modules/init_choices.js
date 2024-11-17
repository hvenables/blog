import "choices";

document.addEventListener("turbo:load", () => {
  const element = document.getElementById("choose-tags");
  initialize_choices(element);
});

document.addEventListener("turbo:render", (event) => {
  const element = document.getElementById("choose-tags");
  initialize_choices(element);
});

function initialize_choices(element) {
  if (element !== null && element.dataset['choice'] !== "active") {
    if (element) {
      new Choices(element, {
        addItems: true,
        addChoices: true,
        addItemFilter: (value) => !!value && value !== '',
        removeItemButton: true,
        duplicateItemsAllowed: false,
      });
    }
  }
}
