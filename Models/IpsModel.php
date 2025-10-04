<?php

class IpsModel extends Mysql {
  public function __construct(){
		parent::__construct("ips");
	}

  public function listRecords($filters = []) {
    $query = $this->createQueryBuilder()
      ->orderBy("grupo", "asc")
      ->addOrderBy("id", "asc");
    if (isset($filters["querySearch"])) {
      $querySeach = $filters["querySearch"];
      $query->andWhere("id LIKE '%{$querySeach}%'");
    }
    if (isset($filters["estado"])) {
      $estado = $filters["estado"];
      $query->andWhere("estado = '{$estado}'");
    }
    return $query->getMany();
  }

  public function select_record(string $id) {
    $query = "SELECT * FROM {$this->tableName} WHERE id = '{$id}'";
    $response = $this->select($query);
    return $response;
  }

  public function create_massive($data = []) {
    $columns = ["id", "grupo", "estado"];
    return $this->insertMassive($columns, $data);
  } 

  public function remove_record(string $id) {
    $query = "DELETE FROM {$this->tableName} WHERE id = '$id' AND estado = 'LIBRE'";
    $result = $this->delete($query);
    return $result;
  }
}