let carts = document.querySelectorAll(".add-cart");

let products = [{
        name: "Variety Box",
        tag: "variety_box",
        price: 65,
        inCart: 0,
    },
    {
        name: "Rizo BBQ",
        tag: "rizo",
        price: 30,
        inCart: 0,
    },
    {
        name: "Twister Box",
        tag: "twister1",
        price: 80,
        inCart: 0,
    },
    {
        name: "Bucket Box",
        tag: "bucket",
        price: 115,
        inCart: 0,
    },
];

for (let i = 0; i < carts.length; i++) {
    carts[i].addEventListener("click", () => {
        cartNumbers(products[i]);
        totalCost(products[i]);
    });
}

function onLoadCartNumbers() {
    let productNumbers = localStorage.getItem("cartNumbers");

    if (productNumbers) {
        document.querySelector(".navbar-nav span").textContent = productNumbers;
    }
}

function cartNumbers(product) {
    let productNumbers = localStorage.getItem("cartNumbers");
    productNumbers = parseInt(productNumbers);
    if (productNumbers) {
        localStorage.setItem("cartNumbers", productNumbers + 1);
        document.querySelector(".navbar-nav span").textContent = productNumbers + 1;
    } else {
        localStorage.setItem("cartNumbers", 1);
        document.querySelector(".navbar-nav span").textContent = 1;
    }
    setItems(product);
}

function setItems(product) {
    let cartItems = localStorage.getItem("productsInCart");
    cartItems = JSON.parse(cartItems);
    if (cartItems != null) {
        if (cartItems[product.tag] == undefined) {
            cartItems = {
                ...cartItems,
                [product.tag]: product,
            };
        }
        cartItems[product.tag].inCart += 1;
    } else {
        product.inCart = 1;
        cartItems = {
            [product.tag]: product,
        };
    }

    localStorage.setItem("productsInCart", JSON.stringify(cartItems));
}

function totalCost(product) {
    //console.log("the product price is ", product.price);
    let cartCost = localStorage.getItem("totalCost");

    if (cartCost != null) {
        cartCost = parseInt(cartCost);
        localStorage.setItem("totalCost", cartCost + product.price);
    } else {
        localStorage.setItem("totalCost", product.price);
    }
}

function displayCart() {
    let cartItems = localStorage.getItem("productsInCart");
    cartItems = JSON.parse(cartItems);
    let productContainer = document.querySelector(".products");
    let cartCost = localStorage.getItem("totalCost");
    if (cartItems && productContainer) {
        productContainer.innerHTML = "";
        Object.values(cartItems).map((item) => {
            productContainer.innerHTML += `
            <div class="product">
                <ion-icon name="close-circle"></ion-icon>
                <img src="../images/${item.tag}.png">
                <span>${item.name}</span>
            </div>
            <div class="price">${item.price},00L.E</div>
            <div class="quantity">
                <span>${item.inCart}</span>
            </div>
            <div class="total">
                ${item.inCart * item.price},00L.E
            </div>
            `;
        });
        productContainer.innerHTML += `
            <div class="basketTotalContainer">
                <h4 class="basketTotalTitle>'Total'</h4>
                <h4 class="basketTotal>${cartCost},00L.E</h4>
            </div>
            <div class="checkoutbtn">
                <button id="checkbtn" type="submit">
                    Checkout
                </button>
            </div>
            `;
    }
}
onLoadCartNumbers();
displayCart();

$("#checkbtn").click(function() {
    var dataTobeSent = JSON.stringify({
        RestaurantID: $("#Fname").val(),
        UserID: localStorage.getItem("UserID"),
        OrderPrice: $(".basketTotal").val(),
        StatusID: "1",
        CreationDate: Date(),
        ModifiedDate: "",
        isDeleted: 0,
        adminID: "",
        Fees: 20,
    });
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "https://localhost:44350/api/User/CreateOrder",
        data: dataTobeSent,
        contentType: "application/x-www-form-urlencoded",
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
        },
        crossDomain: true,
        success: function() {
            alert("thanks for Ordering from us");
        },
        error: function(error) {
            alert("try again later");
            return false;
        },
    });
});