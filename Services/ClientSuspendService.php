<?php

class ClientSuspendService
{
  private Mysql $mysql;

  public function __construct()
  {
    $this->mysql = new Mysql("clients");
  }

  public function execute(string $id)
  {
    try {
      $this->mysql->createQueryRunner();
      $client = $this->select_info_client($id);
      if (!$client) {
        throw new Exception("No se encontró el cliente");
      }
      // routeos disabled
      $service = new ClientSwitchMikrotikService();
      $service->executeSuspend($client);
      $this->suspend_contract($id);
      $this->suspend_plan($id);
      $this->mysql->commit();
      return true;
    } catch (\Throwable $th) {
      $this->mysql->rollback();
      return false;
    }
  }

  public function select_info_client(string $id)
  {
    return $this->mysql->createQueryBuilder()
      ->from("clients cl")
      ->innerJoin("contracts c", "c.clientid = cl.id")
      ->where("cl.id = {$id}")
      ->select("cl.*, c.id contractId")
      ->getOne();
  }

  public function suspend_contract(string $id)
  {
    return $this->mysql->createQueryBuilder()
      ->update()
      ->from("contracts")
      ->where("clientid = {$id}")
      ->set([
        "suspension_date" => date("Y-m-d"),
        "state" => 3
      ])->execute();
  }

  public function suspend_plan(string $id)
  {
    $condition = $this->mysql->createQueryBuilder("cli")
      ->innerJoin("contracts c", "c.clientid = cli.id")
      ->where("cli.id = {$id}")
      ->andWhere("d.contractid = c.id")
      ->getSql();
    // update
    return $this->mysql->createQueryBuilder()
      ->update()
      ->from("detail_contracts", "d")
      ->where("EXISTS ({$condition})")
      ->set(["state" => 3])->execute();
  }
}