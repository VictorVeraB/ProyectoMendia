<?php

class RouterOSModel extends Mysql {
  
  public function __construct() {
    // Llamar al constructor de la clase padre y pasar el nombre de la tabla
    parent::__construct("RouterOS");
  }

  // Método para obtener los metadatos de la tabla RouterOS (en este caso no es necesario para tu estructura, pero lo dejamos para consistencia)
  public function listMetaData() {
    return $this->createQueryBuilder()
      ->select("*")
      ->from("RouterOS")
      ->getMany();
  }

  // Método para listar los registros de la tabla RouterOS
  public function listRecords($filters = []) {
    $query = $this->createQueryBuilder()
      ->from("RouterOS")
      ->select("id, nombre, direccionIP, usuario, clave, puerto")
      ->orderBy("nombre", "asc");

    if (isset($filters["querySearch"])) {
      $querySearch = $filters["querySearch"];
      $query->andWhere("nombre LIKE '%{$querySearch}%'");
    }

    return $query->getMany();
  }

  // Método para seleccionar un solo registro basado en su ID
  public function select_record(string $id) {
    $query = $this->createQueryBuilder()
      ->from("RouterOS")
      ->select("id, nombre, direccionIP, usuario, clave, puerto")
      ->where("id = {$id}");

    return $query->getOne();
  }

  // Método para actualizar un registro
  public function update_record($id, $data = []) {
    return $this->createQueryBuilder()
      ->update()
      ->where("id = {$id}")
      ->set($data)
      ->execute();
  }
  
  
  

  // Método para crear un nuevo registro
  public function create($data = []) {
    $columns = ["nombre", "direccionIP", "usuario", "clave", "puerto"];
    return $this->insertObject($columns, $data);
  }

  // Método para eliminar un registro por ID
  public function remove_record(string $id) {
    $query = "DELETE FROM RouterOS WHERE id = '$id'";
    return $this->delete($query);
  }
  
  

}