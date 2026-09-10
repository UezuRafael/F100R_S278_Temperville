[CmdletBinding()]
param(
    [string]$JavaPath = '',
    [string]$NodePath = 'node'
)
$ErrorActionPreference = 'Stop'
$projectDirectory = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$buildDirectory = Join-Path $projectDirectory 'docs/.geracao'
$diagramDirectory = Join-Path $projectDirectory 'docs/diagramas'
$plantumlJar = Join-Path $PSScriptRoot 'vendor/plantuml-1.2026.6.jar'

# Verifica os pré-requisitos antes de atualizar os arquivos gerados.
if (!(Test-Path -LiteralPath $plantumlJar -PathType Leaf)) {
    throw "PlantUML não encontrado no projeto: $plantumlJar"
}
$expectedHash = 'E620AE095A2BA0134D3C33FD5AE34FF01E785F3DF1796C0898802B8761A033A8'
if ((Get-FileHash -LiteralPath $plantumlJar -Algorithm SHA256).Hash -ne $expectedHash) {
    throw 'O JAR do PlantUML difere da versão registrada em vendor/README.md.'
}
$nodeCommand = Get-Command $NodePath -CommandType Application -ErrorAction SilentlyContinue
if (!$nodeCommand) { throw 'Node.js não encontrado. Instale Node.js ou informe -NodePath com o caminho de node.exe.' }
$nodeExecutable = $nodeCommand.Source
if (!$JavaPath) {
    $javaCommand = Get-Command java -CommandType Application -ErrorAction SilentlyContinue
    if ($javaCommand) { $JavaPath = $javaCommand.Source }
    elseif ($env:JAVA_HOME -and (Test-Path -LiteralPath (Join-Path $env:JAVA_HOME 'bin/java.exe'))) {
        $JavaPath = Join-Path $env:JAVA_HOME 'bin/java.exe'
    } else {
        # Runtime já instalado nesta estação; nenhuma cópia do Codex é necessária.
        $installedJava = Join-Path $env:ProgramFiles 'ProsysOPC/Prosys OPC UA Monitor/jre/bin/java.exe'
        if (Test-Path -LiteralPath $installedJava -PathType Leaf) { $JavaPath = $installedJava }
    }
}
if (!$JavaPath) { throw 'Java não encontrado. Instale Java 17 ou informe -JavaPath com o caminho de java.exe.' }
$javaCommand = Get-Command $JavaPath -CommandType Application -ErrorAction SilentlyContinue
if (!$javaCommand) { throw "Java não encontrado: $JavaPath" }
$javaExecutable = $javaCommand.Source

function Invoke-Generator([string]$Executable, [string[]]$Arguments) {
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) { throw "A geração falhou com código $LASTEXITCODE ao executar $Executable." }
}

[void][IO.Directory]::CreateDirectory($buildDirectory)
$javaTemporaryDirectory = Join-Path $buildDirectory 'java'
[void][IO.Directory]::CreateDirectory($javaTemporaryDirectory)

Write-Output 'Extraindo os objetos e as relações da aplicação...'
& (Join-Path $PSScriptRoot 'extrair-grafo.ps1')
Invoke-Generator $nodeExecutable @((Join-Path $PSScriptRoot 'analisar-grafo.cjs'))
Invoke-Generator $nodeExecutable @((Join-Path $PSScriptRoot 'gerar-plantuml-geral.cjs'))

Write-Output 'Renderizando os diagramas com o PlantUML do projeto...'
$javaArguments = @('-Djava.awt.headless=true', '-Xmx2048m', "-Djava.io.tmpdir=$javaTemporaryDirectory", '-jar', $plantumlJar, '-charset', 'UTF-8')
Invoke-Generator $javaExecutable ($javaArguments + @('-tsvg', (Join-Path $diagramDirectory '01-modulos-responsabilidades.puml'), (Join-Path $diagramDirectory '02-dependencias-geral.puml')))
Invoke-Generator $javaExecutable ($javaArguments + @('-tpng', (Join-Path $diagramDirectory '01-modulos-responsabilidades.puml')))
& (Join-Path $PSScriptRoot 'organizar-diagrama.ps1')
Invoke-Generator $nodeExecutable @((Join-Path $PSScriptRoot 'montar-visualizador.cjs'))
Invoke-Generator $nodeExecutable @((Join-Path $PSScriptRoot 'verificar-diagrama.cjs'))
Write-Output ('Concluído: ' + (Join-Path $diagramDirectory '02-dependencias-geral.html'))
