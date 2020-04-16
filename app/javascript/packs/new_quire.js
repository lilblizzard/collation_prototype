function isEven(value) {
  return value % 2 === 0;
}

$(function () {
  $("#create").prop("disabled", true);
  let $leafCountInput = $("#quire_leaf_count");
  $leafCountInput.on("keyup", function () {
    let $count = parseInt($leafCountInput.val());
    if (isEven($count)) {
      $("#create").prop("disabled", false);
    } else {
      $("#create").prop("disabled", false);
    }
  });
});
