table 50101 "CSD Seminar"
{
    LookupPageId = "CSD Seminar Card";
    DrillDownPageId = "CSD Seminar Card";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if xRec.Name <> Rec.Name then begin
                    if (UpperCase(xRec.Name) = "Search Name") OR
                        ("Search Name" = '') then begin
                        rec.Validate("Search Name", UpperCase(Name));
                    end;
                end;
            end;
        }
        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(60; "Search Name"; Text[50])
        {
            Caption = 'Search Name';
        }
        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(90; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist ("CSD Seminar Comment Line" where ("Table Name" = const ("Seminar"), "No." = Field ("No.")));
        }
        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }
        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            trigger OnValidate()
            begin
                if xRec."Gen. Prod. Posting Group" <> Rec."Gen. Prod. Posting Group" then begin
                    IF GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "Gen. Prod. Posting Group") then begin
                        VALIDATE("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
                    end;
                end;
            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(130; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        IF rec."No." = '' then BEGIN
            SeminarSetup.Get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Nos.", xrec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete()
    begin
        CommentLine.Reset;
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.DeleteAll;
    end;

    procedure AssistEdit(): Boolean;
    begin
        With Seminar do begin
            Seminar := Rec;
            SeminarSetup.Get;
            SeminarSetup.TestField("Seminar Nos.");
            IF NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Nos.", xrec."No. Series", "No. Series") then begin
                NoSeriesManagement.SetSeries("No.");
                rec := Seminar;
                exit(true);
            end;
        end;
    end;

    var
        SeminarSetup: Record "CSD Seminar Setup";
        CommentLine: Record "CSD Seminar Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesManagement: Codeunit NoSeriesManagement;

}