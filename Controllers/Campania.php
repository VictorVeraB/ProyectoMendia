<?php

class Campania extends Controllers {
  public function __construct() {
    parent::__construct();
    session_start();
    if (empty($_SESSION["login"])) {
      header('Location: '.base_url().'/login');
			die();
    } else {
      consent_permission(RED);
    }
  }

  public function whatsapp() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data['page_name'] = "WS Campaña";
    $data['page_title'] = "WS Campaña";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Campaña";
    $data['actual_page'] = "WS Campaña";
    $data['page_functions_js'] = "campania_whatsapp.js";
    $this->views->getView($this, "whatsapp", $data);
  }

  public function list_users_record() {
    if (empty($_SESSION['permits_module']['v'])) {
        header("Location:".base_url().'/dashboard');
    }
    $country_code = $_SESSION['businessData']['country_code'];
    $filters = [
        'state' => $_GET['state'] ?? null,
        'zona' => $_GET['zona'] ?? null, // Nuevo parámetro
    ];
    $data = $this->model->list_users_record($filters);
    foreach ($data as $key => $item) {
        $item['country_code'] = $country_code;
        $data[$key] = $item;
    }
    return $this->json($data);
}

}