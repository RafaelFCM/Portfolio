const campoForm = document.querySelectorAll("[required]");

campoForm.forEach((campo) => {
    campo.addEventListener("blur", () => validar(campo))
});

function validar(campo){
    if(campo.name == "cpf"){
        alert(campo.value)
    }
};

// Example starter JavaScript for disabling form submissions if there are invalid fields
(() => {
    'use strict'
  
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    const forms = document.querySelectorAll('.needs-validation')
  
    // Loop over them and prevent submission
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }
  
        form.classList.add('was-validated')
      }, false)
    })
})()
