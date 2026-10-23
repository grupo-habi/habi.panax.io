<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:state="http://panax.io/state"
  exclude-result-prefixes="state">
  <xsl:import href="../common.xslt"/>
  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:key name="values" match="contratos/row/@*[normalize-space(.) != '']" use="local-name()"/>
  <xsl:key name="interapas-tipo" match="contratos/row" use="normalize-space(@tipo)"/>
  <xsl:key name="interapas-contrato-tipo" match="contratos/row"
    use="concat(number(@id), '|', normalize-space(@tipo))"/>
  <xsl:key name="interapas-facturas" match="facturas/row"
    use="concat(number(@cuenta), '|', normalize-space(@tipo))"/>
  <xsl:variable name="interapas-money-mask" select="'$#,##0.00;-$#,##0.00'"/>

  <xsl:template match="/">
    <xsl:variable name="interapas-contratos" select="/*/contratos/row[generate-id() = generate-id(key('interapas-contrato-tipo', concat(number(@id), '|', normalize-space(@tipo)))[1])]"/>
    <xsl:variable name="interapas-facturas-visibles" select="/*/facturas/row[key('interapas-contrato-tipo', concat(number(@cuenta), '|', normalize-space(@tipo)))]"/>
    <main>
      <style><![CDATA[
        #reporte_interapas { font-family: "Segoe UI", sans-serif; font-size: 10pt; }
        #reporte_interapas .report-heading { display: flex; align-items: center; justify-content: center; gap: 2rem; margin: 1.5rem 0; }
        #reporte_interapas .report-heading img { width: 274px; height: 87px; object-fit: contain; }
        #reporte_interapas .report-heading p { max-width: 800px; text-align: center; font-weight: bold; }
        #reporte_interapas table { border-collapse: collapse; width: 100%; margin-inline: auto; }
        #reporte_interapas th, #reporte_interapas td { border: .5pt solid black; padding: 4px 7px; vertical-align: top; }
        #reporte_interapas thead th { background: #27c4d5; color: black; text-align: center; }
        #reporte_interapas .contract-type th { background: #e0f5f7; text-align: left; padding: 8px; }
        #reporte_interapas td { background: white; }
        #reporte_interapas .report-total > * { background: #edf8f9; font-weight: bold; }
        #reporte_interapas tfoot .report-total > * { background: #c7edf1; border-top: 2px solid black; }
        #reporte_interapas .number { text-align: right; white-space: nowrap; }
        #reporte_interapas .account { white-space: nowrap; }
        #reporte_interapas .invoices { min-width: 130px; }
        @media print { #reporte_interapas tbody { break-inside: auto; } #reporte_interapas tr { break-inside: avoid; } }
      ]]></style>
      <div id="reporte_interapas">
        <div class="report-heading">
          <img src="templates/reporte_interapas_files/PROMOCIONES%20HABI%2001.10.25_17904_image002.png" alt="Interapas"/>
          <p>ORGANISMO INTERMUNICIPAL METROPOLITANO DE AGUA POTABLE, ALCANTARILLADO, SANEAMIENTO Y SERVICIOS CONEXOS DE LOS MUNICIPIOS DE CERRO DE SAN PEDRO, SAN LUIS POTOSÍ Y SOLEDAD DE GRACIANO SÁNCHEZ (INTERAPAS)</p>
        </div>
        <table>
          <colgroup>
            <col class="cuenta">
              <xsl:if test="not(key('values', 'cuenta'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="titular">
              <xsl:if test="not(key('values', 'titular'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="domicilio">
              <xsl:if test="not(key('values', 'domicilio'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="municipio">
              <xsl:if test="not(key('values', 'municipio'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="municipio-cxc">
              <xsl:if test="not(key('values', 'municipio_cxc'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="meses-adeudo">
              <xsl:if test="not(key('values', 'meses_adeudo'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="adeudo-actual">
              <xsl:if test="not(key('values', 'adeudo_actual'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="concepto">
              <xsl:if test="not(key('values', 'concepto'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="responsable">
              <xsl:if test="not(key('values', 'responsable'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="proyecto">
              <xsl:if test="not(key('values', 'proyecto'))">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="facturas">
              <xsl:if test="not($interapas-facturas-visibles/@Folio[normalize-space(.) != ''])">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
            <col class="total-facturas">
              <xsl:if test="not($interapas-facturas-visibles/@Total[normalize-space(.) != ''])">
                <xsl:attribute name="style">visibility: collapse;</xsl:attribute>
              </xsl:if>
            </col>
          </colgroup>
          <thead class="freeze">
            <tr>
              <th scope="col">CUENTA</th>
              <th scope="col">TITULAR</th>
              <th scope="col">DOMICILIO</th>
              <th scope="col">MUNICIPIO</th>
              <th scope="col">MUNICIPIO CXC</th>
              <th scope="col">MESES ADEUDO</th>
              <th scope="col">ADEUDO ACTUAL</th>
              <th scope="col">CONCEPTO</th>
              <th scope="col">RESPONSABLE</th>
              <th scope="col">PROYECTO</th>
              <th scope="col">FACTURAS</th>
              <th scope="col">TOTAL FACTURAS</th>
            </tr>
          </thead>
          <xsl:for-each select="/*/contratos/row[generate-id() = generate-id(key('interapas-tipo', normalize-space(@tipo))[1])]">
            <xsl:sort select="number(@tipo = 'cambio_nombre')" data-type="number"/>
            <xsl:variable name="tipo" select="normalize-space(@tipo)"/>
            <xsl:variable name="contratos" select="$interapas-contratos[normalize-space(@tipo) = $tipo]"/>
            <tbody>
              <tr class="contract-type">
                <th colspan="12" scope="rowgroup">
                  <xsl:choose>
                    <xsl:when test="$tipo = 'cuotas' or $tipo = 'programacion_pagos'">Cuotas de disponibilidad</xsl:when>
                    <xsl:when test="$tipo = 'cambio_nombre'">Cambios de nombre</xsl:when>
                    <xsl:otherwise><xsl:value-of select="$tipo"/></xsl:otherwise>
                  </xsl:choose>
                </th>
              </tr>
              <xsl:apply-templates mode="interapas-row" select="$contratos"/>
              <xsl:call-template name="interapas-total">
                <xsl:with-param name="label" select="'Subtotal'"/>
                <xsl:with-param name="contratos" select="$contratos"/>
                <xsl:with-param name="facturas" select="$interapas-facturas-visibles[normalize-space(@tipo) = $tipo]"/>
              </xsl:call-template>
            </tbody>
          </xsl:for-each>
          <tfoot>
            <xsl:call-template name="interapas-total">
              <xsl:with-param name="label" select="'Total general'"/>
              <xsl:with-param name="contratos" select="$interapas-contratos"/>
              <xsl:with-param name="facturas" select="$interapas-facturas-visibles"/>
            </xsl:call-template>
          </tfoot>
        </table>
        <xsl:if test="not(/*/contratos/row)"><p>No hay contratos para los filtros seleccionados.</p></xsl:if>
      </div>
    </main>
  </xsl:template>

  <xsl:template match="contratos/row" mode="interapas-row">
    <xsl:variable name="facturas" select="key('interapas-facturas', concat(number(@id), '|', normalize-space(@tipo)))"/>
    <tr>
      <td class="account"><xsl:value-of select="@cuenta"/></td>
      <td><xsl:apply-templates select="@titular"/></td>
      <td><xsl:apply-templates select="@domicilio"/></td>
      <td><xsl:apply-templates select="@municipio"/></td>
      <td><xsl:apply-templates select="@municipio_cxc"/></td>
      <td class="number"><xsl:value-of select="@meses_adeudo"/></td>
      <td class="number"><xsl:if test="@adeudo_actual"><xsl:value-of select="format-number(@adeudo_actual, $interapas-money-mask)"/></xsl:if></td>
      <td><xsl:apply-templates select="@concepto"/></td>
      <td><xsl:apply-templates select="@responsable"/></td>
      <td><xsl:apply-templates select="@proyecto"/></td>
      <td class="invoices"><xsl:apply-templates select="$facturas/@Folio" mode="concat"/></td>
      <td class="number"><xsl:value-of select="format-number(sum($facturas/@Total), $interapas-money-mask)"/></td>
    </tr>
  </xsl:template>

  <xsl:template name="interapas-total">
    <xsl:param name="label"/>
    <xsl:param name="contratos"/>
    <xsl:param name="facturas"/>
    <tr class="report-total">
      <th colspan="5" scope="row"><xsl:value-of select="$label"/> (<xsl:value-of select="count($contratos)"/> contratos/tipo)</th>
      <td class="number"><xsl:value-of select="sum($contratos/@meses_adeudo)"/></td>
      <td class="number"><xsl:value-of select="format-number(sum($contratos/@adeudo_actual), $interapas-money-mask)"/></td>
      <td colspan="3"></td>
      <td class="number"><xsl:value-of select="count($facturas)"/> facturas</td>
      <td class="number"><xsl:value-of select="format-number(sum($facturas/@Total), $interapas-money-mask)"/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
