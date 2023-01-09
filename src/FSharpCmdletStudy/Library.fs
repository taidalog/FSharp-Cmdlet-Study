namespace FSharpCmdletStudy

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
