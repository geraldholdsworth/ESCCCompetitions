{-------------------------------------------------------------------------------
Calculate Annual Results
-------------------------------------------------------------------------------}
procedure TMainForm.OutputResults(output,results: Integer);
type
 Tmem_pos = Record
  Pos: Integer;
  equal: Boolean;
  Name: String;
  Score: Integer;
  Tally: String;
 end;
var
 photo,cat,author,place,i,j,pos,h,k: Integer;
 S,P,e,title: String;
 labels: array of array of TLabel;
 page: TTabSheet;
 SB: TScrollBox;
 p: array of Integer;
 ps: array of String;
 c: array of Boolean;
 equal: Boolean;
 labels: array of array of TLabel;
 buttons: array of array of TSpeedButton;
 mem_pos: array of array of Tmem_pos;
 F: TextFile;
begin
 SB:=nil;
 h:=0;
 if results=0 then //results=0 is monthly results
  RecalculateResults(comp_title.Tag);
 if results=1 then //results=1 is POY results
 begin
  //Blank the scores
  for author:=0 to Length(members)-1 do
   for cat:=0 to season.Num_categories-1 do
   begin
    members[author].Score[cat]:=0;
    members[author].Tally[cat]:=IntToPadStr(0,'0',season.a_Places_to_score*2);
   end;
  //Recalculate the results for all the competitions
  for i:=0 to season.Num_competitions-1 do
   RecalculateResults(i);
  //Go through each photograph and add up the scores
  for photo:=0 to Length(photographs)-1 do
  begin
   author:=photographs[photo].Author; //Get the author
   cat:=photographs[photo].Category;  //Get the category
   S:=photographs[photo].Position;    //Get the position
   if Copy(S,Length(S),1)='=' then
    S:=Copy(S,1,Length(S)-1);         //Remove the '='
   if S<>'' then                      //If photo was placed
   begin
    place:=StrToIntDef(S,1)-1;        //Convert to an integer
    if  (photographs[photo].Score>0)  //Only take note if score is >0
    and (place<season.a_Places_to_score) then //and within the places to score
    begin
     members[author].Score[cat]:=members[author].Score[cat]
                                +a_scoring[place];
     //We'll add up the positions they've acheived while we're here
     i:=StrToInt(Copy(members[author].Tally[cat],(place*2)+1,2));
     inc(i);
     members[author].Tally[cat]:=Copy(members[author].Tally[cat],0,place*2)
                                +IntToPadStr(i,'0',2)
                                +Copy(members[author].Tally[cat],((place+1)*2)+1);
    end;
   end;
  end;
 end;
 //Save the results
 SaveSeasonFile;
 //Set up the form/file/printer
 title:='';
 if results=0 then
  title:=competitions[comp_title.Tag].Title+' Competition';
 if results=1 then
  title:='Photographers of the Year';
 if output=1 then
 begin
  //First clear the form, should it already contain data
  For i:=0 to ResultsForm.pages.PageCount-1 do
   ResultsForm.pages.ActivePage.Free;
  //Then fill in the headers
  ResultsForm.Caption:=title+' Results';
  if results=0 then
   ResultsForm.header.Caption:=comp_title.Text+
                          ' ('+MonthList[competitions[comp_title.Tag].Month+1]+')';
  if results=1 then
   ResultsForm.header.Caption:=title;
  //Make room for the controls
  SetLength(labels,season.Num_categories);
  if results=0 then
   SetLength(buttons,season.Num_categories);
 end;
 if output=2 then
 begin
  //Create the file
  AssignFile(F,csv_Save.FileName);
  ReWrite(F);
 end;
 if output=3 then
 begin
  //Setup the printer
  Printer.Title:='ESCC Competitions '+title+' Results';
  Printer.Copies:=1;
  h:=Printer.PageHeight;
  Printer.BeginDoc;
 end;
 //This is a local copy of the members array, so we can re-sort it
 //And it's an array per category
 if results=1 then
  SetLength(mem_pos,season.Num_categories); 
 //Set up the form/file
 for cat:=0 to season.Num_categories-1 do
 begin
  if output=1 then //Display in a form
  begin
   //Create the page and scroll box
   page:=CreatePage(ResultsForm.pages,categories[cat]);
   SB:=CreateScrollBox(page);
   if results=1 then SetLength(labels[cat],length(members));
  end;
  if output=2 then //Save to a file
  begin
   if results=0 then
   begin
    //Write out the category name, and column headers
    WriteLn(F,'"'+categories[cat]+' Category"');
    S:='"Position","Photo Title","Photo Author","Photo ID","Score"';
    if not competitions[comp_title.Tag].Ext_judge then
     for i:=0 to season.m_Places_to_score-1 do
      S:=S+',"'+IntToPos(i+1)+'s"';
   end;
   if results=1 then
   begin
    WriteLn(F,'"'+categories[cat]+' Category"');
    S:='"Position","Photographer","Score"';
    for i:=0 to season.a_Places_to_score-1 do
     S:=S+',"'+IntToPos(i+1)+'s"';
   end;
   WriteLn(F,S);
  end;  
  if output=3 then
  begin
   //Print the header for each category
   Printer.Canvas.Draw(left_margin,top_margin,ESCCLogo.Picture.Graphic);
   Printer.Canvas.MoveTo(left_margin,top_margin);
   Printer.Canvas.Font.Color:=clBlue;
   PrintLine(season.Title+' season','Arial',24,-1,[fsBold]);
   PrintLine(title+' Results','Arial',20,-1,[fsBold]);
   PrintLine(categories[cat]+' Category','Arial',16,-1,[fsBold]);
   Printer.Canvas.Font.Color:=clBlack;
   Printer.Canvas.Pen.Color:=clRed;
   Printer.Canvas.MoveTo(left_margin,Printer.Canvas.PenPos.Y);
   Printer.Canvas.LineTo(Printer.PageWidth-right_margin,Printer.Canvas.PenPos.Y);
   Printer.Canvas.MoveTo(left_margin,Printer.Canvas.PenPos.Y+50);
  end;
  if results=1 then
  begin
   SetLength(mem_pos[cat],Length(members));
   //set up array for sorting
   SetLength(p,Length(members));
   //Set up array for checking if sorted
   SetLength(c,Length(members));
   for i:=1 to Length(members)-1 do
   begin
    //copy the scores
    p[i-1]:=members[i].Score[cat];
    //and reset the checks
    c[i-1]:=false;
   end;
   //Sort the scores
   ArraySort(p);
   //and update the placings in the local members array
   place:=0;
   for author:=0 to Length(p)-1 do
    for i:=1 to Length(members)-1 do
     if  (p[author]=members[i].Score[cat])
     and (not c[i-1])
     and (members[i].Score[cat]>0) then
     begin
      mem_pos[cat,place].Pos:=author+1;
      mem_pos[cat,place].Name:=MembersList[i];
      mem_pos[cat,place].Score:=members[i].Score[cat];
      mem_pos[cat,place].Tally:=IntToPadStr(100-author,'0',3)+members[i].Tally[cat];
      c[i-1]:=true;
      inc(place);
     end;
   //Split the equal places
   SetLength(ps,Length(mem_pos[cat]));
   //And reset the checks
   SetLength(c,Length(mem_pos[cat]));
   for i:=0 to Length(ps)-1 do
   begin
    ps[i]:=mem_pos[cat,i].Tally;
    c[i]:=false;
   end;
   ArraySort(ps);
   for place:=0 to Length(ps)-1 do
   begin
    equal:=false;
    for author:=0 to Length(mem_pos[cat])-1 do
     if  (ps[place]=mem_pos[cat,author].Tally)
     and (not c[author]) then
     begin
      mem_pos[cat,author].Pos:=place+1;
      mem_pos[cat,author].equal:=equal;
      //This marks them as equal placed, plus the one before
      if (equal) and (author>0) then
       mem_pos[cat,author-1].equal:=equal;
      equal:=True;
      c[author]:=True;
     end;
   end;
  end;  
  //Output the results
  i:=0; //Control number
  pos:=1; //position number
  place:=0;
  if results=0 then place:=Length(photographs)-1;
  if results=1 then place:=Length(mem_pos[cat])-1;
  repeat
   //We'll go through all the photos and find those relevant
   for j:=0 to place do
    if  ((photographs[j].Competition=comp_title.Tag)
     and (photographs[j].Category=cat) and results=0) or
     ((mem_pos[cat,j].Pos=place)
    and (mem_pos[cat,j].Score>0) and results=1) then
    begin
     P:='0';
     if results=0 then
     begin
      //then pick out those that are at position pos
      P:=photographs[j].Position;
      if Copy(P,Length(P),1)='=' then
      begin
       P:=Copy(P,1,Length(P)-1);
       e:=IntToPos(StrToInt(P))+'=';
      end
      else e:=IntToPos(StrToInt(P));
     end;
     if ((StrToInt(P)=pos) and (results=0))
     or (results=1) then
     begin
      if results=0 then
      begin
       if (output=1) or (output=3) then
        S:='"'+photographs[j].Title+'"'+
           ' by '+MembersList[photographs[j].Author]+
           ' ('+photographs[j].ID+')'+
           ' scored '+IntToStr(photographs[j].Score)+' points';
       if output=2 then
        S:='"'+photographs[j].Title+'",'+
           '"'+MembersList[photographs[j].Author]+'",'+
           '"'+photographs[j].ID+'",'+
           '"'+IntToStr(photographs[j].Score)+'"';
       if not competitions[comp_title.Tag].Ext_judge then
        if (output=2) or (output=3) then
         for k:=0 to season.m_places_to_score-1 do
         begin
          if output=2 then
           S:=S+',"'+Copy(photographs[j].Tally,(k*2)+1+3,2)+'"';
          if output=3 then
          begin
           if k>0 then S:=S+', ' else S:=S+' (';
           S:=S+IntToPos(k+1)+'s:'
               +IntToStr(StrToInt(Copy(photographs[j].Tally,(k*2)+1+3,2)));
           if k=season.m_Places_to_score-1 then S:=S+')';
           S:='"'+e+'",'+S;
          end;
         end;
       if (output=1) or (output=3) then S:=e+':'+S;
      end;
      if results=1 then
      begin
       if (output=1) or (output=3) then
       begin
        S:=IntToPos(pos);
        if mem_pos[cat,j].equal then S:=S+'=';
        S:=S+' '+mem_pos[cat,j].Name
            +' scored '+IntToStr(mem_pos[cat,j].Score)
            +' points';
       end;
       if output=2 then
       begin
        S:='"'+IntToPos(pos);
        if mem_pos[cat,j].equal then S:=S+'=';
        S:=S+'","'+mem_pos[cat,j].Name+'",'
            +'"'+IntToStr(mem_pos[cat,j].Score)+'"';
        for i:=0 to season.a_Places_to_score-1 do
         S:=S+',"'+Copy(mem_pos[cat,j].Tally,(i*2)+1+3,2)+'"';
       end;
       mem_pos[cat,j].Pos:=0;
      end;
      if output=1 then
      begin
       //Create the button, if required
       if results=0 then
        if not competitions[comp_title.Tag].Ext_judge then
        begin
         SetLength(buttons[cat],i+1);
         buttons[cat,i]:=CreateSpeedButton(i*20,j,SB);
         buttons[cat,i].Glyph:=ResultsForm.detail_results_btn.Glyph;
         buttons[cat,i].OnClick:=ShowTally;
        end;
       //Create the label and increase the counter
       SetLength(labels[cat],i+1);
       labels[cat,i]:=CreateLabel(S,20,i*20,SB);
      end;
      if output=2 then
       WriteLn(F,S);
      if output=3 then
      begin
       PrintLine(S,'Arial',10,left_margin,[]);
       if Printer.Canvas.PenPos.Y>h-bottom_margin-442 then
       begin
        PrintFooter;
        Printer.NewPage;
       end;
      end;
      inc(i);
     end;
    end;
   inc(pos);
   //continue until we have all our places (which could be more than what is expected)
  until ((((pos=season.m_Places_to_score+1) and (output=1))
     or ((i=Length(panl_ID[cat]))         and (output<>1))) and results=0)
     or ((pos=Length(mem_pos[cat])) and (results=1));  
  //End of category, so start a new page (if not on the last)
  if output=3 then
  begin
   PrintFooter;
   if cat<season.Num_categories-1 then Printer.NewPage;
  end;
 end;
 //Show the form or close down the file/print job
 if output=1 then
 begin
  ResultsForm.ShowModal;
  for i:=0 to ResultsForm.pages.PageCount-1 do
   ResultsForm.pages.ActivePage.Free;
 end;
 if output=2 then CloseFile(F);
 if output=3 then Printer.EndDoc;
end;