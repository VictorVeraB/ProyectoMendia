let table_pending;
let table_name_pending = "list-bills-pendings";
let bills = [];
let number_client = document.querySelector("#massive_bill_number_client");
$(document).on("click", "body", function (e) {
  document.querySelector(".search-input").classList.remove("active");
  document.querySelector("#box-search").innerHTML = "";
  $("#date_compromiso")
    .datetimepicker({ locale: "es" })
    .on("dp.change", function () {
      $("#btn_pay").prop("disabled", false);
    });
});
number_client.onpaste = function (event) {
  var str = event.clipboardData.getData("text/plain");
  matches = str.match(/\d+/g);
  var v1, v2, v3, v4;
  if (!matches[0]) {
    v1 = "";
  } else {
    if (matches[0] == "51") {
      v1 = "";
    } else {
      v1 = matches[0];
    }
  }
  if (!matches[1]) {
    v2 = "";
  } else {
    v2 = matches[1];
  }
  if (!matches[2]) {
    v3 = "";
  } else {
    v3 = matches[2];
  }
  if (!matches[3]) {
    v4 = "";
  } else {
    v4 = matches[3];
  }
  var values = v1 + v2 + v3 + v4;
  $(this).val(values);
  event.preventDefault();
};

function massive_runway() {
  if (document.querySelector("#typepay")) {
    var ajaxUrl = base_url + "/runway/list_runway";
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#typepay").innerHTML = request.responseText;
        $("#typepay").select2();
      }
    };
  }
}
$("#search_client").keyup(function () {
  let search = $(this).val();
  if (search.length > 0) {
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    var ajaxUrl = base_url + "/payments/search_clients";
    var strData = "search=" + search;
    request.open("POST", ajaxUrl, true);
    request.setRequestHeader(
      "Content-type",
      "application/x-www-form-urlencoded"
    );
    request.send(strData);
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector(".search-input").classList.add("active");
        document.querySelector("#box-search").innerHTML = request.responseText;
      }
    };
  } else {
    document.querySelector(".search-input").classList.remove("active");
    document.querySelector("#box-search").innerHTML = "";
  }
});

function pending_invoices(idclient) {
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/payments/pending_invoices/" + idclient;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var objData = JSON.parse(request.responseText);
      if (objData.status == "success") {
        document.querySelector(".search-input").classList.remove("active");
        document.querySelector("#box-search").innerHTML = "";
        document.querySelector("#search_client").value = "";
        $("#pending_invoices").slideUp().html(objData.data.views).slideDown();
        massive_runway();
        table_pendings(objData.data.client.id);
        $("#date_time_mass").datetimepicker({ locale: "es" });
        $("#date_time_mass").val(moment().format("DD/MM/YYYY H:mm"));
        document
          .querySelector("#transactions")
          .addEventListener("submit", save_payment, false);
      } else {
        alert_msg("error", objData.msg);
        $("#pending_invoices").slideUp().empty();
        document.querySelector(".search-input").classList.remove("active");
        document.querySelector("#box-search").innerHTML = "";
        document.querySelector("#search_client").value = "";
      }
    }
  };
}

function table_pendings(idclient) {
  table_configuration("#" + table_name_pending, "Facturas pendientes");
  table_pending = $("#" + table_name_pending)
    .DataTable({
      ajax: {
        url: " " + base_url + "/payments/list_pendings/" + idclient,
        dataSrc: "",
      },
      stripeClasses: ["stripe1", "stripe2"],
      deferRender: true,
      rowId: "id",
      columns: [
        { data: "invoice", className: "text-center" },
        { data: "billing" },
        {
          data: "balance",
          render: function (data, type, full, meta) {
            return (state =
              '<span class="text-danger f-w-700">' + data + "</span>");
          },
          className: "text-center",
        },
        { data: "total", className: "text-center" },
        {
          data: "date_issue",
          render: function (data, type, full, meta) {
            return moment(data).format("DD/MM/YYYY");
          },
          className: "text-center",
        },
        {
          data: "expiration_date",
          render: function (data, type, full, meta) {
            return moment(data).format("DD/MM/YYYY");
          },
          className: "text-center",
        },
        {
          data: "compromise_date",
          render: function (data) {
            if (!data) return "NO TIENE";
            return moment(data).format("DD/MM/YYYY");
          },
          className: "text-center",
        },
        {
          data: "state",
          render: function (data, type, full, meta) {
            var state = "";
            if (data == 1) {
              state = '<span class="label label-success">PAGADO</span>';
            }
            if (data == 2) {
              state = '<span class="label label-warning">PENDIENTE</span>';
            }
            if (data == 3) {
              state = '<span class="label label-danger">VENCIDO</span>';
            }
            if (data == 4) {
              state = '<span class="label label-dark">ANULADO</span>';
            }
            return state;
          },
          className: "text-center",
        },
      ],
      initComplete: function (oSettings, json) {
        $("#" + table_name_pending + "_wrapper .dt-buttons").append(
          $("#" + table_name_pending + "-btns-exportable").contents()
        );
      },
    })
    .on("processing.dt", function (e, settings, processing) {
      if (processing) {
        loaderin(".panel-bills-pendings");
      } else {
        loaderout(".panel-bills-pendings");
      }
    })
    .on("draw", function () {});
}

function save_payment(e) {
  e.preventDefault();
  let total = parseInt(document.querySelector("#total_pay").value);
  if (total < 0) {
    alert_msg("error", "El monto a pagar debe ser mayor a 0");
    return false;
  }
  loading.style.display = "flex";
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/payments/mass_payments";
  var transactions = document.querySelector("#transactions");
  var formData = new FormData(transactions);
  formData.set("remaining_amount", formatDecimal($("#remaining_amount").val()));
  formData.set("total_pay", formatDecimal($("#total_pay").val()));
  formData.set("total_discount", formatDecimal($("#total_discount").val()));
  request.open("POST", ajaxUrl, true);
  request.send(formData);
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var objData = JSON.parse(request.responseText);
      if (objData.status == "success") {
        alert_msg("success", objData.msg);
        $("#pending_invoices").slideUp().empty();
        $("#modal-massive-voucher").modal("show");
        document.querySelector("#text-title-massive-voucher").innerHTML =
          "Opciones de impresión";
        document.querySelector("#massive_text_country").innerHTML =
          "+" + objData.country;
        document.querySelector("#massive_country_code").value = objData.country;
        document.querySelector("#massive_bill_number_client").value =
          objData.mobile;
        document.querySelector("#massive_client").value = objData.client;
        document.querySelector("#massive_current_paid").value =
          objData.current_paid;
        objData.bills.forEach((bill) => {
          bills.push(bill);
        });
      } else if (objData.status == "warning") {
        alert_msg("warning", objData.msg);
        $("#pending_invoices").slideUp().empty();
      } else {
        alert_msg("error", objData.msg);
        $("#pending_invoices").slideUp().empty();
      }
    }
    loading.style.display = "none";
    return false;
  };
}

function calcTotal() {
  const subtotal = parseFloat(formatDecimal($("#subtotal").val()));
  const amountPaid = parseFloat(formatDecimal($("#amount_paid").val()));
  const discount = parseFloat(formatDecimal($("#total_discount").val()));
  return subtotal - (amountPaid + discount);
}

function showCompromiso() {
  const btnPay = $("#btn_pay");
  const inputCompromiso = $("#date_compromiso");
  const contentCompromiso = $("#content_compromiso");
  const deuda = parseFloat(formatDecimal($("#remaining_amount").val()));
  const total = parseFloat(formatDecimal($("#total_pay").val()));
  if (deuda == total) {
    contentCompromiso.css("display", "none");
    btnPay.prop("disabled", false);
    inputCompromiso.val(undefined);
  } else {
    contentCompromiso.css("display", "block");
    const isDisabled = inputCompromiso.val() == "";
    btnPay.prop("disabled", isDisabled);
  }
}

function changeDiscount(evt) {
  const discountTotal = parseFloat(formatDecimal($("#discount").val()));
  const current = parseFloat(formatDecimal($("#total_discount").val()));
  const discount = discountTotal + current;
  const subtotal = parseFloat(formatDecimal($("#subtotal").val()));
  const amountPaid = parseFloat(formatDecimal($("#amount_paid").val()));
  const total = subtotal - (amountPaid + discount);
  if (total <= 0) {
    alert_msg("warning", "El descuento debe ser menor a la deuda");
    $("#total_discount").val(formatMoney(discount));
    $("#total_pay").val(formatMoney(calcTotal()));
    $("#remaining_amount").val(formatMoney(calcTotal()));
  } else {
    $("#remaining_amount").val(formatMoney(total));
    $("#total_pay").val(formatMoney(total));
    $("#total_discount").val(formatMoney(current));
  }
  // verificar
  showCompromiso();
}

function changePay(evt) {
  const inputPay = $("#total_pay");
  const inputDiscount = $("#total_discount");
  const deuda = parseFloat(formatDecimal($("#remaining_amount").val()));
  const current = parseFloat(formatDecimal(inputPay.val()));
  if (deuda < current) {
    alert_msg("warning", "El monto supera la deuda.");
    inputPay.val(formatMoney(deuda));
  } else if (current < 0) {
    alert_msg("error", "El monto no puede ser menor a cero");
    inputPay.val(formatMoney(deuda));
  } else if (current == 0) {
    inputPay.val(formatMoney(current));
    inputDiscount.val(formatMoney(0));
    inputDiscount.prop("disabled", true);
    showCompromiso();
  } else {
    showCompromiso();
    inputPay.val(formatMoney(current));
    inputDiscount.prop("disabled", false);
  }
}

/* FORMAS DE IMPRESION */
$("#btn-massive-ticket").on("click", function () {
  redirect_by_post(base_url + "/payments/massive_pdfs", bills, true);
});

$("#btn-massive-print_ticket").on("click", function () {
  redirect_by_post(base_url + "/payments/massive_impressions", bills, true);
});

function redirect_by_post(route, array, in_new_tab) {
  array = typeof array == "undefined" ? {} : array;
  in_new_tab = typeof in_new_tab == "undefined" ? true : in_new_tab;
  var form = document.createElement("form");
  $(form)
    .attr("id", "transactions")
    .attr("name", "transactions")
    .attr("action", route)
    .attr("method", "post")
    .attr("enctype", "multipart/form-data");
  if (in_new_tab) {
    $(form).attr("target", "_blank");
  }
  array.forEach((bill) => {
    $(form).append('<input type="text" name="ids[]" value="' + bill + '"/>');
  });
  document.body.appendChild(form);
  form.submit();
  document.body.removeChild(form);
  return false;
}

$(".btn-close").on("click", function () {
  bills = [];
});
/* MSJ whatsapp */
$("#btn-massive-msg").on("click", function () {
  let cell = document.querySelector("#massive_bill_number_client").value;
  if (cell !== "") {
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    var ajaxUrl = base_url + "/payments/massive_msj";
    var formData = new FormData();
    formData.append("ids", bills);
    request.open("POST", ajaxUrl, true);
    request.send(formData);
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        var objData = JSON.parse(request.responseText);
        if (objData.status == "success") {
          const country = document.querySelector("#massive_country_code").value;
          const phone = document.querySelector(
            "#massive_bill_number_client"
          ).value;
          const numberPhone = `${country}${phone}`;
          let client = document.querySelector("#massive_client").value;
          let current_paid = document.querySelector(
            "#massive_current_paid"
          ).value;
          // message
          const amount = `${
            objData.data.business.symbol + roundNumber(current_paid, 2)
          }`;
          // Construcción del mensaje principal
let message = `HOLA, *${client}*\n \n Se registró su pago de *${amount}*, al recibo de `;

// Iteración sobre las facturas para agregar los meses al mensaje
let monthsList = [];
objData.data.bills.forEach((months, index) => {
    if (months.type !== 1) {
        var dateAr = months.billed_month.split("-");
        var month = dateAr[1];
        // Agregar asteriscos al mes
        monthsList.push(`*${month_letters(month).toUpperCase()}*`);
    }
});

// Unir los meses con ", " y agregarlos al mensaje
message += monthsList.join(", ");

// Añadir mensaje de agradecimiento y firma
message += `. Muchas gracias por su pago.\n\n `;

// Texto para los enlaces
let linkText = objData.data.bills.length > 1 ? "Descargue sus recibos en los siguientes enlaces:\n" : "Descargue su recibo en el siguiente enlace:\n";
message += linkText;

// Iteración sobre las facturas para agregar los enlaces con saltos de línea y guiones
objData.data.bills.forEach((bill, index) => {
    var dateAr = bill.billed_month.split("-");
    var month = month_letters(dateAr[1]).toUpperCase(); // Obtiene el nombre del mes correspondiente al mes numérico
    var route = base_url + "/invoice/document/" + bill.encrypt_id;
    message += `- ${month} ${route}%0A\n`; // Agrega el nombre del mes antes de cada enlace
});
message += `\n*${
              objData.data.business.tradename
            }*`;
          // validar numero
          if (!phone) return alert_msg("info", "El número es obligatorio.");
          const wspApi = getWhatsappApi();
          if (wspApi) {
            sendMessageWhatsapp({ phone: numberPhone, message })
              .then(() => alert_msg("success", "Mensaje enviado"))
              .catch(() => alert_msg("error", "No se pudo enviar el mensaje"));
          } else {
            const url = `https://api.whatsapp.com/send/?phone=${numberPhone}&text=${message}`;
            window.open(url);
          }
        } else {
          alert_msg("error", objData.msg);
        }
      }
    };
  } else {
    alert_msg("info", "El número es obligatorio.");
  }
});

