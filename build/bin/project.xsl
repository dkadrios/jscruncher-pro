<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="html" encoding="ISO-8859-1"/>

  <xsl:template match="Project" >
    <!-- define variables for manage and compress actions -->
    <xsl:variable name="vDoCompressFiles">
      <xsl:value-of select="DoCompressFiles" />
    </xsl:variable>

    <xsl:variable name="vDoManageFiles">
      <xsl:value-of select="DoManageFiles" />
    </xsl:variable>

    <!-- base html output -->
    <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <title>Untitled</title>
      <style type="text/css">
        body{
          background:white;
          overflow:auto;
        }
        body, td, th{font:10pt Tahoma;color:black}
        th{text-align:left;font-weight:bold}
        .settings th{text-align:left;vertical-align:top;background:#D9D9D9;font-weight:normal;width:150px}
        .settings td{vertical-align:top}
        .sectionTitle{
          margin-top:20px;
          color:white;
          font-weight:bold;
          font-size:12pt;
          background: url(titlebar.jpg) repeat-x;
          padding:2px 5px;
        }
        .sectionBody{margin-left:20px}
        h3{margin-bottom:0px}
      </style>
    </head>
    <body>
    <div style="width:200px;float:right">
      <div style="margin-bottom:5px">
        <a href="edit" style="padding-right:10px"><img src="edit.gif" alt="Edit" width="16" height="18" border="0" align="absmiddle" /></a>
        <a href="edit">Edit '<xsl:value-of select="@name" />'</a>
      </div>
      <div>
        <a href="run" style="padding-right:10px"><img src="run.gif" alt="Run" width="16" height="18" border="0" align="absmiddle" /></a>
        <a href="run" style="font-weight:bold">Run '<xsl:value-of select="@name" />'</a>
      </div>
    </div>
    
    <h2>Properties for '<xsl:value-of select="@name" />' project</h2>
    <hr />    

    <!-- conditionally add the parts we want -->
    <xsl:if test="$vDoCompressFiles='True'">
      <xsl:apply-templates select="FilesToCompress" />
    </xsl:if>

    <xsl:if test="$vDoManageFiles='True'">
      <xsl:apply-templates select="FilesToManage" />
    </xsl:if>
    
    </body>
    </html>
  </xsl:template>

  <!-- ================================================== -->

  <xsl:template match="FilesToCompress" >
    <xsl:if test="not(count(Item)=0)">
      <div class="sectionTitle">Compression</div>
      <div class="sectionBody">
        <h4>Files to Compress</h4>
        <table border="1" cellpadding="2" cellspacing="0">
        <tr>
          <th>Input folder</th>
          <th>Output folder</th>
          <th>Mask</th>
          <th>Subdirs</th>
          <th>Prefix</th>
          <th>Suffix</th>
        </tr>
        <xsl:for-each select="Item">
          <tr>
            <td><a target="_blank" href="file://{InputFolder}"><xsl:value-of select="InputFolder" /></a></td>
            <td><a target="_blank" href="file://{OutputFolder}"><xsl:value-of select="OutputFolder" /></a></td>
            <td><xsl:value-of select="Mask" /></td>
            <td align="center"><xsl:value-of select="DoSubDirs" /></td>
            <td><xsl:value-of select="Prefix" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
            <td><xsl:value-of select="Suffix" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          </tr>
        </xsl:for-each>
        </table>
        <xsl:apply-templates select="../Settings" mode="compress" />
      </div>
    </xsl:if>
    <xsl:if test="count(Item)=0">
      <div class="sectionBody">
        <xsl:apply-templates select="../Settings" mode="compress" />
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="FilesToManage" >
    <xsl:if test="not(count(Item)=0)">
      <div class="sectionTitle">Tag Management</div>
      <div class="sectionBody">
        <h4>Files to Manage</h4>
        <table border="1" cellpadding="2" cellspacing="0">
        <tr>
          <th>Input folder</th>
          <th>Output folder</th>
          <th>Mask</th>
          <th>Subdirs</th>
          <th>Prefix</th>
          <th>Suffix</th>
        </tr>
        <xsl:for-each select="Item">
          <tr>
            <td><a target="_blank" href="file://{InputFolder}"><xsl:value-of select="InputFolder" /></a></td>
            <td><a target="_blank" href="file://{OutputFolder}"><xsl:value-of select="OutputFolder" /></a></td>
            <td><xsl:value-of select="Mask" /></td>
            <td align="center"><xsl:value-of select="DoSubDirs" /></td>
            <td><xsl:value-of select="Prefix" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
            <td><xsl:value-of select="Suffix" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          </tr>
        </xsl:for-each>
        </table>
        <xsl:apply-templates select="../Settings" mode="manage" />
      </div>
    </xsl:if>
    <xsl:if test="count(Item)=0">
      <div class="sectionBody">
        <xsl:apply-templates select="../Settings" mode="manage" />
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Settings" mode="compress" >
    <xsl:variable name="vDoCompress">  <xsl:value-of select="Basic/DoCompress"  /> </xsl:variable>
    <xsl:variable name="vDoObfuscate"> <xsl:value-of select="Basic/DoObfuscate" /> </xsl:variable>
    <xsl:variable name="vDoPreamble">  <xsl:value-of select="Basic/DoPreamble"  /> </xsl:variable>

    <h3>Basic Settings</h3>
    <table class="settings">
      <!--<tr><th>Output folder:</th><td><a target="_blank" href="file://{Basic/OutputFolder}"><xsl:value-of select="Basic/OutputFolder" /></a></td></tr>-->
      <tr><th>Log folder</th><td><a target="_blank" href="file://{Basic/LogFolder}"><xsl:value-of select="Basic/LogFolder" /></a></td></tr>
      <!--<tr><th>File prefix</th><td><xsl:value-of select="Basic/Prefix" /></td></tr>
      <tr><th>File suffix</th><td><xsl:value-of select="Basic/Suffix" /></td></tr>-->
      <xsl:if test="$vDoPreamble='True'">
        <tr><th>Preamble</th><td style="font-family:courier new,monospace"><xsl:value-of select="Basic/Preamble" /></td></tr>
      </xsl:if>
    </table>

    <xsl:if test="$vDoCompress='True'">
      <h3>Compression Settings</h3>
      <table class="settings">
        <tr><th>Fix semicolons</th><td><xsl:value-of select="Basic/DoAutoFixSemicolons" /></td></tr>
        <!--<tr><th>Empty outputFolder</th><td><xsl:value-of select="Basic/DoEmptyOutputFolder" /></td></tr>-->
      </table>
      <h3>Compression Fine Tuning</h3>
      <table class="settings">
        <tr><th>Combine string literals</th><td><xsl:value-of select="FineTuning/CombineLiteralStrings" /></td>
            <th>Remove comments</th><td><xsl:value-of select="FineTuning/RemoveComments" /></td></tr>
        <tr><th>Remove extra semicolons</th><td><xsl:value-of select="FineTuning/RemoveExtraSemicolons" /></td>
            <th>Remove whitespace</th><td><xsl:value-of select="FineTuning/RemoveWhitespace" /></td></tr>
        <tr><th>Collapse space runs</th><td><xsl:value-of select="FineTuning/RemoveExtraSpaces" /></td>
            <th>Remove tabs</th><td><xsl:value-of select="FineTuning/RemoveTabs" /></td></tr>
        <tr><th>Remove linefeeds</th><td><xsl:value-of select="FineTuning/RemoveLineFeeds" /></td>
            <th>Remove carriage returns</th><td><xsl:value-of select="FineTuning/RemoveCarriageReturns" /></td></tr>
        <tr><th>Remove formfeeds</th><td><xsl:value-of select="FineTuning/RemoveFormFeeds" /></td></tr>
        <tr><th>No whitespace before</th><td><xsl:value-of select="PuctuationMarks/NoWhitespaceBefore" /></td></tr>
        <tr><th>No whitespace after</th><td><xsl:value-of select="PuctuationMarks/NoWhiteSpaceAfter" /></td></tr>
      </table>
    </xsl:if>

    <xsl:if test="$vDoObfuscate='True'">
      <h3>Obfuscation Settings</h3>
      <table class="settings">
        <tr><th>Map folder</th><td><a target="_blank" href="file://{Basic/MapFolder}"><xsl:value-of select="Basic/MapFolder" /></a></td></tr>
        <tr><th>User defined map</th><td><a target="_blank" href="file://{Basic/MapFolder}{Basic/UserDefinedMap}"><xsl:value-of select="Basic/UserDefinedMap" /></a></td></tr>
        <tr><th>Maps to use</th><td><xsl:value-of select="Basic/MapFilesToUse" /></td></tr>
        <!--<tr><th>Save log</th><td><xsl:value-of select="Basic/DoSaveObfuscationLog" /></td></tr>-->
      </table>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Settings" mode="manage" >
    <h3>Basic Settings</h3>
    <table class="settings">
      <tr><th>Turning on compression</th><td><xsl:value-of select="Basic/ManageUsesCompressed" /></td></tr>
    </table>
  </xsl:template>

</xsl:stylesheet> 