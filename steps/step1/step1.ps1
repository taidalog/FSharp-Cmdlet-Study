$slnName = "FSharpCmdletStudy"
mkdir $slnName
cd $slnName

dotnet new sln
dotnet new classlib --language "F#" --framework "netstandard2.0" --output src/$slnName
# DON'T REMOVE --framework "netstandard2.0"

dotnet sln add src/$slnName/$slnName.fsproj
dotnet add src/$slnName/$slnName.fsproj package PowerShellStandard.Library

@"
namespace $slnName

open System
open System.Management.Automation

[<Cmdlet(VerbsData.Out, "Twice")>]
type OutTwiceCommand () =
    inherit PSCmdlet ()

    [<Parameter>]
    member val InputString : string = "" with get, set

    override x.EndProcessing () =
        sprintf "%s %s" x.InputString x.InputString
        |> x.WriteObject
        base.EndProcessing ()
"@ | Out-File ./src/$slnName/Library.fs -Encoding utf8

dotnet build
dotnet publish
Import-Module ./src/$slnName/bin/Debug/netstandard2.0/publish/$slnName.dll