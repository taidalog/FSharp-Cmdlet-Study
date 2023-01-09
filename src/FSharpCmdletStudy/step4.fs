namespace FSharpCmdletStudy

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
