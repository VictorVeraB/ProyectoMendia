<div id="modal-action-files" class="modal fade" role="dialog" style="display: none;">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h6 class="modal-title text-uppercase" id="file-text-title">Información del MikroTik</h6>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Información General -->
        <div class="mb-4">
          <h5 class="text-primary">Información General</h5>
          <table class="table table-striped">
            <tr>
              <th>ID:</th>
              <td id="mikrotik-id"></td>
            </tr>
            <tr>
              <th>Nombre:</th>
              <td id="mikrotik-name"></td>
            </tr>
            <tr>
              <th>Dirección IP:</th>
              <td id="mikrotik-ip"></td>
            </tr>
            <tr>
              <th>Puerto:</th>
              <td id="mikrotik-port"></td>
            </tr>
            <tr>
              <th>Versión del Sistema:</th>
              <td id="mikrotik-version"></td>
            </tr>
            <tr>
              <th>Tiempo Activo:</th>
              <td id="mikrotik-uptime"></td>
            </tr>
            <tr>
              <th>Modelo:</th>
              <td id="mikrotik-model"></td>
            </tr>
            <tr>
              <th>Identidad:</th>
              <td id="mikrotik-identity"></td>
            </tr>
          </table>
        </div>

        <!-- Interfaces -->
        <div class="mb-4">
          <h5 class="text-primary">Interfaces</h5>
          <div id="mikrotik-interfaces" class="pl-3">
            <ul class="list-unstyled"></ul>
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
