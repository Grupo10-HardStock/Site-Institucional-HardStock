$(document).ready(function(){
    $('#mobile_btn').on('click', function(){
        $('#mobile_menu').toggleClass('active')
        $('#mobile_btn').find('i').toggleClass('fa-x')
    })
})

let darkmode = localStorage.getItem('darkmode')
const themeSwitch = document.getElementById('theme-switch')

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

let darkmodeMobile = localStorage.getItem('darkmode')
const themeSwitchMobile = document.getElementById('mobile-theme-switch')

const enableDarkmodeMobile = () => {
    document.body.classList.add('darkmode')
    localStorage.setItem('darkmode', 'active')
}

const disableDarkmodeMobile = () => {
    document.body.classList.remove('darkmode')
    localStorage.setItem('darkmode', null)
}

if(darkmodeMobile === "active") enableDarkmodeMobile()

themeSwitchMobile.addEventListener("click", () => {
    darkmodeMobile = localStorage.getItem('darkmode')
    darkmodeMobile !== "active" ? enableDarkmodeMobile() : disableDarkmodeMobile()
})