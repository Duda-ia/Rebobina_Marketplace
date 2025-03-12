import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  // static targets = ["busca"]

  connect() {
    console.log("Hello word");
  }

  // test(event) {
  //   console.log("123")
  //   this.buscaTarget.classList.add("d-none");
  //   // event.preventDefault()
  // }
  // controllers/search_controller.js
  static targets = ["input", "busca"]
  test(event) {
    // Prevent the default form submission
    event.preventDefault()
    // Get the search query
    const query = this.inputTarget.value
    console.log(query)
    // Make an AJAX request to the server
    // fetch(`/search?query=${encodeURIComponent(query)}`)
    //   .then(response => response.json())
    //   .then(data => {
    //     // Update the results section with the new data
    //     // this.resultsTarget.innerHTML = data.results.map(result => `<div>${result}</div>`).join('')
    //     console.log(data)
    //   })
      // .catch(error => {
      //   console.error('Error during search:', error)
      // })
  }
}
