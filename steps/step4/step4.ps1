$slnName = "FSharpCmdletStudy"
cd $slnName

@"
namespace $slnName

open System
open System.Management.Automation

[<Cmdlet(VerbsCommon.New, "Person3")>]
type NewPerson3Command () =
    inherit PSCmdlet ()

    [<Parameter(Mandatory = true, Position = 0, ParameterSetName = "Separate")>]
    member val FamilyName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 1, ParameterSetName = "Separate")>]
    member val FirstName : string = "" with get, set

    [<Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true, ParameterSetName = "Joined")>]
    member val FullName : string = "" with get, set
    
    [<Parameter(Mandatory = true, Position = 2, ParameterSetName = "Separate")>]
    [<Parameter(Mandatory = true, Position = 1, ParameterSetName = "Joined")>]
    member val Language : string = "" with get, set

    override this.EndProcessing () =
        match this.ParameterSetName with
        | "Separate" ->
            new Person(this.FamilyName, this.FirstName, this.Language) 
            |> this.WriteObject
        
        | "Joined" ->
            let _familyName = (this.FullName.Split ' ')[0]
            let _firstName = (this.FullName.Split ' ')[1]
            
            new Person(_familyName, _firstName, this.Language) 
            |> this.WriteObject
        
        | _ -> ()
        
        base.EndProcessing ()
"@ | Out-File ./src/$slnName/step4.fs -Encoding utf8

# Add `<Compile Include="step4.fs" />` to `<ItemGroup>` in `.fsproj` file MANUALLY.
# Then `<ItemGroup>` in `.fsproj` will be as below:
#  <ItemGroup>
#    <Compile Include="Library.fs" />
#    <Compile Include="step2.fs" />
#    <Compile Include="step3.fs" />
#    <Compile Include="step4.fs" />
#  </ItemGroup>

# After editing, you can go on.

dotnet build
dotnet publish
Import-Module ./src/$slnName/bin/Debug/netstandard2.0/publish/$slnName.dll