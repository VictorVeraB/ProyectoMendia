<?php

class CajaNap extends Controllers {
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

  public function cajaNap() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data['page_name'] = "Caja Nap";
    $data['page_title'] = "Caja Nap";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Gestión de Red";
    $data['actual_page'] = "Caja Nap";
    $data['page_functions_js'] = "cajanap.js";
    $this->views->getView($this, "cajanap", $data);
  }

  public function list_records() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $isEdit = $_SESSION['permits_module']['a'];
    $isRemove = $_SESSION['permits_module']['e'];
    try {
      $data = $this->model->listRecords($_GET);
    } catch (\Throwable $th) {
      $this->json($th->getMessage());
    }
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
      $this->model->create($_POST);
      $this->json([
        "status" => true,
        "message" => "Nap creado!!!"
      ]);
    } catch (\Throwable $th) {
      $this->json([
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

  public function update_record(string $id) {
    if (!$_SESSION['permits_module']['v']) return;
    try {
      $data = $this->model->update_record($id, $_POST);
      $this->json([
        "status" => "success", 
        "msg" => "Los datos se actualizaron correctamente!",
      ]);
    } catch (\Throwable $th) {
      $this->json([
        "status" => "error", 
        "msg" => "No se pudo actualizar los datos",
        "error" => $th->getMessage()
      ]);
    }
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

  public function view_map() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data['page_name'] = "Mapa de Caja Nap";
    $data['page_title'] = "Mapa de Caja Nap";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Gestión de Red";
    $data['actual_page'] = "Mapa de Caja Nap";
    $data['page_functions_js'] = "cajanap_map.js";
    $this->views->getView($this, "cajanap_map", $data);
  }

  public function view_location(string $id) {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $nap = $this->model->select_record($id);
    $data["nap"] = $nap;
    $data['page_name'] = "Mapa de Caja Nap";
    $data['page_title'] = "Mapa de Caja Nap";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Gestión de Red";
    $data['actual_page'] = "Mapa de Caja Nap";
    $data['page_functions_js'] = "cajanap_locacion.js";
    $this->views->getView($this, "cajanap_locacion", $data);
  }

  public function search_puertos() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data = $this->model->search_puertos($_GET);
    $this->json($data);
  }
}