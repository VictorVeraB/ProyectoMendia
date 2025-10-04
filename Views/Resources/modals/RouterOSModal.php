<div id="modal-action" class="modal fade p-0" role="dialog" style="display: none;">
    <form autocomplete="off" name="transactions" id="transactions">
      <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
              <div class="modal-header">
                  <h6 class="modal-title text-uppercase" id="text-title"></h6>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                <div class="row">
                  <div class="col-md-12 form-group">
                    <label class="control-label text-uppercase">
                      Nombre <span class="text-danger">*</span>
                    </label>
                    <input 
                      type="text" 
                      class="form-control text-uppercase" 
                      id="nombre"
                      name="nombre"
                      onkeypress="return numbersandletters(event)" 
                      placeholder="NOMBRE Mikrotik" 
                      data-parsley-required="true"
                    >
                  </div>

                  <div class="col-md-12 form-group">
                    <label class="control-label text-uppercase">
                      Ingrese IP <span class="text-danger">*</span>
                    </label>
                    <input 
                      type="text" 
                      class="form-control text-uppercase" 
                      id="direccionIP"
                      name="direccionIP"
                      onkeypress="return numbersandletters(event)" 
                      placeholder="10.10.10.10" 
                      data-parsley-required="true"
                    >
                  </div>

                  <div class="col-md-12 form-group">
                    <label class="control-label text-uppercase">
                      Ingrese usuario <span class="text-danger">*</span>
                    </label>
                    <input 
                      type="text" 
                      class="form-control text-uppercase" 
                      name="usuario"
                      id="usuario"
                      onkeypress="return numbersandletters(event)" 
                      placeholder="USUARIO" 
                      data-parsley-required="true"
                    >
                  </div>

                  <div class="col-md-12 form-group">
                    <label class="control-label text-uppercase">
                      Ingrese contraseña <span class="text-danger">*</span>
                    </label>
                    <input 
                      type="text" 
                      class="form-control text-uppercase" 
                      name="clave"
                      id="clave"
                      onkeypress="return numbersandletters(event)" 
                      placeholder="contraseña" 
                      data-parsley-required="true"
                    >
                  </div>

                  <div class="col-md-12 form-group">
                    <label class="control-label text-uppercase">
                      Ingrese puerto <span class="text-danger">*</span>
                    </label>
                    <input 
                      type="text" 
                      class="form-control text-uppercase" 
                      name="puerto"
                      id="puerto"
                      onkeypress="return numbersandletters(event)" 
                      placeholder="8728" 
                      data-parsley-required="true"
                    >
                  </div>

                  
                </div>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal"></i>Cerrar</button>
                  <button type="submit" class="btn btn-blue">
                    <i class="fas fa-save mr-2"></i><span id="text-button"></span>
                  </button>
              </div>
          </div>
      </div>
    </form>
</div>
