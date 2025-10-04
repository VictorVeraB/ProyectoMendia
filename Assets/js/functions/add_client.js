function listeners() {
  document
    .getElementById("ap_cliente_id")
    .addEventListener("keyup", search_ap_cliente);
  document
    .getElementById("search_service")
    .addEventListener("keyup", search_service_event);
}

document.addEventListener(
  "DOMContentLoaded",
  function () {
    if (document.querySelector("#transactions")) {
      var transactions = document.querySelector("#transactions");
      transactions.onsubmit = function (e) {
        e.preventDefault();
        if ($("#transactions").parsley().isValid()) {
          loading.style.display = "flex";
          var request = window.XMLHttpRequest
            ? new XMLHttpRequest()
            : new ActiveXObject("Microsoft.XMLHTTP");
          var ajaxUrl = base_url + "/customers/register_contract";
          var formData = new FormData(transactions);
          request.open("POST", ajaxUrl, true);
          request.send(formData);
          request.onreadystatechange = function () {
            if (request.readyState == 4 && request.status == 200) {
              var objData = JSON.parse(request.responseText);
              if (objData.status == "success") {
                var alsup = $.confirm({
                  theme: "modern",
                  draggable: false,
                  closeIcon: false,
                  animationBounce: 2.5,
                  escapeKey: false,
                  type: "success",
                  icon: "far fa-check-circle",
                  title: "OPERACIÓN EXITOSA",
                  content: objData.msg,
                  buttons: {
                    Eliminar: {
                      text: "Aceptar",
                      btnClass: "btn-success",
                      action: function () {
                        $(location).attr(
                          "href",
                          base_url + "/customers/view_client/" + objData.id
                        );
                      },
                    },
                  },
                });
              } else if (objData.status == "exists") {
                alert_msg("warning", objData.msg);
              } else {
                alert_msg("error", objData.msg);
              }
            }
            loading.style.display = "none";
            return false;
          };
        }
      };
    }
  },
  false
);
window.addEventListener(
  "load",
  function () {
    form_wizard();
    list_technical();
    showDiscount();
    listeners();
    $("#insDate").datetimepicker({ locale: "es" });
    $("#insDate").val(moment().format("DD/MM/YYYY H:mm"));
    $("#transactions").parsley();
  },
  false
);
function form_wizard() {
  $("#wizard").smartWizard({
    selected: 0,
    theme: "default",
    transitionEffect: "",
    transitionSpeed: 0,
    useURLhash: false,
    lang: {
      next: "Siguiente",
      previous: "Anterior",
    },
    showStepURLhash: false,
    toolbarSettings: {
      toolbarPosition: "bottom",
      toolbarExtraButtons: [
        $("<button></button>")
          .html('<i class="fas fa-save mr-2"></i>Guardar Registro')
          .attr("type", "submit")
          .addClass("btn btn-blue btn-finish d-none"),
      ],
    },
  });
  $("#wizard").on(
    "leaveStep",
    function (e, anchorObject, stepNumber, stepDirection) {
      var res = $('form[name="transactions"]')
        .parsley()
        .validate("step-" + (stepNumber + 1));
      return res;
    }
  );

  $("#wizard").keypress(function (event) {
    if (event.which == 13) {
      $("#wizard").smartWizard("next");
    }
  });
  $("#wizard").on(
    "showStep",
    function (e, anchorObject, stepNumber, stepDirection) {
      $(".srvdire").val($(".drprin").val());
      if (stepNumber == 2) {
        $(".btn-finish").removeClass("d-none");
        $(".sw-btn-group").hide();
      } else {
        $(".btn-finish").addClass("d-none");
        $(".sw-btn-group").show();
      }
    }
  );
}
function list_technical() {
  if (document.querySelector("#listTechnical")) {
    var ajaxUrl = base_url + "/customers/list_technical";
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#listTechnical").innerHTML =
          request.responseText;
        $("#listTechnical").select2();
      }
    };
  }
}
$("#listPlan").on("click change", function () {
  type_plan($(this).val());
});
function type_plan(value) {
  switch (value) {
    case "1":
      $(".cont-day").show("fast");
      $(".cont-create").show("fast");
      $(".cont-gracia").show("fast");
      $(".cont-chk").show("fast");
      break;
    case "2":
      $(".cont-day").hide("fast");
      $(".cont-create").hide("fast");
      $(".cont-gracia").hide("fast");
      $(".cont-chk").hide("fast");
      check = document.querySelector("#chkDiscount");
      if (check.checked) {
        $(".cont-dis").hide("fast");
        $(".cont-month").hide("fast");
        check.checked = false;
      } else {
        $(".cont-dis").hide("fast");
        $(".cont-month").hide("fast");
      }
      break;
  }
}
function showDiscount() {
  check = document.querySelector("#chkDiscount");
  if (check.checked) {
    $(".cont-dis").show("fast");
    $(".cont-month").show("fast");
  } else {
    $(".cont-dis").hide("fast");
    $(".cont-month").hide("fast");
  }
}

function select_service(idservice) {
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/customers/select_service/" + idservice;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var objData = JSON.parse(request.responseText);
      if (objData.status) {
        document.querySelector("#search_service").value = "";
        document.querySelector(".search-input").classList.remove("active");
        document.querySelector("#box-search-service").innerHTML = "";
        document.querySelector("#idservice").value = objData.data.encrypt_id;
        document.querySelector("#service").value = objData.data.service;
        document.querySelector("#detail-service").value = objData.data.details;
        document.querySelector("#price-service").value = formatMoney(
          objData.data.price
        );
      } else {
        alert_msg("info", objData.msg);
      }
    }
  };
}

function search_document() {
  var type = document.querySelector("#listTypes").value;
  var doc = document.querySelector("#document").value;
  if (doc != "") {
    $(".btn-search").html('<i class="fa fa-spinner fa-sm fa-spin"></i>');
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    var ajaxUrl = base_url + "/customers/search_document/" + type + "/" + doc;
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        var objData = JSON.parse(request.responseText);
        if (objData.status == "success") {
          document.querySelector("#names").value = objData.data.names;
          document.querySelector("#surnames").value = objData.data.surnames;
          document.querySelector("#address").value = objData.data.address;
        } else if (objData.status == "info") {
          alert_msg("info", objData.msg);
          document.querySelector("#document").value = "";
          document.querySelector("#names").value = "";
          document.querySelector("#surnames").value = "";
          document.querySelector("#address").value = "";
        } else {
          alert_msg("error", objData.msg);
          document.querySelector("#document").value = "";
          document.querySelector("#names").value = "";
          document.querySelector("#surnames").value = "";
          document.querySelector("#address").value = "";
        }
      }
      $(".btn-search").html('<i class="fa fa-search"></i>');
      return false;
    };
  } else {
    if (type == 2) {
      alert_msg("error", "Ingrese el número de dni.");
    }
    if (type == 3) {
      alert_msg("error", "Ingrese el número de ruc.");
    }
  }
}

let loadingIp = { value: false };

function search_ip() {
  searchComponent("mobileOp", "ip", loadingIp)
    .then(
      ({
        input,
        value,
        renderNotFound,
        renderItem,
        clearBox,
        closeContainer,
        closeEvent,
      }) => {
        const url = `${base_url}/ips/list_records?querySearch=${value}&estado=LIBRE`;
        axios
          .get(url)
          .then(({ data }) => {
            if (!data.length) throw new Error();
            clearBox();
            data.forEach((ip) => {
              const item = renderItem(`IP: ${ip.id}`);
              item.onclick = function () {
                input.value = ip.id;
                closeContainer();
              };
            });
          })
          .catch(() => renderNotFound())
          .finally(() => closeEvent());
      }
    )
    .catch((err) => alert_msg("warning", err.message));
}

let loadingService = { value: false };

function search_service_event() {
  searchComponent("search_service", "service", loadingService)
    .then(({ value, renderNotFound, renderItem, clearBox, closeEvent }) => {
      const url = `${base_url}/customers/search_service?search=${value}`;
      axios
        .get(url)
        .then(({ data }) => {
          if (!data.length) throw new Error();
          clearBox();
          data.forEach((service) => {
            const item = renderItem(service.infoService);
            item.onclick = () => select_service(service.idEncrypt);
          });
        })
        .catch(() => renderNotFound())
        .finally(() => closeEvent());
    })
    .catch((err) => alert_msg("warning", err.message));
}

let loadingAp = { value: false };

function search_ap_cliente() {
  searchComponent("ap_cliente_id", "apcliente", loadingAp)
    .then(
      ({
        input,
        value,
        renderNotFound,
        renderItem,
        closeContainer,
        clearBox,
        closeEvent,
      }) => {
        const url = `${base_url}/apclientes/list_records?querySearch=${value}`;

        const actionItem = (input, item) => {
          input.value = item.nombre;
          $("#ap_cliente_value").val(item.id);
          closeContainer();
        };

        axios
          .get(url)
          .then(({ data }) => {
            if (!data.length) throw new Error();
            clearBox();
            data.forEach((ap) => {
              const item = renderItem(ap.nombre);
              item.id = `ap-${ap.id}`;
              item.onclick = () => actionItem(input, ap);
            });
          })
          .catch(() => renderNotFound())
          .finally(() => closeEvent());
      }
    )
    .catch((err) => alert_msg("warning", err.message));
}
