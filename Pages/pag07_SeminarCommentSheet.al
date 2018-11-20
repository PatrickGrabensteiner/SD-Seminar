page 50107 "CSD Seminar Comment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "CSD Seminar Comment Line";
    InsertAllowed=false;
    Editable=false;
    DeleteAllowed=false;
    Caption = 'Seminar Comment List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;

                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}