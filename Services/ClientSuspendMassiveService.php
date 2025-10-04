<?php

class ClientSuspendMassiveService
{
  private Mysql $mysql;

  public function __construct()
  {
    $this->mysql = new Mysql("clients");
  }

  public function execute(string $date)
  {
    $collect = $this->list_clients($date);
    // validate
    if (count($collect) == 0) {
      throw new Exception("No se encontró deudas");
    }
    // disabled
    foreach ($collect as $item) {
      $service = new ClientSuspendService();
      $service->execute($item['id']);
      print_r($item);
    }
  }

  public function list_clients(string $date)
  {
    return $this->mysql->createQueryBuilder("cli")
      ->innerJoin("contracts c", "c.clientid = cli.id")
      ->innerJoin("bills b", "b.clientid = cli.id")
      ->where("DATE_ADD(b.expiration_date, INTERVAL c.days_grace DAY) <= '{$date}'")
      ->andWhere("b.state IN (2, 3)")
      ->andWhere("c.state = 2")
      ->select("cli.*")
      ->getMany();
  }
}