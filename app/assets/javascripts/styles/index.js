const initStyles = () => {
  let actionItems = document.querySelectorAll(".action_item a")
  if(actionItems.length == 1){
    document.querySelectorAll(".action_item a")[0].innerHTML="New"
  }else if(actionItems.length == 2){
    document.querySelectorAll(".action_item a")[0].innerHTML="Edit"
    document.querySelectorAll(".action_item a")[1].innerHTML="Delete"
  }
  if (window.location.pathname == "/admin/login") {
    document.querySelector("#active_admin_content").classList.add('login-bg')
  }
  console.log("Styles loaded")
}