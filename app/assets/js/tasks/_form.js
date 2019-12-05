$(document).on('turbolinks:load', function(){
    $('#custom_deadline_at').change(
        function(){
            if (this.checked) {
                $('.task_deadline_at').css('display', 'block');
            } else{
                $('.task_deadline_at').css('display', 'none');
            }
        });


});


