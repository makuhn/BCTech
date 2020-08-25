// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved. 
// Licensed under the MIT License. See License.txt in the project root for license information. 
// ------------------------------------------------------------------------------------------------

page 50103 "Latest Rates Factbox wRepeater"
{
    SourceTable = "Latest Currency Rate";
    SourceTableTemporary = true;
    PageType = ListPart;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    Caption = 'Latest currency rates repeater';

    layout
    {
        area(Content)
        {
            repeater(Rates)
            {
                field(Code; Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rate; Rate)
                {
                    ApplicationArea = Basic, Suite;
                    DecimalPlaces = 5;
                }
            }
        }
    }

    procedure InitTempTable(Results: Dictionary of [Text, Text])
    var
        CodeKey: Text;
    begin
        foreach CodeKey in Results.Keys do begin
            Code := CodeKey;
            Evaluate(Rate, Results.Get(CodeKey));
            if not Modify() then
                Insert();
        end;

        CurrPage.Update(false);
    end;

    procedure ResetTempTable()
    begin
        DeleteAll(false);
        CurrPage.Update(false);
    end;

    var
        BaseCurrencyCode: Code[10];
        PbtTaskId: Integer;
}