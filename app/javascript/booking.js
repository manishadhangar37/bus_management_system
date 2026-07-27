
let checkboxes = document.querySelectorAll(".seat-checkbox");
checkboxes.forEach(function(checkbox){
  checkbox.addEventListener("change", function(){

    let selectedSeat = document.querySelectorAll(".seat-checkbox:checked");

    if (selectedSeat.length > 3) {
      this.checked = false;
      alert("You can select maximum 3 seats at a time");
    }

  });

});