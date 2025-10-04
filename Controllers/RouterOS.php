<?php

class RouterOS extends Controllers {
  public function __construct() {
    parent::__construct();
    session_start();
    if (empty($_SESSION["login"])) {
      header('Location: '.base_url().'/login');
      die();
    } else {
      consent_permission(RED);
    }
    
    // Incluir la clase RouterOSApi usando la constante LIBRARIES
    require_once LIBRARIES . '/RouterOS/routeros_api_class.php';
    $this->routerosApi = new RouterOSApi();
  }

  public function RouterOS() {
    if(empty($_SESSION['permits_module']['v'])){
      header("Location:".base_url().'/dashboard');
    }
    $data['columns'] = $this->model->listMetaData();
    $data['page_name'] = "RouterOS";
    $data['page_title'] = "RouterOS";
    $data['home_page'] = "Dashboard";
    $data['previous_page'] = "Gestión de Red";
    $data['actual_page'] = "RouterOS";
    $data['page_functions_js'] = "Router_OS.js";
    $this->views->getView($this, "RouterOS", $data);
  }

  public function list_records() {
    if (!$_SESSION['permits_module']['v']) return;
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
  
  public function reboot_mikrotik(string $id) {
    try {
        if (!$_SESSION['permits_module']['v']) {
            $this->json(["status" => false, "message" => "No tienes permiso para realizar esta acción."]);
            return;
        }

        // Obtener los datos del MikroTik por su ID
        $data = $this->model->select_record($id);
        if (!$data) {
            $this->json(["status" => false, "message" => "MikroTik no encontrado."]);
            return;
        }

        // Conectar al MikroTik
        $connected = $this->routerosApi->connect(
            $data['direccionIP'],
            $data['usuario'],
            $data['clave'],
            $data['puerto']
        );

        if ($connected) {
            // Ejecutar el comando de reinicio
            $this->routerosApi->comm('/system/reboot');
            $this->routerosApi->disconnect();

            // Responder con éxito
            $this->json(["status" => true, "message" => "El MikroTik se está reiniciando."]);
        } else {
            $this->json(["status" => false, "message" => "No se pudo conectar al MikroTik."]);
        }
    } catch (\Throwable $e) {
        $this->json(["status" => false, "message" => "Error inesperado: " . $e->getMessage()]);
    }
}


  
  public function create_backup(string $id) {
    try {
        if (!$_SESSION['permits_module']['v']) {
            $this->json(["status" => false, "message" => "No tienes permiso para realizar esta acción."]);
            return;
        }

        $data = $this->model->select_record($id);
        if (!$data) {
            $this->json(["status" => false, "message" => "MikroTik no encontrado."]);
            return;
        }

        $connected = $this->routerosApi->connect(
            $data['direccionIP'],
            $data['usuario'],
            $data['clave'],
            $data['puerto']
        );

        if ($connected) {
            // Obtener lista de backups en el MikroTik
            $existingBackups = $this->routerosApi->comm('/file/print');

            // Obtener la fecha de hoy en formato YYYYMMDD
            $today = date("Ymd");

            // Verificar si ya existe un backup con fecha de hoy
            foreach ($existingBackups as $file) {
                if (strpos($file['name'], "backup-$today") !== false) {
                    $this->json(["status" => false, "message" => "Ya existe un backup creado hoy. Intenta nuevamente mañana."]);
                    $this->routerosApi->disconnect();
                    return;
                }
            }

            // Generar el nombre del backup
            $backupName = "backup-" . $today . "-" . date("His") . ".backup";

            // Crear el backup en el MikroTik
            $this->routerosApi->comm('/system/backup/save', [
                'name' => $backupName
            ]);

            $this->routerosApi->disconnect();

            $this->json(["status" => true, "message" => "Backup creado exitosamente en el MikroTik.", "file" => $backupName]);
        } else {
            $this->json(["status" => false, "message" => "No se pudo conectar al MikroTik."]);
        }
    } catch (\Throwable $e) {
        $this->json(["status" => false, "message" => "Error inesperado: " . $e->getMessage()]);
    }
}


  public function save() {
    try {
      // Obtener los datos del formulario
      $nombre = strtoupper(trim($_POST['nombre']));
      $direccionIP = trim($_POST['direccionIP']);
      $usuario = trim($_POST['usuario']);
      $clave = trim($_POST['clave']);
      $puerto = trim($_POST['puerto']);

      // Intentar conectarse a MikroTik
      $validation = $this->routerosApi->connect($direccionIP, $usuario, $clave, $puerto);

      if (!$validation) {
        echo json_encode([
          "status" => false,
          "message" => "Error al conectar con MikroTik."
        ]);
        return;
      }

      // Si la conexión es exitosa, proceder con la creación
      $this->model->create([
        'nombre' => $nombre,
        'direccionIP' => $direccionIP,
        'usuario' => $usuario,
        'clave' => $clave,
        'puerto' => $puerto,
      ]);

      echo json_encode([
        "status" => true,
        "message" => "RouterOS creado y conexión validada correctamente!!!"
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

    if (!$data) {
        $this->json(["status" => false, "message" => "MikroTik no encontrado."]);
        return;
    }

    try {
        $connected = $this->routerosApi->connect(
            $data['direccionIP'],
            $data['usuario'],
            $data['clave'],
            $data['puerto']
        );

        if ($connected) {
            // Información del sistema
            $systemResource = $this->routerosApi->comm('/system/resource/print')[0];
            $identity = $this->routerosApi->comm('/system/identity/print')[0];
            $interfaces = $this->routerosApi->comm('/interface/print');

            $data['version'] = $systemResource['version'] ?? "N/A";
            $data['uptime'] = isset($systemResource['uptime']) 
                ? $this->formatUptime($systemResource['uptime']) 
                : "N/A";
            $data['model'] = $systemResource['board-name'] ?? "N/A";
            $data['identity'] = $identity['name'] ?? "N/A";
            $data['interfaces'] = $interfaces;

            $this->routerosApi->disconnect();
        } else {
            $data['version'] = "Conexión fallida";
            $data['uptime'] = "Conexión fallida";
            $data['model'] = "Conexión fallida";
            $data['identity'] = "Conexión fallida";
            $data['interfaces'] = [];
        }
    } catch (\Exception $e) {
        $data['version'] = "Error: " . $e->getMessage();
        $data['uptime'] = "Error: " . $e->getMessage();
        $data['model'] = "Error: " . $e->getMessage();
        $data['identity'] = "Error: " . $e->getMessage();
        $data['interfaces'] = [];
    }

    $this->json($data);
}

// Función privada para convertir uptime al formato deseado
private function formatUptime(string $uptime): string {
    $weeks = 0;
    $days = 0;
    $hours = 0;
    $minutes = 0;
    $seconds = 0;

    // Analizar la cadena de uptime
    if (preg_match('/(\d+)w/', $uptime, $match)) {
        $weeks = (int)$match[1];
    }
    if (preg_match('/(\d+)d/', $uptime, $match)) {
        $days = (int)$match[1];
    }
    if (preg_match('/(\d+)h/', $uptime, $match)) {
        $hours = (int)$match[1];
    }
    if (preg_match('/(\d+)m/', $uptime, $match)) {
        $minutes = (int)$match[1];
    }
    if (preg_match('/(\d+)s/', $uptime, $match)) {
        $seconds = (int)$match[1];
    }

    // Convertir semanas a días
    $days += $weeks * 7;

    // Formatear la salida
    return sprintf('%dd-%dh-%dm-%ds', $days, $hours, $minutes, $seconds);
}


  public function update_record(string $id) {
    if (!$_SESSION['permits_module']['v']) return;
    try {
        // Obtener los datos del formulario
        $nombre = strtoupper(trim($_POST['nombre']));
        $direccionIP = trim($_POST['direccionIP']);
        $usuario = trim($_POST['usuario']);
        $clave = trim($_POST['clave']);
        $puerto = trim($_POST['puerto']);

        // Intentar conectarse a MikroTik
        $validation = $this->routerosApi->connect($direccionIP, $usuario, $clave, $puerto);

        // Verificar si la conexión fue exitosa
        if (!$validation) {
            // Si no se puede conectar, devolver un mensaje de error
            echo json_encode([
                "status" => "error",
                "msg" => "Error al conectar con MikroTik. Verifique las credenciales o la conectividad.",
            ]);
            return;
        }

        // Si la conexión es exitosa, proceder con la actualización
        $data = $this->model->update_record($id, $_POST);

        // Verificar si la actualización fue exitosa
        if ($data) {
            echo json_encode([
                "status" => "success", 
                "msg" => "Los datos se actualizaron correctamente!",
            ]);
        } else {
            echo json_encode([
                "status" => "error", 
                "msg" => "No se pudo actualizar los datos, por favor intente nuevamente.",
            ]);
        }

    } catch (\Throwable $th) {
        // Manejo de excepciones generales
        echo json_encode([
            "status" => "error", 
            "msg" => "Ocurrió un error inesperado durante la actualización.",
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
  
  

  public function list_users_record(string $id) {
    $data = $this->model->list_users_record($id);
    foreach ($data as $key => $item) {
      $item['encrypt_client'] = encrypt($item['clientid']);
      $data[$key] = $item;
    }
    $this->json($data);
  }
}
