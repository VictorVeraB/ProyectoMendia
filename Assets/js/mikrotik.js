function getMikrotikApi() {
  return $("#mikrotik_endpoint_value").val();
}

function getMikrotikToken() {
  return $("#mikrotik_token_value").val();
}

function generateMikrotikSelect() {
  const apiUrl = getMikrotikApi();
  const token = getMikrotikToken();
  return new Promise((resolve, reject) => {
    axios
      .get(`${apiUrl}/mikrotiks?page=1&limit=100`, {
        headers: {
          ["business-identify"]: token,
        },
      })
      .then(({ data }) => {
        const component = $("#mikrotik-select");
        component.empty();
        component.append('<option value="">Seleccionar</option>');
        data.items.forEach(function (item) {
          component.append(`<option value="${item.id}">${item.name}</option>`);
        });
        resolve(component);
      })
      .catch((err) => reject(err));
  });
}
