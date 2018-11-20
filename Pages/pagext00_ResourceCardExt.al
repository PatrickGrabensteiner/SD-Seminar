pageextension 50100 "CSD ResourceCardExt" extends "Resource Card"
{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        addlast(General)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {
                ApplicationArea = All;
            }
            field("CSD Quantity per Day"; "CSD Quantity per Day")
            {
                ApplicationArea = All;
            }
        }
        addafter("Personal Data")
        {
            group("CSD Room")
            {

                Caption = 'Room';
                Visible = ShowMaxField;
                field("CSD Maximum Participants"; "CSD Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        ShowMaxField := (Type = Type::Machine);
        CurrPage.Update(false);
    end;

    trigger OnOpenPage()
    begin
        showType := rec.GetFilter(Type) <> '';
    end;

    var
        [InDataSet]
        showType: Boolean;
        [InDataSet]
        ShowMaxField: Boolean;

}