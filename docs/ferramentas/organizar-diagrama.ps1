# Reorganiza o SVG do PlantUML em faixas horizontais, preservando objetos e relações.
$ErrorActionPreference = 'Stop'
$diagramDirectory = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../diagramas'))
$graphData = Get-Content -LiteralPath (Join-Path $diagramDirectory '02-dependencias-geral.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$svgPath = Join-Path $diagramDirectory '02-dependencias-geral.svg'
$document = New-Object System.Xml.XmlDocument
$document.XmlResolver = $null
$document.Load($svgPath)
$svg = $document.DocumentElement
$namespace = 'http://www.w3.org/2000/svg'
$namespaceManager = New-Object System.Xml.XmlNamespaceManager($document.NameTable)
$namespaceManager.AddNamespace('s', $namespace)
$culture = [System.Globalization.CultureInfo]::InvariantCulture
function Number($value) { [double]::Parse([string]$value, $culture) }
function Format-Number($value) { ([double]$value).ToString('0.###', $culture) }
function Element($name, $attributes) {
    $element = $document.CreateElement($name, $namespace)
    foreach ($key in $attributes.Keys) { $element.SetAttribute($key, [string]$attributes[$key]) }
    return ,$element
}
function Add-Text($parent, $x, $y, $text, $size = 16, $color = '#203248') {
    $element = Element 'text' @{x=(Format-Number $x); y=(Format-Number $y); 'font-family'='sans-serif'; 'font-size'=$size; fill=$color}
    $element.InnerText = $text
    [void]$parent.AppendChild($element)
}
$entities = @{}
$bounds = @{}
$packageIds = @{}
$packageTitles = @{}
foreach ($cluster in $svg.SelectNodes('.//s:g[@class="cluster"]', $namespaceManager)) {
    $packageTitles[$cluster.GetAttribute('data-qualified-name')] = $cluster.SelectSingleNode('s:text', $namespaceManager).InnerText
}
foreach ($entity in $svg.SelectNodes('.//s:g[@class="entity"]', $namespaceManager)) {
    if ($entity.GetAttribute('data-qualified-name') -match '(PK\d+)\.(N\d+)$') {
        $packageId = $Matches[1]; $id = $Matches[2]
        $rect = $entity.SelectSingleNode('.//s:rect', $namespaceManager)
        $entities[$id] = $entity
        $packageIds[$id] = $packageId
        $bounds[$id] = @{x=(Number $rect.GetAttribute('x')); y=(Number $rect.GetAttribute('y')); width=(Number $rect.GetAttribute('width')); height=(Number $rect.GetAttribute('height'))}
    }
}
if ($entities.Count -ne $graphData.nodes.Count) { throw 'O SVG não contém todos os objetos do grafo.' }
$rows = @(
    @('Task Configuration.taskconfig.xml.v3^','01_Inicialização','02_Operação','03_Geral','00_FB'),
    @('04_PID','04_PID/HEAT/00_Main','04_PID/HEAT/10_Temperatura','04_PID/HEAT','05_TEMPERATURA','Dados globais e tipos'),
    @('06_Relógio','07_Energia','11_GestaoEnergetica','08_Testes','09_RedeCanOpen','10_EntradasSaidas','Verificações implícitas')
)
$knownGroups = @($rows | ForEach-Object { $_ })
$extraGroups = @($graphData.nodes.group | Select-Object -Unique | Where-Object { $_ -notin $knownGroups })
if ($extraGroups.Count) { $rows += ,$extraGroups }
$clusterLayer = Element 'g' @{}
$linkLayer = Element 'g' @{}
$entityLayer = Element 'g' @{}
$newBounds = @{}
$groupBounds = @{}
$horizontalNodeGap = 38
$verticalNodeGap = 94
$packageHeaderHeight = 120
$maximumWidth = 0; $rowY = 130
foreach ($row in $rows) {
    $groupX = 40; $rowHeight = 0
    foreach ($group in $row) {
        $members = @($graphData.nodes | Where-Object group -eq $group | Sort-Object name)
        if (!$members.Count) { continue }
        $columns = [int][math]::Ceiling([math]::Sqrt($members.Count))
        $lineCount = [int][math]::Ceiling($members.Count / [double]$columns)
        $cellWidth = ($members | ForEach-Object { $bounds[$_.id].width } | Measure-Object -Maximum).Maximum
        $cellHeight = ($members | ForEach-Object { $bounds[$_.id].height } | Measure-Object -Maximum).Maximum
        $packageId = $packageIds[$members[0].id]
        $title = $packageTitles[$packageId]
        $groupWidth = [math]::Max(48 + $columns * ($cellWidth + $horizontalNodeGap) - $horizontalNodeGap, 40 + $title.Length * 9)
        $groupHeight = $packageHeaderHeight + 24 + $lineCount * ($cellHeight + $verticalNodeGap) - $verticalNodeGap
        $groupBounds[$group] = @{x=$groupX;y=$rowY;width=$groupWidth;height=$groupHeight;rowY=$rowY}
        $cluster = Element 'g' @{class='cluster'; 'data-qualified-name'=$packageId; id=('cluster-' + $packageId)}
        [void]$cluster.AppendChild((Element 'rect' @{x=(Format-Number $groupX);y=(Format-Number $rowY);width=(Format-Number $groupWidth);height=(Format-Number $groupHeight);rx=8;fill='#FBFCFE';stroke='#B8C5D3';'stroke-width'=1.2}))
        Add-Text $cluster ($groupX + 24) ($rowY + 30) $title 17 '#17324D'
        [void]$clusterLayer.AppendChild($cluster)
        for ($index = 0; $index -lt $members.Count; $index++) {
            $id = $members[$index].id; $old = $bounds[$id]
            $x = $groupX + 24 + ($index % $columns) * ($cellWidth + $horizontalNodeGap) + ($cellWidth - $old.width) / 2
            $y = $rowY + $packageHeaderHeight + [math]::Floor($index / $columns) * ($cellHeight + $verticalNodeGap)
            $entity = $entities[$id]
            # Atualiza coordenadas; não usa transform, para manter busca/zoom por getBBox.
            foreach ($child in $entity.SelectNodes('.//*[@x or @y]')) {
                if ($child.HasAttribute('x')) { $child.SetAttribute('x', (Format-Number ((Number $child.GetAttribute('x')) + $x - $old.x))) }
                if ($child.HasAttribute('y')) { $child.SetAttribute('y', (Format-Number ((Number $child.GetAttribute('y')) + $y - $old.y))) }
            }
            $newBounds[$id] = @{x=$x;y=$y;width=$old.width;height=$old.height;group=$group}
            [void]$entityLayer.AppendChild($entity)
        }
        $groupX += $groupWidth + 104
        $rowHeight = [math]::Max($rowHeight, $groupHeight)
    }
    $maximumWidth = [math]::Max($maximumWidth, $groupX - 24)
    $rowY += $rowHeight + 170
}
$colors = @{call='#2762A6';'fb-call'='#19816A';global='#A87732';declares='#9973AF';comment='#AAAAAA';task='#243E68';state='#D35E7D'}
$outCounts = @{}; $inCounts = @{}; $outIndex = @{}; $inIndex = @{}
foreach ($edge in $graphData.visibleEdges) { $outCounts[$edge.from]++; $inCounts[$edge.to]++ }
$edgeIndex = 0
foreach ($edge in $graphData.visibleEdges) {
    $source = $newBounds[$edge.from]; $target = $newBounds[$edge.to]
    $sourceGroup = $groupBounds[$source.group]; $targetGroup = $groupBounds[$target.group]
    $sx = $source.x + $source.width * (0.15 + 0.7 * ($outIndex[$edge.from] + 0.5) / $outCounts[$edge.from])
    $tx = $target.x + $target.width * (0.15 + 0.7 * ($inIndex[$edge.to] + 0.5) / $inCounts[$edge.to])
    $outIndex[$edge.from]++; $inIndex[$edge.to]++
    $sy = $source.y; $ty = $target.y
    $offset = 12 + ($edgeIndex % 18) * 4.5
    $sourceLane = $sy - $offset; $targetLane = $ty - $offset
    if ($source.group -eq $target.group) {
        if ($sy -eq $ty) {
            $coordinates = @($sx,$sy,$sx,$sourceLane,$tx,$targetLane,$tx,$ty)
        } else {
            $rail = $sourceGroup.x - $offset
            $coordinates = @($sx,$sy,$sx,$sourceLane,$rail,$sourceLane,$rail,$targetLane,$tx,$targetLane,$tx,$ty)
        }
    } else {
        if ($targetGroup.x -gt $sourceGroup.x) {
            $sourceRail = $sourceGroup.x + $sourceGroup.width + $offset; $targetRail = $targetGroup.x - $offset
        } else {
            $sourceRail = $sourceGroup.x - $offset; $targetRail = $targetGroup.x + $targetGroup.width + $offset
        }
        $sourceRowLane = $sourceGroup.rowY - 20 - $offset
        $targetRowLane = $targetGroup.rowY - 20 - $offset
        $coordinates = @($sx,$sy,$sx,$sourceLane,$sourceRail,$sourceLane,$sourceRail,$sourceRowLane)
        if ($sourceGroup.rowY -ne $targetGroup.rowY) {
            $outerRail = $(if ($sourceRail + $targetRail -lt $maximumWidth) { 20 - $offset / 2 } else { $maximumWidth - 20 + $offset / 2 })
            $coordinates += @($outerRail,$sourceRowLane,$outerRail,$targetRowLane)
        }
        $coordinates += @($targetRail,$targetRowLane,$targetRail,$targetLane,$tx,$targetLane,$tx,$ty)
    }
    $arrow = @($tx,$ty,($tx - 3),($ty - 7),($tx + 3),($ty - 7))
    $points = @()
    for ($coordinate = 0; $coordinate -lt $coordinates.Count; $coordinate += 2) {
        $points += (Format-Number $coordinates[$coordinate]) + ',' + (Format-Number $coordinates[$coordinate + 1])
    }
    $link = Element 'g' @{class='link';id=('relation-' + $edgeIndex);'data-entity-1'=$entities[$edge.from].GetAttribute('id');'data-entity-2'=$entities[$edge.to].GetAttribute('id');'data-from'=$edge.from;'data-to'=$edge.to;'data-kind'=$edge.kind}
    $path = Element 'path' @{d=('M ' + ($points -join ' L '));fill='none';stroke=$colors[$edge.kind];'stroke-linejoin'='round';'vector-effect'='non-scaling-stroke';'stroke-width'=$(if ($edge.kind -eq 'task') { 2 } else { 1.1 })}
    if ($edge.kind -in @('global','declares','comment','state')) { $path.SetAttribute('stroke-dasharray','5,4') }
    [void]$link.AppendChild($path)
    [void]$link.AppendChild((Element 'polygon' @{points=(($arrow | ForEach-Object { Format-Number $_ }) -join ' ');fill=$colors[$edge.kind]}))
    if ($edge.kind -eq 'task') { Add-Text $link ($sx + 8) ($sy - 8) ([string]$edge.evidence[0].order) 11 $colors.task }
    [void]$linkLayer.AppendChild($link)
    $edgeIndex++
}
# Mantém os links sob os blocos para não atravessarem seus textos.
$svg.RemoveAll()
$svg.SetAttribute('xmlns:xlink','http://www.w3.org/1999/xlink')
$totalHeight = $rowY + 185
$svg.SetAttribute('viewBox', ('0 0 {0} {1}' -f (Format-Number $maximumWidth),(Format-Number $totalHeight)))
$svg.SetAttribute('width', (Format-Number $maximumWidth))
$svg.SetAttribute('height', (Format-Number $totalHeight))
$svg.SetAttribute('style', 'background:#FFFFFF;')
Add-Text $svg 40 48 'Temperville · Pertencimento e dependências' 30 '#17324D'
Add-Text $svg 40 83 '174 POUs + 4 ações · 5 tarefas · 25 objetos de dados · 730 relações · os pacotes representam a organização atual do projeto' 17
[void]$svg.AppendChild($clusterLayer)
[void]$svg.AppendChild($linkLayer)
[void]$svg.AppendChild($entityLayer)
Add-Text $svg 40 ($rowY + 5) 'Seta: dependente → dependência. O HTML abre com todas as linhas; use o modo de foco para isolar um bloco e suas relações.' 17
$legendX = 40
foreach ($entry in @(@('call','Chamada PRG / FC / ação',300),@('fb-call','Instância de FB',220),@('global','Variáveis globais',230),@('declares','Declaração de tipo',240),@('comment','Chamada comentada',275),@('task','Tarefa → programa (ordem)',350))) {
    Add-Text $svg $legendX ($rowY + 42) $entry[1] 16 $colors[$entry[0]]
    $legendX += $entry[2]
}
Add-Text $svg 40 ($rowY + 80) 'Passagem/têmpera integra a mesa de resfriamento. Fundo cinza: implementação ST sem instruções fora de comentários.' 16
Add-Text $svg 40 ($rowY + 113) 'Chamadas podem depender de IF/CASE. Referências globais não indicam leitura/escrita. Check... não recebe chamadas inferidas do compilador.' 16
Add-Text $svg 40 ($rowY + 146) 'Dependências externas e evidências constam no JSON. Leitura estática de 05/09/2026; a posição dos blocos não representa ordem de execução.' 16
$settings = New-Object System.Xml.XmlWriterSettings
$settings.Encoding = New-Object System.Text.UTF8Encoding($false)
$settings.Indent = $false
$writer = [System.Xml.XmlWriter]::Create($svgPath, $settings)
try { $document.Save($writer) } finally { $writer.Dispose() }
Write-Output "SVG organizado: $($entities.Count) objetos, $edgeIndex relações; $(Format-Number $maximumWidth) × $(Format-Number $totalHeight)."
