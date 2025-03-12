import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  static targets = ["vinyl", "cassette", "old-stuff", "cd"]

  connect() {
    console.log("Hello from our first Stimulus controller");
  }

  click(event) {
    // Get the "filter_target" value from the clicked element
    const filterValue = event.currentTarget.dataset.filterTarget;

    // Create a new URLSearchParams instance with the current URL's query parameters
    const urlParams = new URLSearchParams();

    // Set the "category" parameter with the filterValue
    urlParams.set("category", filterValue);

    // Construct the new URL for the categories page with the updated query parameter
    const filterUrl = `/categories?${urlParams.toString()}`;

    // Redirect the user to the new categories page
    window.location.href = filterUrl;

    console.log("Clicked filter, redirecting to:", filterUrl);
  }

}
