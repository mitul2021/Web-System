'use strict';

function attach(id, handler)
{
    let el = document.getElementById(id);
    if(el)
        el.addEventListener("click",handler);  
}

function show_next() 
{
    let container = document.getElementById("dropdowns");
    let dropdown = container.firstElementChild;

    //gets first hidden element
    while(dropdown.nextElementSibling!=null && !dropdown.hasAttribute("hidden")) //while dropdowns are shown move to the next one
    {
        dropdown = dropdown.nextElementSibling;
    }
    dropdown.removeAttribute("hidden");

}

function hide_next()
{
    let container = document.getElementById("dropdowns");
    let dropdown = container.firstElementChild;

    //gets last visible element
    while(dropdown.nextElementSibling!=null && !dropdown.nextElementSibling.hasAttribute("hidden"))
    {
        dropdown = dropdown.nextElementSibling;
    }

    //sets dropdown option to none
    for(let option of dropdown.options)
    {
        if (option.value === 'none') 
        {
          option.selected = true;
          break;
        }
    }

    //hides the dropdown list
    dropdown.setAttribute("hidden","");


}

attach('btn_show',show_next);
attach('btn_hide',hide_next);


