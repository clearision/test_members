$(document).on("turbolinks:load", () => {
  const renderSearchResults = function(response) {
    let results = response.result
    let container = $('.search-results')
    let resultsHtml = results.length ? "" : "No results"

    for(let i = 0; i < results.length; i++) {
      let result = results[i]
      let members = result.path.map((el) => { return "<a href='/members/" + el.id + "'>" + el.name + "</a>"}).join(" -> ")
      let heading = result.heading.join(", ")

      resultsHtml = resultsHtml.concat("<div>", members," (", heading, ") </div>")
    }

    container.html(resultsHtml)
  }

  const renderErrors = function() {
    console.log("Some errors occured")
  }

  $('.search-btn').on('click', () => {
    let memberId = $('.search-member-id').val()
    let query = $('.search-input').val()

    $.ajax({
      url: '/members/' + memberId + '/search',
      type: 'get',
      data: { query: query },
      dataType: 'json',
      success: renderSearchResults,
      error: renderErrors
    })
  })
})
