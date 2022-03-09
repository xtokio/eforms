class Attachment
{
    static async upload(form_id)
    {
        $('input[type=file]').change(function(){

            $(this).simpleUpload("/upload/attachment/form/"+form_id, {
    
                start: function(file){
                    //upload started
                    console.log("upload started");
                },
    
                progress: function(progress){
                    //received progress
                    console.log("upload progress: " + Math.round(progress) + "%");
                },
    
                success: function(data){
                    //upload successful
                    console.log("upload successful!");
                    console.log(data);
                },
    
                error: function(error){
                    //upload failed
                    console.log("upload error: " + error.name + ": " + error.message);
                }
    
            });
    
        });
    }
}