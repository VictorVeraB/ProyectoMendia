<?php
  head($data);
  modal("clientsModal",$data);
  $documents = $data['documents'];
  $contract = $data['contract_information']['contract'];
  $client = $data['contract_information']['client'];
  $debt = $data['contract_information']['current_debt'];
  $bill = $data['contract_information']['bill'];
  $pending = $data['contract_information']['pending'];

  $form = [
    "client" => $client,
    "documents" => $documents
  ];
?>
<!-- INICIO TITULO -->
<ol class="breadcrumb float-xl-right">
  <li class="breadcrumb-item"><a href="<?= base_url() ?>/dashboard"><?= $data['home_page'] ?></a></li>
  <li class="breadcrumb-item"><a href="<?= base_url() ?>/customers"><?= $data['previous_page'] ?></a></li>
  <li class="breadcrumb-item active"><?= $data['actual_page'] ?></li>
</ol>
<h1 class="page-header f-s-18">
  <img data-name="<?= $data['page_title'] ?>" id="image-user" style="border-radius: 100%">
  <?= $data['page_title'] ?>
</h1>
<div class="row" data-sortable="false">
  <div class="col-sm-12" data-sortable="false">
    <div class="panel panel-inverse panel-with-tabs" data-sortable="false">
      <div class="panel-heading p-0">
        <div class="tab-overflow nav-ajax" style="width: 100%">
          <ul class="nav nav-tabs nav-tabs-inverse">
            <li class="nav-item"><a href="#client-tab" data-toggle="tab" class="nav-link active" data-view="abstract"><i class="fa fa-fw fa-lg fa-info-circle mr-1"></i><span class="d-none d-lg-inline">Resumen</span></a></li>
            <li class="nav-item"><a href="#services-tab" data-toggle="tab" class="nav-link" data-view="services"><i class="far fa-fw fa-lg fa-calendar-alt mr-1"></i><span class="d-none d-lg-inline">Planes</span></a></li>
            <li class="nav-item"><a href="#billing-tab" data-toggle="tab" class="nav-link" data-view="billing"><i class="fa fa-fw fa-lg fa-money-bill-alt mr-1"></i><span class="d-none d-lg-inline">Facturación</span></a></li>
            <li class="nav-item"><a href="#tickets-tab" data-toggle="tab" class="nav-link" data-view="tickets"><i class="far fa-fw fa-lg fa-life-ring mr-1"></i><span class="d-none d-lg-inline">Tickets</span></a></li>
            <li class="nav-item"><a href="#gallery-tab" data-toggle="tab" class="nav-link" data-view="gallery"><i class="fa fa-fw fa-lg fa-image mr-1"></i><span class="d-none d-lg-inline">Galeria</span></a></li>
            <li class="nav-item"><a href="#router-tab" data-toggle="tab" class="nav-link" data-view="router"><i class="fas fa-fw fa-lg fa-wifi mr-1"></i></i><span class="d-none d-lg-inline">Router</span></a></li>
          </ul>
        </div>
      </div>
      <div class="panel-body tab-content">
        <div class="tab-pane fade active show" id="client-tab">
          <form autocomplete="off" name="transactions_client" id="transactions_client">
            <div class="row row-space-30">
              <div class="col-xl-7" style="border-right: 1px solid #e2e7ec !important;">
                <div class="mb-3 text-inverse f-w-600 f-s-13"><i class="fa fa-angle-double-right mr-2"></i>DATOS DEL CLIENTE</div>

                <?php form("customForm", $form) ?>
  
                <div class="form-group row">
                  <label class="col-md-3 col-form-label text-right">Coordenadas
                    <button type="button" class="btn btn-icono btn-xs" data-toggle="tooltip" data-placement="top" data-original-title="Abrir google maps" onclick="open_map()">
                      <i class="fas fa-map-marker-alt"></i>
                    </button>
                    <button type="button" class="btn btn-icono btn-xs btn-coordinates d-none" data-toggle="tooltip" data-placement="top" data-original-title="Obtener Ubicación Actual" data-loading-text="<i class='fas fa-spinner fa-spin'></i>" onclick="current_location()">
                      <i class="fas fa-map-marker-alt"></i>
                    </button>
                  </label>
                  <div class="col-md-9 row">
                    <div class="col-md-6">
                      <input type="text" class="form-control" name="latitud" id="latitud" placeholder="14.254454545" value="<?= $client['latitud'] ?>">
                      <small class="text-success text-uppercase m-b-10">Latitud</small>
                    </div>
                    <div class="col-md-6">
                      <input type="text" class="form-control" name="longitud" id="longitud" placeholder="-17.44587488" value="<?= $client['longitud'] ?>">
                      <small class="text-success text-uppercase m-b-10">Longitud</small>
                    </div>
                  </div>
                </div>

                <div class="form-group row">
                  <label class="col-md-3 text-lg-right col-form-label">Estado</label>
                  <div class="col-md-9">
                    <div class="form-control dv-state-user" style="border: none;">
                      <?php
                        if($contract['state'] == 1){
                          echo'<span class="label label-orange">INSTALACIÓN</span>';
                        }else if($contract['state'] == 2){
                          echo '<span class="label label-green">ACTIVO</span>';
                        }else if($contract['state'] == 3){
                          echo '<span class="label label-primary">SUSPENDIDO</span>';
                        }else if($contract['state'] == 4){
                          echo '<span class="label label-dark">CANCELADO</span>';
                        }else if($contract['state'] == 5){
                          echo '<span class="label label-indigo">GRATIS</span>';
                        }
                      ?>
                    </div>
                  </div>
                </div>
                <div class="form-group row justify-content-center">
                  <button 
                    id="save-info" 
                    type="submit" 
                    class="btn btn-blue"
                  >
                    <i class="fas fa-save mr-2"></i>Guardar Cambios
                  </button>
                </div>
              </div>
              <div class="col-xl-5">
                <div class="mb-3 text-inverse f-w-600 f-s-13">
                  <i class="fa fa-angle-double-right mr-2"></i>AVISOS
                </div>
                <?php
                  if($contract['state'] == 5){
                    $balance = $_SESSION['businessData']['symbol']." ".format_money($debt)."</strong>";
                    $expiration = "00/00/0000";
                    $cutoff = "00/00/0000";
                    $create = "Desactivado";
                  }else{
                    $balance = $_SESSION['businessData']['symbol']." ".format_money($debt)."</strong>";
                    if($pending >= 1){
                      $days_grace = str_pad($contract['days_grace'], 2, "0", STR_PAD_LEFT);
                      $expiration = date("d/m/Y",strtotime($bill['expiration_date']));
                      $day = date("Y-m-d",strtotime($bill['expiration_date']));
                      $cutoff = date("d/m/Y",strtotime($day." + ".$days_grace." days"));
                      $create = ($contract['create_invoice'] == 0) ? "Desactivado" : date("d/m/Y",strtotime($day ."-".$contract['create_invoice']." days"));
                    }else{
                      $payday = str_pad($contract['payday'], 2, "0", STR_PAD_LEFT);
                      $date_exp = date("Y-m-".$payday);
                      $expiration = date("d/m/Y",strtotime($date_exp." + 1 month"));
                      $day = date("Y-m-d",strtotime(date("Y-m-".$payday)."+ 1 month"));
                      $cutoff = date("d/m/Y",strtotime($day." + ".$contract['days_grace']." days"));
                      $create = ($contract['create_invoice'] == 0) ? "Desactivado" : date("d/m/Y",strtotime($day ."-".$contract['create_invoice']." days"));
                    }
                  }
                ?>
                <div class="row">
                  <div class="col-md-6">
                    <div class="widget-list widget-list-rounded m-b-5" data-id="widget">
                      <div class="widget-list-item bg-success">
                        <div class="widget-list-media icon p-5">
                          <i class="fa fa-calendar-alt f-s-30 f-w-700 text-white"></i>
                        </div>
                        <div class="widget-list-content p-5">
                          <h4 class="widget-list-title text-white f-w-700"><?= $expiration ?></h4>
                          <p class="widget-list-desc text-white text-uppercase">Dia de pago</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="widget-list widget-list-rounded m-b-5" data-id="widget">
                      <div class="widget-list-item bg-indigo">
                        <div class="widget-list-media icon p-5"><i class="fa fa-file-contract f-s-30 f-w-700 text-white"></i></div>
                        <div class="widget-list-content p-5">
                          <h4 class="widget-list-title text-white f-w-700">25 DE CADA MES<!--<?= $create ?>--></h4>
                          <p class="widget-list-desc text-white text-uppercase">Crear Factura</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="widget-list widget-list-rounded m-b-5" data-id="widget">
                      <div class="widget-list-item bg-danger">
                        <div class="widget-list-media icon p-5"><i class="fa fa-calendar-times f-s-30 f-w-700 text-white"></i></div>
                        <div class="widget-list-content p-5">
                          <h4 class="widget-list-title text-white f-w-700"><?= $cutoff ?></h4>
                          <p class="widget-list-desc text-white text-uppercase">Dia de corte</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="widget-list widget-list-rounded m-b-5" data-id="widget">
                      <div class="widget-list-item bg-warning">
                        <div class="widget-list-media icon p-5"><i class="fa fa-dollar-sign f-s-30 f-w-700 text-white"></i></div>
                        <div class="widget-list-content p-5">
                          <h4 class="widget-list-title text-white f-w-700"><?= $balance ?></h4>
                          <p class="widget-list-desc text-white text-uppercase">Deuda Actual</p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <?php
                  if($contract['discount'] == 1){
                    if($contract['remaining_discount'] <= 0){
                      $state_dis = "<strong> Descuento no vigente</strong>";
                    }else{
                      $state_dis = "<strong>Descuento vigente</strong>";
                    }
                    if($contract['months_discount'] == 1){
                      $month_dis = $contract['months_discount']." mes";
                    }else{
                      $month_dis = $contract['months_discount']." meses";
                    }
                  ?>
                  <div class="col-md-6">
                    <div class="widget-list widget-list-rounded m-b-5" data-id="widget">
                      <div class="widget-list-item bg-blue">
                        <div class="widget-list-media icon p-5"><i class="fa fa-percent f-s-30 f-w-700 text-white"></i></div>
                        <div class="widget-list-content p-5">
                          <h4 class="widget-list-title text-white f-w-700">
                            <?= $_SESSION['businessData']['symbol']." ".format_money($contract['discount_price']) ?> por <?= $month_dis ?>
                          </h4>
                          <p class="widget-list-desc text-white text-uppercase"><?= $state_dis ?></p>
                        </div>
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                  
                   
                </div>
              </div>
            </div>
          </form>
        </div>
        <div class="tab-pane fade" id="services-tab">
          <input type="hidden" id="idcontract" value="<?= encrypt($contract['id']) ?>">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"><b>Planes de Internet</b></h4>
              <div class="panel-heading-btn">
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-iconpanel" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-iconpanel" data-click="panel-reload" onclick="refresh_internet()"><i class="fas fa-sync-alt"></i></a>
              </div>
            </div>
            <div class="panel-body border-panel">
              <div class="row">
                <div id="list-internet-btns-tools">
                  <div class="options-group btn-group m-r-5">
                  <?php if($_SESSION['permits_module']['r']){ ?>
                    <button type="button" class="btn btn-white" onclick="add_internet()"><i class="fas fa-plus mr-1"></i>Nuevo</button>
                  <?php } ?>
                  </div>
                </div>
                <div class="col-md-12 col-sm-12 col-12">
                  <div class="table-responsive">
                    <table id="list-internet" class="table table-bordered dt-responsive nowrap dataTable dtr-inline collapsed" data-order='[[ 1, "asc" ]]' style="width: 100%;">
                      <thead>
                        <tr>
                          <th style="max-width: 60px !important; width: 60px;">Codigo</th>
                          <th>Plan</th>
                          <th>Costo</th>
                          <th>Máx. Subida</th>
                          <th>Máx. Bajada</th>
                          <th>Fecha ingreso</th>
                          <th>Estado</th>
                          <th class="all" data-orderable="false" style="max-width: 40px !important; width: 40px;"></th>
                        </tr>
                      </thead>
                      <tbody></tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title"><b>Planes Personalizados</b></h4>
              <div class="panel-heading-btn">
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-iconpanel" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-iconpanel" data-click="panel-reload" onclick="refresh_personalized()"><i class="fas fa-sync-alt"></i></a>
              </div>
            </div>
            <div class="panel-body border-panel">
              <div class="row">
                <div id="list-personalized-btns-tools">
                  <div class="options-group btn-group m-r-5">
                  <?php if($_SESSION['permits_module']['r']){ ?>
                    <button type="button" class="btn btn-white" onclick="add_personalized()"><i class="fas fa-plus mr-1"></i>Nuevo</button>
                  <?php } ?>
                  </div>
                </div>
                <div class="col-md-12 col-sm-12 col-12">
                  <div class="table-responsive">
                    <table id="list-personalized" class="table table-bordered dt-responsive nowrap dataTable dtr-inline collapsed" data-order='[[ 1, "asc" ]]' style="width: 100%;">
                      <thead>
                        <tr>
                          <th style="max-width: 60px !important; width: 60px;">Codigo</th>
                          <th>Plan</th>
                          <th>Costo</th>
                          <th>Fecha ingreso</th>
                          <th>Estado</th>
                          <th class="all" data-orderable="false" style="max-width: 40px !important; width: 40px;"></th>
                        </tr>
                      </thead>
                      <tbody></tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="billing-tab">
          <div class="tabcontent">
            <ul class="tabgris nav nav-tabs nav-ajax">
              <li class="nav-items">
                <a href="#nav-bills" data-toggle="tab" data-view="bills" class="nav-link active show">
                  <span class="d-sm-block d-none"><i class="fas fa-file-alt mr-2"></i>Facturas</span>
                  <span class="d-sm-none"><i class="fas fa-file-alt fa-lg"></i></span>
                </a>
              </li>
              <li class="nav-items">
                <a href="#nav-transactions" data-toggle="tab" data-view="transactions" class="nav-link">
                  <span class="d-sm-block d-none"><i class="fa fa-bars mr-2"></i>Transacciones</span>
                  <span class="d-sm-none"><i class="fa fa-bars fa-lg"></i></span>
                </a>
              </li>
              <li class="nav-items">
                <a href="#nav-configurations" data-toggle="tab" data-view="settings" class="nav-link">
                  <span class="d-sm-block d-none"><i class="fas fa-cogs mr-2"></i>Configuración</span>
                  <span class="d-sm-none"><i class="fas fa-cogs fa-lg"></i></span>
                </a>
              </li>
            </ul>
            <div class="tab-content mb-0">
              <div class="tab-pane active show" id="nav-bills">
                <div class="row">
                  <div id="list-bills-btns-tools">
                    <div class="options-group btn-group m-r-5">
                      <?php if($_SESSION['permits_module']['r']){ ?>
                      <?php if($contract['state'] == 5){ ?>
                      <button type="button" class="btn btn-white" onclick="bill_free();"><i class="fas fa-plus mr-1"></i>Factura libre</button>
                      <?php }else{?>
                      <button type="button" class="btn btn-white" onclick="bill_free();"><i class="fas fa-plus mr-1"></i>Factura libre</button>
                      <button type="button" class="btn btn-white" onclick="bill_services();"><i class="fas fa-plus mr-1"></i>Factura servicio</button>
                      <?php } ?>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="col-md-12 col-sm-12 col-12">
                    <div class="table-responsive">
                      <table id="list-bills" class="table table-bordered dt-responsive nowrap dataTable dtr-inline collapsed" data-order='[[ 0, "desc" ]]' style="width: 100%;">
                        <thead>
                          <tr>
                            <th>Nº Factura</th>
                            <th>Mes Fact.</th>
                            <th>Emitido</th>
                            <th>Vencimiento</th>
                            <th>Compromiso</th>
                            <th style="max-width: 60px !important; width: 60px;">Total</th>
                            <th style="max-width: 70px !important; width: 70px;">Pendiente</th>
                            <th>Tipo</th>
                            <th>Fecha pago</th>
                            <th>Forma pago</th>
                            <th>Metodo</th>
                            <th>Observación</th>
                            <th class="all">Estado</th>
                            <th class="all" data-orderable="false" style="max-width: 40px !important; width: 40px;"></th>
                          </tr>
                        </thead>
                        <tbody></tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="nav-transactions">
                <div class="row">
                  <div class="col-md-12 col-sm-12 col-12">
                    <div class="table-responsive">
                      <table id="list-transactions" class="table table-bordered dt-responsive nowrap dataTable dtr-inline collapsed" data-order='[[ 0, "desc" ]]' style="width: 100%;">
                        <thead>
                          <tr>
                            <th>Codigo</th>
                            <th>Nº Fact.</th>
                            <th>Fecha</th>
                            <th style="max-width: 60px !important; width: 60px;">Pagado</th>
                            <th>Forma pago</th>
                            <th>Usuario</th>
                            <th>Comentario</th>
                            <th class="all">Estado</th>
                            <th class="all" data-orderable="false" style="max-width: 40px !important; width: 40px;"></th>
                          </tr>
                        </thead>
                        <tbody></tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="nav-configurations">
                <form autocomplete="off" name="transactions_contract" id="transactions_contract" class="row">
                  <input type="hidden" name="idcontract" value="<?= encrypt($contract['id']) ?>">
                  <div class="col-lg-12" data-sortable="false">
                    <div class="panel panel-default" data-sortable="false">
                      <div class="panel-heading">
                        <h4 class="panel-title"><b><i class="far fa-file mr-1"></i>Facturación</b></h4>
                      </div>
                      <div class="panel-body border-panel">
                        <div class="form-group row m-b-10">
                          <label class="col-md-4 text-lg-right col-form-label">Estado</label>
                          <div class="col-md-6">
                            <select disabled class="form-control" name="listPlan" id="listPlan">
                              <?php
                                if($contract['state'] == 1){
                                  echo '<option value="1" selected>Instalación</option>
                                  <option value="2">Activo</option>
                                  <option value="3">Suspendido</option>
                                  <option value="4">Cancelado</option>
                                  <option value="5">Gratis</option>';
                                }
                                if($contract['state'] == 2){
                                  echo '<option value="1">Instalación</option>
                                  <option value="2" selected>Activo</option>
                                  <option value="3">Suspendido</option>
                                  <option value="4">Cancelado</option>
                                  <option value="5">Gratis</option>';
                                }
                                if($contract['state'] == 3){
                                  echo '<option value="1">Instalación</option>
                                  <option value="2">Activo</option>
                                  <option value="3" selected>Suspendido</option>
                                  <option value="4">Cancelado</option>
                                  <option value="5">Gratis</option>';
                                }
                                if($contract['state'] == 4){
                                  echo ' <option value="1">Instalación</option>
                                  <option value="2">Activo</option>
                                  <option value="3">Suspendido</option>
                                  <option value="4" selected>Cancelado</option>
                                  <option value="5">Gratis</option>';
                                }
                                if($contract['state'] == 5){
                                  echo '<option value="1">Instalación</option>
                                  <option value="2">Activo</option>
                                  <option value="3">Suspendido</option>
                                  <option value="4">Cancelado</option>
                                  <option value="5" selected>Gratis</option>';
                                }
                              ?>
                            </select>
                          </div>
                        </div>
                        <div class="form-group row m-b-10 cont-day">
                          <label class="col-md-4 text-lg-right col-form-label">Dia de pago</label>
                          <div class="col-md-6">
                            <select class="form-control" name="listPayday" id="listPayday">
                            <?php
                            for($i = 1;$i < 28+1; $i++){
                              if($i == $contract['payday']){
                                echo '<option value="'.$i.'" selected>'.$i.'</option>';
                              }else{
                                echo '<option value="'.$i.'" >'.$i.'</option>';
                              }
                            }
                            ?>
                            </select>
                          </div>
                        </div>
                        <!--<div class="form-group row m-b-10 cont-create">
                          <label class="col-md-4 text-lg-right col-form-label">Crear factura</label>
                          <div class="col-md-6">
                            <select class="form-control" name="listInvoice" id="listInvoice">
                            <?php
                            for($i = 0;$i < 25+1; $i++){
                              if($i == $contract['create_invoice']){
                                if($contract['create_invoice'] == 0){
                                  echo '<option value="0" selected>Desactivado</option>';
                                }else if($contract['create_invoice'] == 1){
                                  echo '<option value="'.$i.'" selected>'.$i.' Día antes</option>';
                                }else{
                                  echo '<option value="'.$i.'" selected>'.$i.' Días antes</option>';
                                }
                              }else{
                                if($i == 0){
                                  echo '<option value="0">Desactivado</option>';
                                }else if($i == 1){
                                  echo '<option value="'.$i.'">'.$i.' Día antes</option>';
                                }else{
                                  echo '<option value="'.$i.'">'.$i.' Días antes</option>';
                                }
                              }
                            }
                            ?>
                            </select>
                          </div>
                        </div>-->
                        <div class="form-group row m-b-10 cont-gracia">
                          <label class="col-md-4 text-lg-right col-form-label">Dias de gracia</label>
                          <div class="col-md-6">
                            <select class="form-control" name="listDaysGrace" id="listDaysGrace">
                            <?php
                            for($i = 0;$i < 25+1; $i++){
                              if($i == $contract['days_grace']){
                                if($contract['days_grace'] == 1){
                                  echo '<option value="'.$i.'" selected>'.$i.' Día</option>';
                                }else{
                                  echo '<option value="'.$i.'" selected>'.$i.' Días</option>';
                                }
                              }else{
                                if($i == 1){
                                  echo '<option value="'.$i.'">'.$i.' Día</option>';
                                }else{
                                  echo '<option value="'.$i.'">'.$i.' Días</option>';
                                }
                              }
                            }
                            ?>
                            </select>
                            <small class="text-success text-uppercase">Días tolerancia para aplicar corte</small>
                           </div>
                        </div>
                        <div class="form-group row m-b-10 cont-chk">
                          <label class="col-md-4 text-lg-right col-form-label"></label>
                          <div class="col-md-6">
                            <div class="checkbox checkbox-css pt-0">
                              <input type="checkbox" id="chkDiscount" name="chkDiscount" value="1" <?php if($contract['discount']==1){echo 'checked';}?>>
                              <label for="chkDiscount" class="cursor-pointer m-0">Agregar descuento</label>
                            </div>
                            <small class="text-success text-uppercase">Solo aplica a facturas de servicios</small>
                          </div>
                        </div>
                        <div class="form-group row m-b-10 cont-dis">
                          <label class="col-md-4 text-lg-right col-form-label">Descuento</label>
                          <div class="col-md-6">
                            <input type="number" class="form-control" name="discount" id="discount" min="0" step="0.1" onkeypress="return numbers(event)" placeholder="0.00" value="<?= $contract['discount_price'] ?>">
                          </div>
                        </div>
                        <div class="form-group row m-b-10 cont-month">
                          <label class="col-md-4 text-lg-right col-form-label">Meses de descuento</label>
                          <div class="col-md-6">
                            <select class="form-control" name="listMonthDis" id="listMonthDis">
                            <?php
                            for($i = 1;$i < 12+1; $i++){
                              if($i == $contract['months_discount']){
                                if($contract['months_discount'] == 0){
                                  echo '<option value="'.$i.'" selected>'.$i.' Mes</option>';
                                }elseif($contract['months_discount'] == 1){
                                  echo '<option value="'.$i.'" selected>'.$i.' Mes</option>';
                                }else{
                                  echo '<option value="'.$i.'" selected>'.$i.' Meses</option>';
                                }
                              }else{
                                if($i == 1){
                                  echo '<option value="'.$i.'" >'.$i.' Mes</option>';
                                }else{
                                  echo '<option value="'.$i.'" >'.$i.' Meses</option>';
                                }
                              }
                            }
                            ?>
                            </select>
                          </div>
                        </div>
                        <div class="form-group row justify-content-center">
                          <button type="submit" class="btn btn-blue"><i class="fas fa-save mr-2"></i>Guardar Cambios</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="tickets-tab">
          <div class="row">
            <div id="list-ticket-btns-tools">
              <div class="options-group btn-group m-r-5">
              <?php if($_SESSION['permits_module']['r']){ ?>
                <button type="button" class="btn btn-white" onclick="add_ticket()"><i class="fas fa-plus mr-1"></i>Nuevo</button>
              <?php } ?>
              </div>
            </div>
            <div class="col-md-12 col-sm-12 col-12">
              <div class="table-responsive">
                <table id="list-ticket" class="table table-bordered dt-responsive nowrap dataTable dtr-inline collapsed" data-order='[[ 0, "asc" ]]' style="width: 100%;">
                  <thead>
                    <tr>
                      <th style="max-width: 20px !important; width: 20px;">Id</th>
                      <th>Asunto</th>
                      <th>F.programada</th>
                      <th>F.apertura</th>
                      <th>F.cierre</th>
                      <th>Prioridad</th>
                      <th>Tecnico</th>
                      <th class="all">Estado</th>
                      <th class="all" data-orderable="false" style="max-width: 40px !important; width: 40px;"></th>
                    </tr>
                  </thead>
                  <tbody></tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
       <div class="tab-pane fade" id="router-tab">
    <form class="row" onsubmit="updateRouter(event)" id="update_router">
        <div class="col-12">
            <div id="router" class="row align-items-center">
                <!-- Modem TP LINK -->
                <div class="col-12 col-md-5">
                    <h3>Modem TP LINK</h3>
                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="route_ssid" class="form-label">Red Wifi</label>
                            <input type="text" 
                                class="form-control" 
                                name="route_ssid" 
                                id="route_ssid"
                                data-parsley-required="true"
                                value="<?= $client['route_ssid'] ?>"
                            >
                        </div>
                        <div class="col-12">
                            <label for="route_password" class="form-label">Contraseña</label>
                            <input type="text" 
                                class="form-control" 
                                name="route_password" 
                                id="route_password"
                                data-parsley-required="true"
                                value="<?= $client['route_password'] ?>"
                            >
                        </div>
                    </div>
                </div>

                <!-- Línea divisoria vertical -->
                <div class="col-12 col-md-2 text-center my-4 my-md-0">
                    <div style="border-left: 3px solid #007bff; height: 100%; margin: auto;"></div>
                </div>

                <!-- Credenciales Zapping -->
                <div class="col-12 col-md-5">
                    <h3>Credenciales Zapping</h3>
                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="route_cred_user" class="form-label">Correo</label>
                            <input type="text" 
                                class="form-control" 
                                name="route_cred_user" 
                                id="route_cred_user"
                                data-parsley-required="true"
                                value="<?= $client['route_cred_user'] ?>"
                            >
                        </div>
                        <div class="col-12">
                            <label for="route_cred_password" class="form-label">Contraseña</label>
                            <input type="text" 
                                class="form-control" 
                                name="route_cred_password" 
                                id="route_cred_password"
                                data-parsley-required="true"
                                value="<?= $client['route_cred_password'] ?>"
                            >
                        </div>
                    </div>
                </div>

                <!-- Botón Guardar -->
                <div class="col-12 text-center mt-4">
                    <button class="btn btn-primary">
                        Guardar
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>


<input type="hidden" id="clientId" value="<?= $client['id'] ?>">
<!-- FIN TITULO -->
<?php footer($data); ?>
