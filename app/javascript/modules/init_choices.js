import "choices";

export function initChoices() {
  const element = document.getElementById("choose-tags");
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
