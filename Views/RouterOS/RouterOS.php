<?php
head($data);
modal("RouterOSModal", $data);
modal("RouterOS2Modal", $data);
?>
<pre id="columns" style="display: none;"><?php echo json_encode($data['columns']) ?></pre>
<input type="hidden" id="mikrotik_client" value="<?= $_SESSION['businessData']['mikrotik_client'] ?>">
<input type="hidden" id="mikrotik_token" value="<?= $_SESSION['businessData']['mikrotik_token'] ?>">
<!-- INICIO TITULO -->
<ol class="breadcrumb float-xl-right">
    <li class="breadcrumb-item"><a href="<?= base_url() ?>/dashboard"><?= $data['home_page'] ?></a></li>
    <li class="breadcrumb-item"><a href="javascript:window.history.back();"><?= $data['previous_page'] ?></a></li>
    <li class="breadcrumb-item active"><?= $data['actual_page'] ?></li>
</ol>
<h1 class="page-header"><?= $data['page_title'] ?></h1>
<div class="panel panel-default panel-runway2">
    <iframe title="routerOS" style="width: 100%; min-height: 80vh; border: 0px; padding: 0px;"
        src="<?= $_SESSION['businessData']['mikrotik_client'] . '?businessIdentify=' . $_SESSION['businessData']['mikrotik_token'] ?>">
    </iframe>
</div>
<!-- FIN TITULO -->
<?php footer($data); ?>