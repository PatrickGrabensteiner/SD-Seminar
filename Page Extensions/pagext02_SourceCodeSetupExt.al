pageextension 50102 "CSD SourceCodeSetupExt" extends "Source Code Setup"
{
    layout
    {
        addlast(Content)
        {
            group("CSD SeminarGroup")
            {
                Caption = 'Seminar';
                field(Seminar; "CSD Seminar")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}