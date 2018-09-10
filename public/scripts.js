if (!library) {
  var library = {};
}

library.json = {
  replacer: function(match, pIndent, pKey, pVal, pEnd) {
    var key = '<span class=json-key>';
    var val = '<span class=json-value>';
    var str = '<span class=json-string>';
    var r = pIndent || '';
    if (pKey) {
      r = r + key + pKey.replace(/[": ]/g, '') + '</span>: ';
    }
    if (pVal) {
      r = r + (pVal[0] == '"' ? str : val) + pVal + '</span>';
    }
    return r + (pEnd || '');
  },
  prettyPrint: function(obj) {
    var jsonLine = /^( *)("[\w]+": )?("[^"]*"|[\w.+-]*)?([,[{])?$/mg;
    return JSON.stringify(JSON.parse(obj), null, 3)
      .replace(/&/g, '&amp;').replace(/\\"/g, '&quot;')
      .replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(jsonLine, library.json.replacer);
  }
};

var response_block = document.querySelector("#response")
var body_block = response_block.querySelector("pre.body")
var status_block = response_block.querySelector("pre.status")
var get_shops_form = document.querySelector("#get_shops")
var post_sold_form = document.forms.sold_request

function change_class(status) {
  response_block.classList.remove("hidden")
  status_block.className = ""
  var status = parseInt(status, 10)
  if (status > 199 && status < 300) {
    status_block.classList.add("success")
  } else if (status > 399) {
    status_block.classList.add("failed")
  } else {
    return false
  }
}

get_shops_form.addEventListener('submit', function(event) {
  event.preventDefault();
  var publisher_id = get_shops_form.querySelector('input[name="publisher_id"]').value
  var xhr = new XMLHttpRequest();
  xhr.open("GET", "/api/v1/stock/for_publisher/" + publisher_id, true);
  xhr.onload = function (){
    change_class(xhr.status)
    status_block.innerHTML = xhr.status + " " + xhr.statusText;
    body_block.innerHTML = library.json.prettyPrint(xhr.responseText);
  }
  xhr.send(null);
});

post_sold_form.addEventListener('submit', function(event) {
  event.preventDefault();
  var shop_id = parseInt(post_sold_form.querySelector('input[name="shop_id"]').value, 10)
  var book_id = parseInt(post_sold_form.querySelector('input[name="book_id"]').value, 10)
  var amount = parseInt(post_sold_form.querySelector('input[name="amount"]').value, 10)
  var formData= { shop_id, book_id, amount }
  var xhr = new XMLHttpRequest();
  var json = JSON.stringify(formData);
  xhr.open("POST", "/api/v1/stock/sold", true);
  xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
  xhr.onload = function (){
    change_class(xhr.status)
    status_block.innerHTML = xhr.status + " " + xhr.statusText;
    body_block.innerHTML = library.json.prettyPrint(xhr.responseText);
  }
  xhr.send(json);
});
