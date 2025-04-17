const searchIcon = document.getElementById('search-icon');
        const searchBox = document.getElementById('search-box');

        searchIcon.addEventListener('click', () => {
            searchBox.classList.toggle('show');
        });

let slides = document.querySelectorAll('.home .slide');
let index = 0;
let autoSlideInterval;

function next() {
    slides[index].classList.remove('active');
    index = (index + 1) % slides.length;
    slides[index].classList.add('active');
}

function prev() {
    slides[index].classList.remove('active');
    index = (index - 1 + slides.length) % slides.length;
    slides[index].classList.add('active');
}

function startAutoSlide() {
    autoSlideInterval = setInterval(() => {
        next();
    }, 3000); // Change slide every 3 seconds
}

function stopAutoSlide() {
    clearInterval(autoSlideInterval);
}

// Pause auto sliding when mouse is over any slide
slides.forEach(slide => {
    slide.addEventListener('mouseover', stopAutoSlide);
    slide.addEventListener('mouseout', startAutoSlide);
});

// Start auto slide initially
startAutoSlide();