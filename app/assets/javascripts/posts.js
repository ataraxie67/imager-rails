$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 5, // set the maximum file size to 256 MB
    paramName: "post[avatar]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: true, // don't show remove links on dropzone itself.
    autoProcessQueue: false,
    parallelUploads: 10,
    acceptedFiles: "image/*"
  });

  dropzone.on("success", function(file) {
    
    $.getScript("/posts");
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
  });
});
