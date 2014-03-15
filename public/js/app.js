var checked_status = true;
$('#checkbox-control').on('click', function() {
  $(':checkbox').each (function() {
    $(this).prop("checked", !checked_status);
  });
  checked_status = !checked_status;
  checked_status ? $(this).text("Uncheck All") : $(this).text("Check All");
});
