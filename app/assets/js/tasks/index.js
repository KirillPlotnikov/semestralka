
$(document).on('turbolinks:load', function(){
    let selectedCountry = '';
    let tags_ids = [];

    $('body').on('click', '#filter-div-trigger' ,function(e){
        e.preventDefault();
        if ($('.filtering-div').css('display') == 'none'){
            $('.filtering-div').slideDown();
        } else{
            $('.filtering-div').slideUp();
        }
    });

    $("select.categories_list").change(function(){
        selectedCountry = $(this).children("option:selected").val();
    });

    $('body').on('click', '#apply-button' , function(){
        tags_ids = $(".tags-selection input:checkbox:checked").map(function(){
            return $(this).val();
        }).get();

        if(selectedCountry != '' && tags_ids.length === 0){
            window.location.replace("http://localhost:3000/tasks/by-category/" + selectedCountry);
        } else if(selectedCountry === '' && tags_ids.length != 0){
            window.location.replace("http://localhost:3000/tasks/by-tags/" + tags_ids.join("+"));
        } else if(selectedCountry != '' && tags_ids.length != 0){
            window.location.replace("http://localhost:3000/tasks/by-category/" + selectedCountry + "/by-tags/" + tags_ids.join("+"));
        }
    });
});

