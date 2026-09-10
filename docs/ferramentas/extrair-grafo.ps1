$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$buildDirectory = Join-Path $projectRoot 'docs/.geracao'
[void][IO.Directory]::CreateDirectory($buildDirectory)
$appRoot = Join-Path $projectRoot 'MyController.device.xml.v3^\Plc Logic.plclogic.xml.v3^\Application.application.xml.v3^'
$records = @()
foreach ($f in Get-ChildItem -LiteralPath $appRoot -Recurse -File) {
  if ($f.Name -notmatch '\.(prg\.st|fb\.st|fn\.st|act\.st|gvl|struct|pou\.xml\.v3|poucheckfunction\.xml\.v3|varpersistent\.xml\.v3|task\.xml\.v3)$') { continue }
  $raw = [IO.File]::ReadAllText($f.FullName)
  $rel = $f.FullName.Substring($projectRoot.Length + 1)
  $decl = ''; $impl = ''; $calls = @(); $texts = @(); $task = $null
  if ($raw.Contains('__DECLARATION__')) {
    $part = ($raw -split '__DECLARATION__',2)[1]
    if ($part.Contains('__IMPLEMENTATION__')) { $parts = $part -split '__IMPLEMENTATION__',2; $decl=$parts[0]; $impl=$parts[1] } else { $decl=$part }
    $lang='ST'
  } elseif ($f.Name.EndsWith('.act.st')) {
    $impl=($raw -split '__IMPLEMENTATION__',2)[1]; $lang='ST'
  } else {
    [xml]$x = ($raw -split '__V3_CONTENT__',2)[1].TrimStart()
    if ($f.Name.EndsWith('.task.xml.v3')) {
      $task = @{
        name = $f.Name -replace '\.task\.xml\.v3$',''
        kind = $x.SelectSingleNode('/Single/Single[@Name="Kindoftask"]').InnerText
        priority = $x.SelectSingleNode('/Single/Single[@Name="Priority"]').InnerText
        interval = $x.SelectSingleNode('/Single/Single[@Name="Interval"]/Single[@Name="Time"]').InnerText + ' ' + $x.SelectSingleNode('/Single/Single[@Name="Interval"]/Single[@Name="Unit"]').InnerText
        programs = @($x.SelectNodes('/Single/List[@Name="PouList"]/Single/Single[@Name="Name"]') | ForEach-Object {$_.InnerText})
      }; $lang='TASK'
    } else {
      $declNode=$x.SelectSingleNode('/Single/Single[@Name="Interface"]//Single[@Name="TextBlobForSerialisation"]')
      if (-not $declNode) { $declNode=$x.SelectSingleNode('//Single[@Name="TextBlobForSerialisation"]') }
      if($declNode){$decl=$declNode.InnerText}
      $bodyNode=$x.SelectSingleNode('/Single/Single[@Name="Implementation"]//Single[@Name="TextBlobForSerialisation"]')
      if($bodyNode){$impl=$bodyNode.InnerText; $lang='ST'} elseif($f.Name.EndsWith('.varpersistent.xml.v3')) {$lang='ST'} else {
        $lang='CFC'
        foreach($item in $x.SelectNodes('/Single/Single[@Name="Implementation"]/Single[@Name="Items"]/List2/Single')){
          $kind=$item.SelectSingleNode('Single[@Name="KindOfCall"]')
          if($kind){
            $ts=@($item.SelectNodes('Single[@Name="Texts"]/List2/Single/Single[@Name="Text"]')|ForEach-Object{$_.InnerText})
            $calls+=@{kind=$kind.InnerText; type=$ts[-2]; instance=$ts[-1]; texts=$ts; id=$item.SelectSingleNode('Single[@Name="Id"]').InnerText}
          } else {
            $expr=$item.SelectSingleNode('Single[@Name="Text"]/Single[@Name="Text"][@Type="string"]')
            if($expr){$texts+=@{text=$expr.InnerText; id=$item.SelectSingleNode('Single[@Name="Id"]').InnerText; type=$item.GetAttribute('Type')}}
          }
        }
      }
    }
  }
  $records+=@{path=$rel; file=$f.Name; decl=$decl; impl=$impl; lang=$lang; calls=$calls; texts=$texts; task=$task; sha256=(Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash.ToLowerInvariant()}
}
$target=Join-Path $buildDirectory 'grafo-entrada.json'
[IO.File]::WriteAllText($target,($records|ConvertTo-Json -Depth 30),[Text.UTF8Encoding]::new($false))
$records | Group-Object lang | ForEach-Object { '{0}: {1}' -f $_.Name,$_.Count }
$records | Where-Object task | ForEach-Object { $_.task|ConvertTo-Json -Compress }
