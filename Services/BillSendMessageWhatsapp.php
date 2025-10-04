<?php 

class BillSendMessageWhatsapp {
  public function send($filters = []) {
    try {
      $array_success = [];
      $array_error = [];
      $message = new BillInfoMessage();
      $data = $message->listMessages($filters);
      foreach ($data as $key => $item) {
        $business = $message->getBusiness();
        $whatsapp = new SendWhatsapp($business);
        $response = $whatsapp->send($item['number'], $item['body']);
        if ($response) array_push($array_success, $item['number']);
        else array_push($array_error, $item['number']);
      }
      // response
      return [
        "message" => "Mensajes enviados",
        "data" => $array_success,
        "error" => $array_error
      ];
    } catch (\Throwable $th) {
      return [
        "message" => $th->getMessage()
      ];
    }
  }
}