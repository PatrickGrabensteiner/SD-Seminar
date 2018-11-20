tableextension 50100 "CSD ResourceExt" extends Resource
{
    fields
    {
        field(50101; "CSD Resource Type"; Option)
        {
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External';
            Caption='Resource Type';
        }
        field(50102; "CSD Maximum Participants"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Participants';
        }
        field(50103; "CSD Quantity per Day"; Decimal)
        {
            Caption = 'Quantity per Day';
        }
        modify("Profit %")
        {
            trigger OnAfterValidate()
            begin
                TestField("Unit Cost");
            end;
        }
        modify(Type)
        {
            OptionCaption='Instructor,Room';
        }
    }
}