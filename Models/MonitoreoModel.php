<?php

class MonitoreoModel extends Mysql {
  public function __construct(){
		parent::__construct("ap_clientes");
	}

  private function queryApClientes($filters = []) {
    $queryCounter = $this->createQueryBuilder()
      ->from("clients cl")
      ->innerJoin("contracts c", "c.clientid = cl.id")
      ->where("cl.ap_cliente_id = ap.id");
    $counterClientes = BuilderQuery::copy($queryCounter)
      ->select("COUNT(c.id)")
      ->getSql();
    $counterActivos =  BuilderQuery::copy($queryCounter)
      ->andWhere("c.state IN (1, 2, 5)")
      ->select("COUNT(c.id)")
      ->getSql();
    $counterSuspendidos = BuilderQuery::copy($queryCounter)
      ->andWhere("c.state = 3")
      ->select("COUNT(c.id)")
      ->getSql();
    $counterCancelados = BuilderQuery::copy($queryCounter)
      ->andWhere("c.state = 4")
      ->select("COUNT(c.id)")
      ->getSql();
    // query principal
    $query = $this->createQueryBuilder()
      ->from("ap_clientes ap")
      ->select("ap.id, ap.nombre, ap.ip info")
      ->addSelect("'Ap Cliente'", "tipo")
      ->addSelect("'ip'", "conector")
      ->addSelect("({$counterClientes})", "countClientes")
      ->addSelect("({$counterActivos})", "counterActivos")
      ->addSelect("({$counterSuspendidos})", "counterSuspendidos")
      ->addSelect("({$counterCancelados})", "counterCancelados")
      ->groupBy("ap.id, ap.nombre, ap.ip");
    if (isset($filters["querySearch"])) {
      $querySeach = $filters["querySearch"];
      $query->andWhere("nombre LIKE '%{$querySeach}%'");
    }
    return $query->getSql();
  }

  private function queryCajaNap($filters = []) {
    $queryCounter = $this->createQueryBuilder()
      ->from("clients cl")
      ->innerJoin("contracts c", "c.clientid = cl.id")
      ->innerJoin("caja_nap_clientes cnc", "cnc.id = cl.nap_cliente_id")
      ->where("cnc.nap_id = nap.id");
    $counterClientes = BuilderQuery::copy($queryCounter)
      ->select("COUNT(c.id)")
      ->getSql();
    $counterActivos = BuilderQuery::copy($queryCounter)
      ->andWhere("c.state IN (1, 2, 5)")
      ->select("COUNT(c.id)")
      ->getSql();
    $counterSuspendidos = BuilderQuery::copy($queryCounter)
      ->andWhere("c.state = 3")
      ->select("COUNT(c.id)")
      ->getSql();
    $counterCancelados = BuilderQuery::copy($queryCounter)
      ->andWhere("c.state = 4")
      ->select("COUNT(c.id)")
      ->getSql();
    // query principal
    $query = $this->createQueryBuilder()
      ->from("caja_nap nap")
      ->select("nap.id, nap.nombre, nap.puertos info")
      ->addSelect("'Caja Nap'", "tipo")
      ->addSelect("'puertos'", "conector")
      ->addSelect("({$counterClientes})", "countClientes")
      ->addSelect("({$counterActivos})", "counterActivos")
      ->addSelect("({$counterSuspendidos})", "counterSuspendidos")
      ->addSelect("({$counterCancelados})", "counterCancelados");
    if (isset($filters["querySearch"])) {
      $querySeach = $filters["querySearch"];
      $query->andWhere("nombre LIKE '%{$querySeach}%'");
    }
    return $query->getSql();
  }

  public function listRecords($filters = []) {
    $queryNap = $this->queryCajaNap($filters);
    $queryAp = $this->queryApClientes($filters);
    return $this->createQueryBuilder() 
      ->select("up.*")
      ->from("({$queryNap} UNION {$queryAp}) up")
      ->getMany();
  }

  public function select_record(string $id) {
    return $this->createQueryBuilder()
      ->where("id = {$id}")
      ->getOne();
  }
}