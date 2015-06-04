$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 5, // set the maximum file size to 256 MB
    paramName: "post[avatar]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: true, // don't show remove links on dropzone itself.
    autoProcessQueue: false,
    parallelUploads: 10,
    acceptedFiles: "image/*",
    maxFiles: 10
  });
  dropzone.on("maxfilesreached", function(file){

    file.previewContainer.style.display="none";
  })
  dropzone.on("maxfilesexceeded", function(file){

    file.previewContainer.style.display="none";
  })
 
  $('#imgsubbutt').click(function(){           
     dropzone.processQueue();
  });
  dropzone.on("processing", function() {
    this.options.autoProcessQueue = true;
  });
  dropzone.on("queuecomplete", function() {
    this.options.autoProcessQueue = false;
    this.removeAllFiles();
    document.getElementById('userPage').click();
  });
  
});
