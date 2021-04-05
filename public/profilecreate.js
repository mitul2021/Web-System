'use strict';

function attach(id, handler)
{
    let el = document.getElementById(id);
    if(el)
        el.addEventListener("click",handler);  
}

function read_data()
{
    let container = document.getElementById("dropdowns");
    let dropdown = container.firstElementChild;
  
    //for the first one 
    if(dropdown!=null) update_set(dropdown);
    //iterate over all visible dropdown lists
    while(dropdown.nextElementSibling!=null && !dropdown.nextElementSibling.hasAttribute("hidden"))
    {
        dropdown = dropdown.nextElementSibling; //move to the next visible dropdown list
        //getting value of the selected item in the drop down list
        update_set(dropdown);
    }
    console.log(interests_ids);
}
function update_set(dropdown) //helper
{
    let val = dropdown.options[dropdown.selectedIndex].value;
    interests_ids.add(val); //adding the value to the set
}

function get_last_visible_dropdown() //helper
{
    let container = document.getElementById("dropdowns");
    let dropdown = container.firstElementChild;
  
    //gets last visible element
    while(dropdown.nextElementSibling!=null && !dropdown.nextElementSibling.hasAttribute("hidden"))
    {
        dropdown = dropdown.nextElementSibling;
    }
    return dropdown;
  
}
function get_first_hidden_element() //helper
{
    let container = document.getElementById("dropdowns");
    let dropdown = container.firstElementChild;

    //gets first hidden element
    while(dropdown.nextElementSibling!=null && !dropdown.hasAttribute("hidden")) //while dropdowns are shown move to the next one
    {
        dropdown = dropdown.nextElementSibling;
    }
    return dropdown;
}

function show_next() //attached to button
{
    let dropdown = get_first_hidden_element();
    dropdown.removeAttribute("hidden");
    read_data();

}

function hide_next() //attached to button
{
    let dropdown = get_last_visible_dropdown()
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
    read_data();
}


function update_dropdowns()
{
  
}
attach('btn_show',show_next);
attach('btn_hide',hide_next);

//initial setup
let interests_ids = new Set(); // array that will store interests_ids picked by user
read_data();



