namespace FSharpCmdletStudy

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
