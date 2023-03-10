namespace FSharpCmdletStudy

open System
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
