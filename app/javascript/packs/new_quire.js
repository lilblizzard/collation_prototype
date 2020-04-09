function isEven(value) {
    return value % 2 === 0;
}

function manage(txt) {
    let button = document.getElementById("create");
    let input_value = parseInt(txt.value);
    button.disabled = !isEven(input_value);
}

