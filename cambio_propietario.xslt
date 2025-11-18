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
xmlns:xo="http://panax.io/xover"
>
   <xsl:import href="keys.xslt"/>
   <xsl:import href="common.xslt"/>
   <xsl:import href="functions.xslt"/>

   <xsl:param name="state:editable"></xsl:param>
	 <xsl:template match="/">

    <main>
      <style><![CDATA[
        #reporte_interapas tbody td {
          padding-inline: 5pt
        }]]>
      </style>
      <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
      <style id="PROMOCIONES HABI 01.10.25_17904_Styles">
        &amp;lt;!--table
        {mso-displayed-decimal-separator:"\.";
        mso-displayed-thousand-separator:"\,";}
        .font517904
        {color:black;
        font-size:10.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;}
        .xl1517904
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:11.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri;
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl6317904
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:11.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:top;
        border:.5pt solid black;
        background:#2ACADE;
        mso-pattern:#2ACADE none;
        white-space:normal;}
        .xl6417904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:top;
        border:.5pt solid black;
        background:white;
        mso-pattern:white none;
        white-space:normal;}
        .xl6517904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:"\[$-1080A\]\#\,\#\#0\;\\-\#\,\#\#0";
        text-align:right;
        vertical-align:top;
        border:.5pt solid black;
        background:white;
        mso-pattern:white none;
        white-space:normal;}
        .xl6617904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:right;
        vertical-align:top;
        border:.5pt solid black;
        background:whitesmoke;
        mso-pattern:whitesmoke none;
        white-space:normal;}
        .xl6717904
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:11.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri;
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:top;
        border-top:.5pt solid black;
        border-right:.5pt solid black;
        border-bottom:.5pt solid black;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl6817904
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:11.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri;
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:top;
        border-top:.5pt solid black;
        border-right:none;
        border-bottom:.5pt solid black;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl6917904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:"\[$-1080A\]\0022$\0022\#\,\#\#0\.00";
        text-align:right;
        vertical-align:top;
        border:.5pt solid black;
        background:white;
        mso-pattern:white none;
        white-space:normal;}
        .xl7017904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:"\[$-1080A\]\#\,\#\#0\;\\-\#\,\#\#0";
        text-align:right;
        vertical-align:top;
        border:.5pt solid black;
        background:whitesmoke;
        mso-pattern:whitesmoke none;
        white-space:normal;}
        .xl7117904
        {padding:0px;
        mso-ignore:padding;
        color:#333333;
        font-size:10.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:"\[$-1080A\]\0022$\0022\#\,\#\#0\.00";
        text-align:right;
        vertical-align:top;
        border:.5pt solid black;
        background:whitesmoke;
        mso-pattern:whitesmoke none;
        white-space:normal;}
        .xl7217904
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:10.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl7317904
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:10.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Segoe UI";
        mso-generic-font-family:auto;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border:.5pt solid black;
        background:#2ACADE;
        mso-pattern:#2ACADE none;
        white-space:normal;}
        --&amp;gt;
      </style>

      <!--[if !excel]>&nbsp;&nbsp;<![endif]-->
      <!--The following information was generated by Microsoft Excel's Publish as Web
Page wizard.-->
      <!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->

      <div id="reporte_interapas" align="center" x:publishsource="Excel">

        <table border="0" cellpadding="0" cellspacing="0" width="1332" style="border-collapse:&#10; collapse;">
          <!--<colgroup>
            <col width="12" style="mso-width-source:userset;mso-width-alt:438;width:9pt" />
            <col width="15" style="mso-width-source:userset;mso-width-alt:548;width:11pt" />
            <col width="78" style="mso-width-source:userset;mso-width-alt:2852;width:59pt" />
            <col width="100" style="mso-width-source:userset;mso-width-alt:7204;width:148pt" />
            <col width="11" style="mso-width-source:userset;mso-width-alt:402;width:8pt" />
            <col width="0" style="display:none;mso-width-source:userset;mso-width-alt:2267" />
            <col width="305" style="mso-width-source:userset;mso-width-alt:11154;width:229pt" />
            <col width="199" style="mso-width-source:userset;mso-width-alt:7277;width:149pt" />
            <col width="202" style="mso-width-source:userset;mso-width-alt:7387;width:152pt" />
            <col width="79" style="mso-width-source:userset;mso-width-alt:2889;width:59pt" />
            <col width="113" style="mso-width-source:userset;mso-width-alt:4132;width:85pt" />
            <col width="10" style="mso-width-source:userset;mso-width-alt:365;width:8pt" />
            <col width="0" style="display:none;mso-width-source:userset;mso-width-alt:0" />
            <col width="91" style="mso-width-source:userset;mso-width-alt:3328;width:68pt" />
            <col width="0" style="display:none;mso-width-source:userset;mso-width-alt:36" />
            <col width="20" style="mso-width-source:userset;mso-width-alt:731;width:15pt" />
          </colgroup>-->
          <thead>
            <tr height="22" style="mso-height-source:userset;height:16.7pt">
              <td height="22" class="xl1517904" width="12" style="height:16.7pt;width:9pt"></td>
              <td class="xl1517904" width="15" style="width:11pt"></td>
              <td class="xl1517904" width="78" style="width:59pt"></td>
              <td class="xl1517904" width="197" style="width:138pt"></td>
              <td class="xl1517904" width="11" style="width:8pt"></td>
              <td class="xl1517904" width="0"></td>
              <td class="xl1517904" width="305" style="width:229pt"></td>
              <td class="xl1517904" width="199" style="width:149pt"></td>
              <td class="xl1517904" width="202" style="width:152pt"></td>
              <td class="xl1517904" width="79" style="width:59pt"></td>
              <td class="xl1517904" width="113" style="width:85pt"></td>
              <td class="xl1517904" width="10" style="width:8pt"></td>
              <td class="xl1517904" width="0"></td>
              <td class="xl1517904" width="91" style="width:68pt"></td>
              <td class="xl1517904" width="0"></td>
              <td class="xl1517904" width="20" style="width:15pt"></td>
            </tr>
            <tr height="4" style="mso-height-source:userset;height:3.0pt">
              <td height="4" class="xl1517904" style="height:3.0pt"></td>
              <td class="xl1517904"></td>
              <td colspan="3" rowspan="4" height="104" width="275" style="height:79.2pt;width:207pt" align="left" valign="top">
                <!--[if !vml]-->
                <span style="mso-ignore:vglayout;&#10;  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:274px;&#10;  height:87px">
                  <img width="274" height="87" src="templates/reporte_interapas_files/PROMOCIONES%20HABI%2001.10.25_17904_image002.png" v:shapes="Picture_x0020_1" />
                </span>
                <!--[endif]-->
                <span style="mso-ignore:vglayout2">
                  <table cellpadding="0" cellspacing="0">
                    <tbody>
                      <tr>
                        <td colspan="2" rowspan="4" height="104" class="xl1517904" width="275" style="height:79.2pt;width:207pt"></td>
                      </tr>
                    </tbody>
                  </table>
                </span>
              </td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="76" style="mso-height-source:userset;height:57.6pt">
              <td height="76" class="xl1517904" style="height:57.6pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td colspan="3" class="xl7217904" dir="LTR" width="908" style="width:682pt">
                <br />
                <font class="font517904">
                  ORGANISMO INTERMUNICIPAL METROPOLITANO DE AGUA
                  POTABLE, ALCANTARILLADO, SANEAMIENTO Y SERVICIOS CONEXOS DE LOS MUNICIPIOS DE
                  CERRO DE SAN PEDRO, SAN LUIS POTOSI Y SOLEDAD DE GRACIANO SANCHEZ (INTERAPAS)
                </font>
              </td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="20" style="mso-height-source:userset;height:15.6pt">
              <td height="20" class="xl1517904" style="height:15.6pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td colspan="3" class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="4" style="mso-height-source:userset;height:3.0pt">
              <td height="4" class="xl1517904" style="height:3.0pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="1" style="mso-height-source:userset;height:.95pt">
              <td height="1" class="xl1517904" style="height:.95pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="2" style="mso-height-source:userset;height:2.1pt">
              <td height="2" class="xl1517904" style="height:2.1pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="5" style="mso-height-source:userset;height:4.35pt">
              <td height="5" class="xl1517904" style="height:4.35pt"></td>
              <td colspan="9" class="xl7317904" dir="LTR" width="1300" style="width:976pt"> </td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="6" style="mso-height-source:userset;height:5.1pt">
              <td height="6" class="xl1517904" style="height:5.1pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="44" style="height:33.0pt" class="freeze">
              <td height="44" class="xl1517904" style="height:33.0pt"></td>
              <td colspan="2" class="xl6317904" dir="LTR" width="93" style="width:70pt">PROYECTO</td>
              <td colspan="3" class="xl6317904" dir="LTR" width="208" style="border-left:none;&#10;  width:100pt">CUENTA</td>
              <td class="xl6317904" dir="LTR" width="305" style="border-left:none;width:229pt">INMUEBLE</td>
              <td class="xl6317904" dir="LTR" width="199" style="border-left:none;width:149pt">ADQUIRIENTE</td>
							 <td class="xl6317904" dir="LTR" width="202" style="border-left:none;width:152pt">
									CUOTA
							 </td>
							 <td class="xl6317904" dir="LTR" width="202" style="border-left:none;width:152pt">
									FACTURA
							 </td>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="//contratos/row">
              <tr height="38" style="height:28.5pt">
                <td height="38" class="xl1517904" style="height:28.5pt"></td>
                <td colspan="2" class="xl6417904" dir="LTR" width="93" style="width:70pt">
                  <xsl:apply-templates select="@proyecto"/>
                </td>
                <td colspan="3" class="xl6417904" dir="LTR" width="208" style="border-left:none;&#10;  width:156pt">
									 <xsl:apply-templates select="@cuenta"/>
                </td>
								 <td class="xl6417904" dir="LTR" width="305" style="border-top:none;border-left:&#10;  none;width:229pt">
										<xsl:apply-templates select="@domicilio"/>
								 </td>
								 <td class="xl6417904" dir="LTR" width="305" style="border-top:none;border-left:&#10;  none;width:229pt">
										<xsl:apply-templates select="@titular"/>
								 </td>
							 <td class="xl6417904" dir="LTR" width="91" style="border-top:none;width:68pt">
									<xsl:apply-templates select="@adeudo_actual"/>
							 </td>
							 <td class="xl6417904" dir="LTR" width="91" style="border-top:none;width:68pt">
									<xsl:apply-templates mode="concat" select="//facturas/row[@NumeroContrato=number(current()/@cuenta)]/@Folio">
										 <xsl:with-param name="separator"/>
									</xsl:apply-templates>
							 </td>
              </tr>
            </xsl:for-each>
            <tr height="20" style="height:15.0pt">
              <td height="20" class="xl1517904" style="height:15.0pt"></td>
              <td colspan="2" class="xl6617904" dir="LTR" width="93" style="width:70pt">Total:</td>
              <td colspan="7" class="xl7017904" dir="LTR" width="993" style="border-left:none;&#10;  width:745pt">
                <xsl:value-of select="sum(@meses_adeudo)"/>
              </td>
              <td colspan="2" class="xl7117904" dir="LTR" width="123" style="border-left:none;&#10;  width:93pt">
                <xsl:call-template name="format">
                  <xsl:with-param name="value">
                    <xsl:value-of select="sum(//@adeudo_actual)"/>
                  </xsl:with-param>
                </xsl:call-template>
              </td>
              <td class="xl1517904"></td>
              <td class="xl6617904" dir="LTR" width="91" style="border-top:none;width:68pt"> </td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <tr height="19" style="mso-height-source:userset;height:14.25pt">
              <td height="19" class="xl1517904" style="height:14.25pt"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
              <td class="xl1517904"></td>
            </tr>
            <!--[if supportMisalignedColumns]-->
            <tr height="0" style="display:none">
              <td width="12" style="width:9pt"></td>
              <td width="15" style="width:11pt"></td>
              <td width="78" style="width:59pt"></td>
              <td width="197" style="width:148pt"></td>
              <td width="11" style="width:8pt"></td>
              <td width="0"></td>
              <td width="305" style="width:229pt"></td>
              <td width="199" style="width:149pt"></td>
              <td width="202" style="width:152pt"></td>
              <td width="79" style="width:59pt"></td>
              <td width="113" style="width:85pt"></td>
              <td width="10" style="width:8pt"></td>
              <td width="0"></td>
              <td width="91" style="width:68pt"></td>
              <td width="0"></td>
              <td width="20" style="width:15pt"></td>
            </tr>
            <!--[endif]-->
          </tbody>
        </table>

      </div>
    </main>
  </xsl:template>
</xsl:stylesheet>