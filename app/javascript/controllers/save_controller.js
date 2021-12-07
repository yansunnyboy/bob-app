import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    url: String,
  };
  static targets = ["product"];

  connect() {
    console.log("Saved Controller");
  }
  addToList(e) {
    e.preventDefault();
    console.log("added to list");
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        Accept: "text/plain",
        "X-CSRF-TOKEN": document.querySelector("[name=csrf-token]").content,
      },
    })
      .then((response) => response.text())
      .then((data) => {
        this.productTarget.outerHTML = data;
      });
  }
}
