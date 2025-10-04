const iconRender = ({ title, icon, onclick }) => {
  return `<a href="javascript:;" 
    class="blue"
    data-toggle="tooltip"
    data-original-title="${title}"
    onclick="${onclick}"
    >
      <i class="${icon}"></i>
    </a>`;
};

const optionRender = ({ title, icon, onclick }) => {
  return `
    <a href="javascript:;" class="dropdown-item" onclick="${onclick}">
      <i class="${icon} mr-1"></i>${title}
    </a>          
  `;
};


const renderLoading = (state) => {
  $("#loading").prop("style", `display: ${state ? "flex" : "none"}`);
};

const renderTable = (data = []) =>
  datatableHelper("list", "Lista de Transacciones", {
    deferRender: true,
    idDataTables: "1",
    data,
    columns: [
      { data: "invoice", className: "text-center" },
      { data: "billing" },
      {
        data: "date_issue",
        render: function (data, type, full, meta) {
          return moment(data).format("DD/MM/YYYY");
        },
      },
      {
        data: "expiration_date",
        render: function (data, type, full, meta) {
          return moment(data).format("DD/MM/YYYY");
        },
      },
      {
        data: "compromise_date",
        render: function (data) {
          if (!data) return "NO TIENE";
          return moment(data).format("DD/MM/YYYY");
        },
      },
      {
        data: "total",
        render: function (data, type, full) {
          const currencySymbol = full.currency_symbol || 'S/.';  
          return `${currencySymbol} ${formatMoney(data)}`;
        }
      },
      {
        data: "balance",
        render: function (data, type, full) {
          const currencySymbol = full.currency_symbol || 'S/.';  
          return `${currencySymbol} ${formatMoney(data)}`;
        }
      },
      { data: "payment_date" },
      { data: "waytopay" },
      { data: "observation", visible: false },
      {
        data: "state",
        render: function (data) {
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
      {
        data: "encrypt",
        className: "text-center",
        aWidth: "40px",
        render(data, type, full) {
          const options = {
            options: {
              title: "Opciones",
              icon: "far fa-sun",
              onclick: `print_options('${data}')`,
            },
            email: {
              title: "Email",
              icon: "fa fa-share-square",
              onclick: `onSendMail('${data}', '${full.encrypt_client}', '${full.count_state}')`,
            },
          };
          const config = iconRender(options.options);
          const email = iconRender(options.email);
          const configDown = optionRender(options.options);
          const emailDown = optionRender(options.email);

          return `
            <div class="hidden-sm hidden-xs action-buttons">
              ${config}
              ${email}
            </div>
            <div class="hidden-md hidden-lg"><div class="dropdown">
              <button class="btn btn-white btn-sm" data-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-ellipsis-v"></i>
              </button>
              <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 29px, 0px);">
                ${configDown}
                ${emailDown}
              </div>
              </div>
            </div>
            `;
        },
      },
    ],
  });


function onValue() {
  document.getElementById("fvalue").addEventListener("keyup", () => {
    const value = $("#fvalue").val() || "";
    const isDisabled = value?.length >= 8 ? false : true;
    $("#btn").prop("disabled", isDisabled);
  });
}

function onSearch() {
  document.getElementById("consulta").addEventListener("submit", (e) => {
    e.preventDefault();
    renderLoading(true);
    $("#result").prop("style", "display: none");
    const value = $("#fvalue").val();
    const type = $("#ftype").val();
    
    axios
      .get(`${base_url}/consultas/list_bills?type=${type}&value=${value}`)
      .then(({ data }) => {
        if (!data.success) throw new Error(data.message);
        
        const result = data.data;
        const currencySymbol = data.currency_symbol || 'S/. ';  // Símbolo de la moneda
        const totalDebt = data.deuda_total || 0;  // Deuda total
        const showDeudaTotal = data.show_deuda_total || false;  // Verificar si mostrar deuda

        // Mostrar el mensaje de "Felicidades no tienes deudas" o la deuda total
        if (showDeudaTotal && totalDebt > 0) {
          document.getElementById("text-deuda").innerText = `DEUDA TOTAL: ${currencySymbol}${formatMoney(totalDebt)}`;
          document.getElementById("text-deuda").style.color = 'red'; // Cambia el color a rojo si hay deuda
          
          // Mostrar los medios de pago si hay deuda
          document.getElementById("text-result2").style.display = 'block';
          document.getElementById("text-result3").style.display = 'block';
          document.getElementById("text-result4").style.display = 'block';
        } else {
          // Si no hay deuda, mostrar el mensaje de felicitación y hacerlo verde
          document.getElementById("text-deuda").innerText = '"Felicidades, no tienes deudas."';
          document.getElementById("text-deuda").style.color = 'green'; // Cambia el color a verde si no hay deuda

          // Ocultar los medios de pago si no hay deuda
          document.getElementById("text-result2").style.display = 'none';
          document.getElementById("text-result3").style.display = 'none';
          document.getElementById("text-result4").style.display = 'none';
        }

        // Mostrar los resultados
        $("#result").prop("style", "display: block");
        const message = `Resultados de: ${data.client.cliente} (${data.client.document || 'sin documento'})`;
        document.getElementById("text-result").innerText = message;


        renderTable(result).render();
      })
      .catch((err) => {
        alert_msg("error", err.message);
        $("#result").prop("style", "display: none");
      })
      .finally(() => renderLoading(false));
  });
}





function print_options(billId) {
  $('[data-toggle="tooltip"]').tooltip("hide");
  axios
    .get(`${base_url}/customers/view_bill/${billId}`)
    .then(({ data }) => {
      if (data.status != "success") {
        throw new Error("Error al obtener los datos.");
      }
      $("#modal-voucher").modal("show");
      const info = data.data;
      document.querySelector(
        "#text-title-voucher"
      ).innerHTML = `${info.bill.voucher} Nº ${info.bill.correlative}`;
      document.querySelector("#idbillvoucher").value = info.bill.encrypt_bill;
      document.querySelector(
        "#text_country"
      ).innerHTML = `+ ${info.business.country_code}`;
      document.querySelector("#country_code").value =
        info.business.country_code;
      document.querySelector("#bill_number_client").value = info.bill.mobile;
      const url = `${base_url}/invoice/document/${info.bill.encrypt_bill}`;
      const remaining_amount = parseFloat(info.bill.remaining_amount);
      let msg = "";
      if (remaining_amount == 0) {
        if (info.bill.type == 1) {
          msg = `Hola, se registro ${info.business.symbol} ${
            info.bill.amount_paid
          } al ${info.bill.voucher.toLowerCase()} número ${
            info.bill.serie
          } del cliente ${
            info.bill.client
          }. Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. ${
            info.business.business_name
          }`;
        } else {
          var dateAr = info.bill.billed_month.split("-");
          var month = dateAr[1];
          msg = `Estimado cliente *${info.bill.client}*, se registro *${info.business.symbol} ${formatMoney(info.bill.amount_paid)}* al ${info.bill.voucher.toLowerCase()} número *${info.bill.serie} de ${month_letters(month).toUpperCase()}*, Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. *${info.business.business_name}*`;
        }
      } else {
        if (info.bill.type == 1) {
          if (info.bill.amount_paid == 0) {
            msg = `Hola, esta pendiente el pago de ${info.business.symbol} ${
              info.bill.remaining_amount
            } del ${info.bill.voucher.toLowerCase()} número ${
              info.bill.serie
            } del cliente ${
              info.bill.client
            }. Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. ${
              info.business.business_name
            }`;
          } else {
            msg = `Hola, se registro
              ${info.business.symbol} ${
              info.bill.amount_paid
            } al ${info.bill.voucher.toLowerCase()} número ${
              info.bill.serie
            }, quedando un saldo pendiente de ${info.business.symbol} 
              ${formatMoney(info.bill.remaining_amount)} del cliente ${
              info.bill.client
            }. Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. ${
              info.business.business_name
            }`;
          }
        } else {
          var dateAr = info.bill.billed_month.split("-");
          var month = dateAr[1];
          if (info.bill.amount_paid == 0) {
            msg = `Estimado cliente *${
              info.bill.client
            }*, esta pendiente el pago de *${info.business.symbol
            } ${formatMoney(
              info.bill.remaining_amount
            )}* del ${info.bill.voucher.toLowerCase()} número *${ info.bill.serie
            } de ${month_letters(
              month
            ).toUpperCase()}.* Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. *${info.business.business_name}*`;
          } else {
            msg = `Hola, se registro ${info.business.symbol} ${formatMoney(
              info.bill.amount_paid
            )} al ${info.bill.voucher.toLowerCase()} número ${
              info.bill.serie
            } de ${month_letters(
              month
            ).toUpperCase()}, quedando un saldo pendiente de ${
              info.business.symbol
            } ${formatMoney(info.bill.remaining_amount)} del cliente ${
              info.bill.client
            }. Puede revisarlo en el siguiente enlace: ${url}. Muchas gracias por su pago, Atte. ${info.business.business_name}`;
          }
        }
      }
      document.querySelector("#msg").value = msg;
    })
    .catch((err) => alert_msg("error", err.message));
}

function onSendWhatsapp() {
  $("#btn-msg").on("click", function () {
    const country = document.querySelector("#country_code").value;
    const phone = document.querySelector("#bill_number_client").value;
    const numberPhone = `${country}${phone}`;
    const message = document.querySelector("#msg").value;
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
  });
}

function onSendMail(idbill, idclient, type) {
  $('[data-toggle="tooltip"]').tooltip("hide");
  loading.style.display = "flex";
  axios
    .get(`${base_url}/customers/send_email/${idbill}/${idclient}/${type}`)
    .then(({ data }) => {
      if (data.status === "error") {
        throw new Error(data.msg);
      } else if (data.status === "success") {
        alert_msg("success", data.msg);
      } else {
        alert_msg("info", data.msg);
      }
    })
    .catch((err) => {
      alert_msg("error", err.message);
    })
    .finally(() => {
      loading.style.display = "none";
    });
}

function onPrintTicket() {
  $("#btn-print_ticket").on("click", function () {
    var idbill = document.querySelector("#idbillvoucher").value;
    window.open(`${base_url}/customers/print_voucher/${idbill}`, "_blank");
  });
}

function onTicket() {
  $("#btn-ticket").on("click", function () {
    var idbill = document.querySelector("#idbillvoucher").value;
    window.open(
      `${base_url}/customers/bill_voucher/${idbill}/ticket`,
      "_blank"
    );
  });
}

function onA4() {
  $("#btn-a4").on("click", function () {
    var idbill = document.querySelector("#idbillvoucher").value;
    window.open(`${base_url}/customers/bill_voucher/${idbill}/a4"`, "_blank");
  });
}

document.addEventListener("DOMContentLoaded", () => {
  onSearch();
  onValue();
  onSendWhatsapp();
  onPrintTicket();
  onTicket();
  onA4();
});