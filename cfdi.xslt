<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cfdi="http://www.sat.gob.mx/cfd/4"
    xmlns:factura="http://panax.io/widget/factura"
	xmlns="http://www.w3.org/1999/xhtml"
>
	<xsl:import href="widgets/cfdi/cfdi.xslt"/>
	<xsl:template match="/">
		<dialog class="xover-component" open="">
			<form method="dialog" onsubmit="closest('dialog').remove()" style="width:100%; height:100%; padding:1rem;">
				<section>
					<xsl:apply-templates mode="factura:widget"/>
				</section>
				<menu style="margin-top:.5rem;">
					<button type="submit">Close</button>
				</menu>
			</form>		
		</dialog>
	</xsl:template>

	<xsl:template match="*" mode="cfdi:qr-code" priority="1">
		<xsl:param name="url">sin valor</xsl:param>
		<px-qrcode value="{$url}" size="160" ecc="H"> 
		</px-qrcode>
	</xsl:template>
</xsl:stylesheet>
