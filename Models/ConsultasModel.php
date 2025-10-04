<?php

class ConsultasModel extends Mysql {
  public function __construct() {
		parent::__construct();
	}

  public function get_business() {
    return $this->createQueryBuilder()
      ->from("business")
      ->select("*")
      ->setLimit(1)
      ->getOne();
  }

  public function find_client($filters) {
    $value = $filters['value'];
    $query = $this->createQueryBuilder()
      ->select("*")
      ->addSelect("CONCAT(names, CONCAT(' ', surnames))", "cliente")
      ->from("clients");
    // filter 
    if ($value && $filters['type'] === 'phone') {
      $query->andWhere("mobile LIKE '{$value}'");
    } 
    if ($value && $filters['type'] === 'document') {
      $query->andWhere("document LIKE '{$value}'");
    }
    return $query->getOne();
  }

  public function list_bills(int $clienteId) {
    return $this->createQueryBuilder()
      ->select(
        "b.id,b.clientid,b.internal_code, b.correlative,b.date_issue,
        b.expiration_date,b.billed_month,b.subtotal,b.discount,
        b.total,b.type,b.sales_method,b.remaining_amount,b.amount_paid,b.state,
        vs.serie,v.voucher,b.observation, b.compromise_date"
      )
      ->from("bills b")
      ->innerJoin("vouchers v", " b.voucherid = v.id ")
      ->innerJoin("voucher_series vs", "b.serieid = vs.id")
      ->where("b.state != 0")
      ->andWhere("b.clientid = {$clienteId}")
      ->orderBy("b.id", "ASC")
      ->getMany();
  }

  public function invoice_paid(int $billId){
    return $this->createQueryBuilder()
      ->select(
        "p.id, p.billid, p.userid, p.clientid, p.internal_code, p.paytypeid,
        fp.payment_type, p.payment_date, p.comment, p.amount_paid,
        p.amount_total, p.remaining_credit"
      )
      ->from("payments p")
      ->innerJoin("forms_payment fp", "p.paytypeid = fp.id")
      ->where("p.billid = {$billId}")
      ->andWhere("p.state = 1")
      ->orderBy("p.id", "DESC")
      ->setLimit(1)
      ->getOne();
  }
}