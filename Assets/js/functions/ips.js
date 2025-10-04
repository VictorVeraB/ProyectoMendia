const btnAction = (title, className, icon, action) => {
  return `
    <a href="javascript:;" 
      class="ml-2 ${className}"
      data-toggle="tooltip"
      data-original-title="${title}"
      onclick="${action};"
    >
      <i class="${icon}"></i>
    </a>`;
};

const componentLoading = (status = false) => {
  if (status) loading.style.display = "flex";
  else loading.style.display = "none";
};

const tableList = () => {
  const id = `list`;
  table_configuration(`#${id}`, "Lista de IP's");
  return $(`#${id}`)
    .DataTable({
      ajax: {
        url: ` ${base_url}/ips/list_records`,
        dataSrc: "",
      },
      deferRender: true,
      idDataTables: "1",
      columns: [
        { data: "n", className: "text-center" },
        { data: "id" },
        { data: "grupo" },
        { data: "estado", className: "text-center" },
        {
          data: "id",
          className: "text-center",
          sWidth: "40px",
          render: (data, type, full) => {
            let optDelete = "";
            if (full.isRemove) {
              optDelete = btnAction(
                "Eliminar",
                "red",
                "far fa-trash-alt",
                `openRemove('${data}')`
              );
            }
            return `<div>${optDelete}</div>`;
          },
        },
      ],
      initComplete: function () {
        $(`#${id}_wrapper div.container-options`).append(
          $(`#${id}-btns-tools`).contents()
        );
      },
    })
    .on("processing.dt", function (e, settings, processing) {
      if (processing) {
        loaderin(".panel-runway");
      } else {
        loaderout(".panel-runway");
      }
    });
};

const openCreate = () => {
  document.querySelector("#text-title").innerHTML = "Nuevo Rango de IP's";
  document.querySelector("#text-button").innerHTML = "Guardar Registro";
  document.querySelector("#transactions").reset();
  $("#transactions").parsley().reset();
  $("#modal-action").modal("show");
  const component = document.getElementById("transactions");
  component.onsubmit = (e) => {
    e.preventDefault();
    create();
  };
};

const create = () => {
  const transactions = document.querySelector("#transactions");
  const isValid = $("#transactions").parsley().isValid();
  if (!isValid) return;
  loading.style.display = "flex";
  const formData = new FormData(transactions);
  fetch(`${base_url}/ips/save`, {
    method: "post",
    body: formData,
  })
    .then((dataJson) => dataJson.json())
    .then((data) => {
      if (!data.status) throw new Error(data.message);
      $("#modal-action").modal("hide");
      transactions.reset();
      alert_msg("success", data.message);
      tableList();
    })
    .catch((err) => alert_msg("error", err.message))
    .finally(() => (loading.style.display = "none"));
};

const openRemove = (id) => {
  const alsup = $.confirm({
    theme: "modern",
    draggable: false,
    closeIcon: true,
    animationBounce: 2.5,
    escapeKey: false,
    type: "info",
    icon: "far fa-question-circle",
    title: "ELIMINAR",
    content: "Esta seguro que desea eliminar este registro.",
    buttons: {
      remove: {
        text: "Aceptar",
        btnClass: "btn-info",
        action: function () {
          this.buttons.remove.setText(
            '<i class="fas fa-spinner fa-spin icodialog"></i> Procesando...'
          );
          this.buttons.remove.disable();
          componentLoading(true);
          remove(id)
            .then((data) => {
              alsup.close();
              tableList();
              $('[data-toggle="tooltip"]').tooltip("hide");
              alert_msg("success", data.message);
            })
            .catch((err) => {
              $('[data-toggle="tooltip"]').tooltip("hide");
              alert_msg("info", err.message);
            })
            .finally(() => {
              $(".jconfirm-closeIcon").remove();
              componentLoading();
            });
        },
      },
      close: {
        text: "Cancelar",
      },
    },
  });
};

const remove = (id) => {
  return new Promise((resolve, reject) => {
    fetch(`${base_url}/ips/remove_record/${id}`, {
      method: "post",
    })
      .then((dataJSON) => dataJSON.json())
      .then((data) => {
        if (!data.status) throw new Error(data.message);
        resolve(data);
      })
      .catch(reject);
  });
};

const changeIp = (event) => {
  const input = event.target;
  const rango = `${input.value}`.split(".").pop();
  $("#rango").val(rango);
};

// load functions
document.addEventListener("DOMContentLoaded", tableList, false);
window.addEventListener("load", () => $("#transactions").parsley(), false);
