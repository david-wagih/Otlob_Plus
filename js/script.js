let usernames = localStorage.getItem("UserName");
const test = document.getElementById("welcomemsg");
const test1 = document.getElementById("username");
const test2 = document.getElementById("login");
const test3 = document.getElementById("signup");
document.getElementById("username").innerText =
    localStorage.getItem("UserName");

if (usernames == null) {
    test.style.display = "none";
    test1.style.display = "none";
} else {
    test.style.display = "visible";
    test1.style.display = "visible";
    test2.style.display = "none";
    test3.style.display = "none";
}