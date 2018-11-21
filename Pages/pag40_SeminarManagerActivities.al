page 50140 "CSD Seminar Manager Activities"
{
    PageType = CardPart;
    SourceTable="CSD Seminar Cue";
    Caption='Seminar Manager Activities';
    
    layout
    {
        area(Content)
        {
            cuegroup(Registrations)
            {
                Caption='Registrations';
                field(Planned; Planned)
                {
                    ApplicationArea = All;
                }
                field(Registered; Registered)
                {
                    ApplicationArea = All;
                }
                actions
                {
                    action(New)
                    {
                        Caption='New';
                        RunObject=page "CSD Seminar Registration";
                        RunPageMode=Create;
                    }
                }
            }
            cuegroup(ForPosting)
            {
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        if not get then
        begin
            init;
            Insert;
        end; 
    end;
}