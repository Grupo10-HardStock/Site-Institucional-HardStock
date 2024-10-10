const themeSwitch = document.getElementById('theme-switch')
let darkmode = localStorage.getItem('darkmode')

const enableDarkmode = () => {
    document.body.classList.add('darkmode')
    localStorage.setItem('darkmode', 'active')
}

const disableDarkmode = () => {
    document.body.classList.remove('darkmode')
    localStorage.setItem('darkmode', null)
}

if(darkmode === "active") enableDarkmode()

themeSwitch.addEventListener("click", () => {
    darkmode = localStorage.getItem('darkmode')
    darkmode !== "active" ? enableDarkmode() : disableDarkmode()
})



function toggleDarkMode() {
    const body = document.body;
    const themeToggleIcon = document.getElementById('themeToggleIcon');

    // Alterna o modo escuro/claro
    body.classList.toggle('dark-mode');

    // Alterar ícone conforme o tema
    if (body.classList.contains('dark-mode')) {
        themeToggleIcon.classList.remove('fa-moon');
        themeToggleIcon.classList.add('fa-sun'); // Ícone de sol para o modo escuro
    } else {
        themeToggleIcon.classList.remove('fa-sun');
        themeToggleIcon.classList.add('fa-moon'); // Ícone de lua para o modo claro
    }
}