<?php

class Ips extends Controllers {
  public function __construct() {
    parent::__construct();
    session_start();
    if (empty($_SESSION["login"])) {
      header('Location: '.base_url().'/login');
			die();
    } else {
      consent_permission(RUNWAY);
    }
  }

  public function ips() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data['page_name'] = "Lista de IP's";
    $data['page_title'] = "Lista de IP's";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Ajustes";
    $data['actual_page'] = "IP's";
    $data['page_functions_js'] = "ips.js";
    $this->views->getView($this, "ips", $data);
  }

  public function list_records() {
    if (!$_SESSION['permits_module']['v']) return;
    $isEdit = $_SESSION['permits_module']['a'];
    $isRemove = $_SESSION['permits_module']['e'];
    $data = $this->model->listRecords($_GET);
    foreach ($data as $key => $item) {
      $item["n"] = $key + 1;
      $item["isEdit"] = $isEdit;
      $item["isRemove"] = $isRemove;
      $data[$key] = $item;
    }
    $this->json($data);
  }

  public function save() {
    try {
      $ip = $_POST["ip"];
      $array_ip = explode(".", $ip);
      $array_group = $array_ip;
      array_pop($array_group);
      $group = implode(".", $array_group);
      $start = (int)$array_ip[count($array_ip) - 1];
      $count =  (int)($_POST["rango"] + 1) - $start;
      if ($count < 1) throw new Exception("El rango debe ser mayor a {$start}");
      $data = [];
      for ($i = 0; $i < $count; $i++) {
        $current_ip = $start + $i;
        $payload = [];
        $payload["id"] = "{$group}.{$current_ip}";
        $payload["grupo"] = $group;
        $payload["estado"] = "LIBRE";
        $data[$i] = $payload;
      }
      $this->model->create_massive($data);
      echo json_encode([
        "status" => true,
        "message" => "Rango de IP's creadas"
      ]);
    } catch (\Throwable $th) {
      echo json_encode([
        "status" => false,
        "message" => $th->getMessage()
      ]);
    }
  }

  public function select_record(string $id) {
    if (!$_SESSION['permits_module']['v']) return;
    $data = $this->model->select_record($id);
    $this->json($data);
  }

  public function remove_record(string $id) {
    try {
      if (!$_SESSION['permits_module']['e']) throw new Exception("Forbbien");
      $result = $this->model->remove_record($id);
      if (!$result) throw new Exception("No se pudo eliminar");
      $this->json([
        "status" => true,
        "message" => "Registro eliminado correctamente!"
      ]);
    } catch (\Throwable $th) {
      $this->json([
        "status" => false,
        "message" => $th->getMessage()
      ]);
    }
  }
}