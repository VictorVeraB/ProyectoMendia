<div id="modal-action" class="modal fade p-0" role="dialog" style="display: none;">
    <form autocomplete="off" name="transactions" id="transactions">
      <input type="hidden" id="type" value="create">
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
                        <label for="printing" class="control-label">
                          Ingrese IP <span class="text-danger">*</span>
                        </label>
                        <input 
                          type="text" 
                          class="form-control text-uppercase" 
                          name="ip"
                          onkeypress="return numbersandletters(event)" 
                          placeholder="INGRESE IP (255.255.255.255)" 
                          onchange="return changeIp(event)"
                          data-parsley-required="true"
                        >
                      </div>

                      <div class="col-md-12 form-group">
                        <label for="printing" class="control-label">
                          Ingrese Rango <span class="text-danger">*</span>
                        </label>
                        <input 
                          type="number" 
                          class="form-control text-uppercase" 
                          name="rango"
                          id="rango"
                          value="1"
                          onkeypress="return numbersandletters(event)" 
                          placeholder="INGRESE RANGO" 
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
