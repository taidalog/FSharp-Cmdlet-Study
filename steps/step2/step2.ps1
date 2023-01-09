$slnName = "FSharpCmdletStudy"
cd $slnName

@"
namespace $slnName

open System
open System.IO
open System.Management.Automation

[<Cmdlet(VerbsCommon.New, "Person")>]
type NewPersonCommand () =
    inherit PSCmdlet ()

    [<Parameter(Mandatory = true, Position = 0)>]
    member val FamilyName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 1)>]
    member val FirstName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 0)>]
    member val Language : string = "" with get, set

    override this.EndProcessing () =
        sprintf "%s %s uses %s." this.FamilyName this.FirstName this.Language 
        |> this.WriteObject
        base.EndProcessing ()
"@ | Out-File ./src/$slnName/step2.fs -Encoding utf8

# Add `<Compile Include="step2.fs" />` to `<ItemGroup>` in `.fsproj` file MANUALLY.
# Then `<ItemGroup>` in `.fsproj` will be as below:
#  <ItemGroup>
#    <Compile Include="Library.fs" />
#    <Compile Include="step2.fs" />
#  </ItemGroup>

# After editing, you can go on.

dotnet build
dotnet publish
Import-Module ./src/$slnName/bin/Debug/netstandard2.0/publish/$slnName.dll