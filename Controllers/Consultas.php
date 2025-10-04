<?php

class Consultas extends Controllers {
  public function __construct() {
    parent::__construct();
    session_start();
  }

  public function consultas() {
    $data['page_name'] = "AP Clientes";
    $data['page_title'] = "AP Clientes";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Gestión de Red";
    $data['actual_page'] = "AP Clientes";
    $data['page_functions_js'] = "ap_clientes.js";
    $_SESSION['businessData'] = $this->model->get_business();
    $this->views->getView($this, "consultas", $data);
  }

  public function list_bills() {
    $filters = $_GET;
    if (empty($filters['type'])) {
        return $this->json([
            "success" => false,
            "message" => "No se encontró el modo de búsqueda",
        ]);
    } 
    if (empty($filters['value'])) {
        return $this->json([
            "success" => false,
            "message" => "No se encontró el valor de búsqueda",
        ]);
    }

    try {
        // cliente
        $client = $this->model->find_client($filters);
        if (!$client) {
            return $this->json([
                "success" => false,
                "message" => "No se encontró al cliente!",
            ]);
        }

        // facturas
        $data = $this->model->list_bills($client['id']);
        if (!count($data)) {
            return $this->json([
                "success" => false,
                "message" => "No se encontraron pagos",
            ]);
        }

        // Calcular deuda total solo de las facturas pendientes o vencidas
        $deuda_total = 0;
        foreach ($data as $i => $item) {
            if ($item['state'] == 2 || $item['state'] == 3) {  // Si está pendiente o vencida
                $deuda_total += $item['remaining_amount'];  // Sumar la deuda pendiente o vencida
            }
        }

        // Verificar si la deuda total es mayor que 0
        $show_deuda_total = $deuda_total > 0 ? true : false;
        $mensaje_deuda = $deuda_total == 0 ? "¡Felicidades! No tienes deudas pendientes." : $_SESSION['businessData']['symbol'] . format_money($deuda_total);

        // Procesar y agregar los pagos a las facturas
        foreach ($data as $i => $item) {
            $payments = $this->model->invoice_paid($item['id']);
            $month_letter = "";
            if ($item['type'] == 2) {
                $months = months();
                $month =  date('n',strtotime($data[$i]['billed_month']));
                $year =  date('Y',strtotime($data[$i]['billed_month']));
                $month_letter = strtoupper($months[intval($month) - 1]) . "," . $year;
            }

            // Encrypt
            $item['encrypt'] = encrypt($item['id']);
            $item['encrypt_client'] = encrypt($item['clientid']);

            // Comprobante
            $correlative = str_pad($item['correlative'],7,"0", STR_PAD_LEFT);
            $item['invoice'] = $correlative;
            $item['billing'] = $month_letter;

            // Fecha de expiración
            $item['payment_date'] = empty($payments['payment_date']) ? "00/00/0000" : date("d/m/Y", strtotime($payments['payment_date']));
            $item['waytopay'] = empty($payments['payment_type']) ? "" : $payments['payment_type'];

            // Total pro factura
            $item['count_total'] = $data[$i]['total'];
            $item['count_subtotal'] = empty($payments['amount_total']) ? format_money(0) : $payments['amount_total'];

            // Total pagado
            $item['total'] = $_SESSION['businessData']['symbol'].format_money($item['total']);
            $item['balance'] = $_SESSION['businessData']['symbol'].format_money($item['remaining_amount']);
            $item['subtotal'] = $_SESSION['businessData']['symbol'].format_money($item['subtotal']);
            $item['discount'] = $_SESSION['businessData']['symbol'].format_money($item['discount']);

            // Estados de factura
            if ($item['state'] == 1) {
                $item['count_state'] = "PAGADO";
            } else if ($item['state'] == 2) {
                $item['count_state'] = "PENDIENTE";
            } else if ($item['state'] == 3) {
                $item['count_state'] = "VENCIDO";
            } else if ($item['state'] == 4) {
                $item['count_state'] = 'ANULADO';
            }

            // Add the updated item to the data array
            $data[$i] = $item;
        }

        // Ordenar las facturas por la fecha de emisión (de más reciente a más antiguo)
        usort($data, function ($a, $b) {
            // Asegúrate de que el campo `billed_month` esté bien formateado
            $dateA = strtotime($a['billed_month']); 
            $dateB = strtotime($b['billed_month']);
            
            return $dateB - $dateA;  // Orden descendente (más reciente primero)
        });

        // Habilitar sesión
        $_SESSION['consulta'] = true;
        $_SESSION['permits_module']['v'] = 1;

        // Response con los datos actualizados y la información de deuda total
        return $this->json([
            "success" => true,
            "message" => "Boletas encontradas",
            "client" => $client,
            "data" => $data,
            "deuda_total" => $deuda_total,
            "show_deuda_total" => $show_deuda_total,  // Informar si mostrar deuda total
            "mensaje_deuda" => $mensaje_deuda, // Enviar el mensaje de deuda
            "currency_symbol" => $_SESSION['businessData']['symbol'],  // Símbolo de la moneda
        ]);
    } catch (\Throwable $th) {
        return $this->json([
            "success" => false,
            "message" => "Algo salió mal",
            "err" => $th->getMessage()
        ]);
    }
}
}



