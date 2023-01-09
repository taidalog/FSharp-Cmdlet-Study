$slnName = "FSharpCmdletStudy"
cd $slnName

@"
namespace $slnName

[<Class>]
type Person(familyName : string, firstName : string, language : string) =
    member val FamilyName : string = familyName
    member val FirstName : string = firstName
    member val FullName : string = familyName + " " + firstName
    member val Language : string = language


open System
open System.Management.Automation

[<Cmdlet(VerbsCommon.New, "Person2")>]
type NewPerson2Command () =
    inherit PSCmdlet ()

    [<Parameter(Mandatory = true, Position = 0)>]
    member val FamilyName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 1)>]
    member val FirstName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 0)>]
    member val Language : string = "" with get, set

    override this.EndProcessing () =
        new Person(this.FamilyName, this.FirstName, this.Language) 
        |> this.WriteObject
        base.EndProcessing ()
"@ | Out-File ./src/$slnName/step3.fs -Encoding utf8

# Add `<Compile Include="step3.fs" />` to `<ItemGroup>` in `.fsproj` file MANUALLY.
# Then `<ItemGroup>` in `.fsproj` will be as below:
#  <ItemGroup>
#    <Compile Include="Library.fs" />
#    <Compile Include="step2.fs" />
#    <Compile Include="step3.fs" />
#  </ItemGroup>

# After editing, you can go on.

dotnet build
dotnet publish
Import-Module ./src/$slnName/bin/Debug/netstandard2.0/publish/$slnName.dll