<?php

class CampaniaModel extends Mysql {
  public function __construct(){
		parent::__construct();
	}

 public function list_users_record(array $filtros = []) {
    $query = $this->createQueryBuilder()
        ->from("clients cl")
        ->select("cl.id, cl.*")  // Seleccionamos solo el id y los campos del cliente
        ->addSelect("cl.mobile_optional", "ip")
        ->addSelect("CONCAT(cl.names, CONCAT(' ', cl.surnames))", "cliente")
        ->innerJoin("contracts c", "c.clientid = cl.id")
        ->innerJoin("document_type d", "cl.documentid = d.id");

    // Filtro por estado
    if (!empty($filtros['state'])) {
        $condicion = $filtros['state'];
        $query->andWhere("c.state = {$condicion}");
    }

    // Filtro por zona
    if (!empty($filtros['zona'])) {
        $zona = $filtros['zona'];
        $query->andWhere("cl.zona = '{$zona}'");
    }

    // Agrupamos por el id del cliente para evitar duplicados
    $query->groupBy('cl.id');

    return $query->getMany();
}


}
