document.addEventListener("turbolinks:load", function() {
  $list = null;
  $po = 0;
  $first = true;
  $("#reset").click(function(){
    $("#content").val("");
      $list = null;
      $po = 0;
      $first = true;
      $("#key").html("");
      $("#identify").html("");
      $("#number").html("");
      $("#rel_op").html("");
      $("#cal_op").html("");
      $("#delimiter").html("");
      $("#string").html("");
      $("#unknow").html("");
  });
  $("#action").click(function(){
    content = $("#content").val();
    if($first){
      $list = content.split(/\s+/);
      $first = false;
    }

    $word = $list[$po];
    $.ajax({
      dataType: "json",
      url: "/home/word",
      data: {word: $word},
      success: function(data){
        console.log(data);
      if (data.key != null)
        $("#key").append(data.key + "  ");
      if (data.identify != null)
        $("#identify").append(data.identify + "  ");
      if (data.number != null)
        $("#number").append(data.number + "  ");
      if (data.rel_op != null)
        $("#rel_op").append(data.rel_op + "  ");
      if (data.cal_op != null)
        $("#cal_op").append(data.cal_op + "  ");
      if (data.delimiter != null)
        $("#delimiter").append(data.delimiter + "  ");
      if (data.string != null)
        $("#string").append(data.string + "  ");
      if (data.unknow != null)
        $("#unknow").append(data.unknow + "  ");
      }

    });

    $po++;
  });

    $("#action_all").click(function(){
        content = $("#content").val();
        if($first){
          $list = content.split(/\s+/);
          $first = false;
        }

        for(i = 0;i<$list.length;i++){
          $.ajax({
            dataType: "json",
            url: "/home/word",
            data: {word: $list[i]},
            success: function(data){
            if (data.key != null)
              $("#key").append(data.key + "  ");
            if (data.identify != null)
              $("#identify").append(data.identify + "  ");
            if (data.number != null)
              $("#number").append(data.number + "  ");
            if (data.rel_op != null)
              $("#rel_op").append(data.rel_op + "  ");
            if (data.cal_op != null)
              $("#cal_op").append(data.cal_op + "  ");
            if (data.delimiter != null)
              $("#delimiter").append(data.delimiter + "  ");
            if (data.string != null)
              $("#string").append(data.string + "  ");
            if (data.unknow != null)
                $("#unknow").append(data.unknow + "  ");
            }
          });
        }
    });
});


