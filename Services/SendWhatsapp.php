<?php 

class SendWhatsapp {
  private $business;
  private $messageError;

  public function __construct($business) {
    $this->business = $business;
  }

  public function send($number, $message) {
    try {
      $key = $this->business['whatsapp_key'];
      $url = "{$this->business['whatsapp_api']}/api/messages/send";
      if (!$key) throw new Exception("No se encontró la configuración");
      // agregar headers
      $headers = [
        "Authorization: Bearer {$this->business['whatsapp_key']}",
        "Content-Type: application/json",
        "cache-control: no-cache"
      ];
      // enviar whatsapp
      $curl = curl_init();
      curl_setopt_array($curl, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_POSTFIELDS => json_encode(["number" => $number, "body" => $message]),
        CURLOPT_HTTPHEADER => $headers
      ]);
      $response = curl_exec($curl);
      $err = curl_error($curl); 
      curl_close($curl);
      if (!$response) throw new Exception($err);
      return true;
    } catch (\Throwable $th) {
      $this->messageError = $th->getMessage();
      return false;
    }
  }

  public function getMessageError() {
    return $this->messageError;
  }
}