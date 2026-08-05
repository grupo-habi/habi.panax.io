<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="http://panax.io/xover/javascript"
xmlns:session="http://panax.io/session"
xmlns:sitemap="http://panax.io/sitemap"
xmlns:shell="http://panax.io/shell"
xmlns:state="http://panax.io/state"
xmlns:visible="http://panax.io/state/visible"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns:v="urn:schemas-microsoft-com:office:excel"
xmlns:o="urn:schemas-microsoft-com:office:word"
xmlns:xo="http://panax.io/xover">

  <xsl:import href="../keys.xslt"/>
  <xsl:import href="../common.xslt"/>
  <xsl:import href="../functions.xslt"/>

	<xsl:param name="state:editable"></xsl:param>

  <xsl:template match="/">
    <main>
      <style>
        <![CDATA[
          #reporte_complementos_faltantes {
            width: 100%;
            font-family: "Segoe UI", Calibri, Arial, sans-serif;
          }
          #reporte_complementos_faltantes table {
            border-collapse: collapse;
            width: 100%;
            font-size: 10pt;
          }
          #reporte_complementos_faltantes th {
            background: #2ACADE;
            color: #000;
            border: .5pt solid #000;
            font-weight: 700;
            text-align: center;
            vertical-align: middle;
            padding: 4pt 5pt;
            white-space: normal;
          }
          #reporte_complementos_faltantes td {
            border: .5pt solid #000;
            padding: 3pt 5pt;
            vertical-align: top;
            white-space: normal;
          }
          #reporte_complementos_faltantes tbody tr:nth-child(even) td {
            background: whitesmoke;
          }
          #reporte_complementos_faltantes .num,
          #reporte_complementos_faltantes .money {
            text-align: right;
            white-space: nowrap;
          }
          #reporte_complementos_faltantes .date {
            text-align: center;
            white-space: nowrap;
          }
          #reporte_complementos_faltantes .uuid {
            font-size: 8.5pt;
            white-space: nowrap;
          }
          #reporte_complementos_faltantes tfoot td {
            font-weight: 700;
            background: #e9e9e9;
          }
          #reporte_complementos_faltantes .title {
            font-size: 16pt;
            font-weight: 700;
            margin: 8pt 0 2pt 0;
          }
          #reporte_complementos_faltantes .subtitle {
            font-size: 10pt;
            margin: 0 0 8pt 0;
            color: #555;
          }
          @media print {
            #reporte_complementos_faltantes th { position: static; }
            #reporte_complementos_faltantes table { font-size: 8pt; }
            #reporte_complementos_faltantes .uuid { font-size: 7pt; }
          }
        ]]>
      </style>

      <!--[if !mso]>
      <style>
        v\:* {behavior:url(#default#VML);}
        o\:* {behavior:url(#default#VML);}
        x\:* {behavior:url(#default#VML);}
        .shape {behavior:url(#default#VML);}
      </style>
      <![endif]-->

      <div id="reporte_complementos_faltantes" align="center" x:publishsource="Excel">
        <div class="subtitle">Facturas PPD sin complemento relacionado</div>

        <table border="0" cellpadding="0" cellspacing="0">
          <thead>
            <tr class="freeze">
              <th>Empresa</th>
              <th>CC</th>
              <th>Centro de costo</th>
              <th>Proyecto</th>
              <th>Contrarecibo</th>
              <th>Concepto</th>
              <th>Proveedor</th>
              <th>RFC</th>
              <th>Factura</th>
              <th>Fecha CR</th>
              <th>OC</th>
              <th>Tipo mov.</th>
              <th>UUID</th>
              <th>Monto pagado</th>
              <th>Fecha pago</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="//reporte/row | //model/reporte/row">
              <tr>
                <td><xsl:value-of select="@emp"/></td>
                <td><xsl:value-of select="@cc"/></td>
                <td><xsl:value-of select="@ccn"/></td>
                <td><xsl:value-of select="@cp"/></td>
                <td class="num"><xsl:value-of select="@fcr"/></td>
                <td><xsl:value-of select="@ccr"/></td>
                <td><xsl:value-of select="@prv"/></td>
                <td><xsl:value-of select="@rfc"/></td>
                <td><xsl:value-of select="@fac"/></td>
                <td class="date"><xsl:value-of select="@fcr_f"/></td>
                <td><xsl:value-of select="@oc"/></td>
                <td><xsl:value-of select="@tm"/></td>
                <td class="uuid"><xsl:apply-templates select="@uuid"/></td>
                <td class="money">
                  <xsl:call-template name="format">
                    <xsl:with-param name="value" select="@mp"/>
                  </xsl:call-template>
                </td>
                <td class="date"><xsl:value-of select="@fp"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="13">Total</td>
              <td class="money">
                <xsl:call-template name="format">
                  <xsl:with-param name="value" select="sum((//reporte/row | //model/reporte/row)/@mp)"/>
                </xsl:call-template>
              </td>
              <td></td>
            </tr>
          </tfoot>
        </table>
      </div>
    </main>
  </xsl:template>
</xsl:stylesheet>
