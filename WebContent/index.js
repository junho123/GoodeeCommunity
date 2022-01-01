const helpIcon = document.querySelector('.helpIcon');

helpIcon.addEventListener('click',function(e){
//helpContent.classList.toggle("hidden");
$('.helpIcon__content').fadeToggle(200);
});