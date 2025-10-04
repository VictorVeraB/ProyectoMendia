<?php head($data); ?>
<!-- INICIO TITULO -->
<ol class="breadcrumb float-xl-right">
  <li class="breadcrumb-item"><a href="<?= base_url() ?>/dashboard"><?= $data['home_page'] ?></a></li>
  <li class="breadcrumb-item active"><?= $data['actual_page'] ?></li>
</ol>
<h1 class="page-header"><?= $data['page_title'] ?></h1>
<div class="panel panel-default">
  <div class="panel-body border-panel">
    <div class="row">
      <div class="col-md-12 col-sm-12 col-12">
        <center><img src="<?= base_style() ?>/images/logotypes/superwisp.png" width="200px"></center>
        <p class="m-t-10">
          Esto es un Sistema de administración de clientes wisp con funciones de contabilidad. Pudiendo administrar la cartera de clientes y conocer detalles de cada cliente, la facturación, suspensión y reactivación del servicio, Velocidad asignada, servicio técnico y atención al cliente, facilitará el rendimiento de tu empresa y optimizar el servicio que se presta al cliente.
        </p>
      </div>
      <div class="ccol-md-12 col-sm-12 col-12" data-sortable="false">
        <div class="panel panel-default" data-sortable="false">
          <div class="panel-heading">
            <h6 class="panel-title f-w-700">DERECHOS DE AUTOR</h6>
          </div>
          <div class="panel-body border-panel" align="justify">
            <ul>
              <li><b>Proyecto: </b>Sistema de Proveedor de Internet privado de <mark><?= $_SESSION['businessData']['business_name'] ?><mark></li>
              <li><b>Versión: </b>1.5.0</li>
              <li><b>Desarrollado por: </b><?= DEVELOPER ?></li>
              <li><b>Web: </b><a href="<?= DEVELOPER_WEBSITE ?>"><?= DEVELOPER_WEBSITE ?></a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="ccol-md-12 col-sm-12 col-12" data-sortable="false">
        <div class="panel panel-default" data-sortable="false">
          <div class="panel-heading">
            <h6 class="panel-title f-w-700">CONTACTO</h6>
          </div>
          <div class="panel-body border-panel" align="justify">
            <p>Para soporte enviame un mensaje:</p>
            <ul>
              <li><b>Correo: </b><?= DEVELOPER_EMAIL ?></li>
              <li><b>WhatsApp: </b>+51 <?= DEVELOPER_MOBILE ?></li>
            </ul>
            <p>Todo correo de este deberá ser con el asunto "<?= $_SESSION['businessData']['business_name'] ?>-SistemaProveedordeInternet"</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- FIN TITULO -->
<?php footer($data); ?>
