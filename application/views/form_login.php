<fieldset>
	<legend>Acceso</legend>
	<?php  echo form_open('login/entrar'); ?>
		<p><label>Usuario</label> <input type="text" name="email" id="email" /></p>
		<p><label>Contraseña</label> <input type="text" name="pwd" id="pwd" /></p>
		<p><input type="submit" value="Entrar" class="btn"></p>
	<?php echo form_close(); ?>
</fieldset>

