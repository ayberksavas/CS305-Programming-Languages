%{
#include <stdio.h>
void yyerror (const char *s) 
{
}
int yylex(void);
%}

%token tSTARTMEETING tENDMEETING tSTARTSUBMEETINGS tENDSUBMEETINGS tMEETINGNUMBER tDESCRIPTION tSTARTDATE tSTARTTIME tENDDATE tENDTIME tLOCATIONS tISRECURRING tFREQUENCY tREPETITIONCOUNT tDAILY tWEEKLY tMONTHLY tYEARLY tYES tNO tASSIGN tCOMMA tIDENTIFIER tSTRING tINTEGER tDATE tTIME


%%
meetingBlocks: meeting
|	meetingBlocks meeting;

meeting: tSTARTMEETING tSTRING meetingNumber description startDate startTime endDate endTime locations isRecurring optionals tENDMEETING;

meetingNumber: tMEETINGNUMBER tASSIGN tINTEGER;

description: tDESCRIPTION tASSIGN tSTRING;

startDate: tSTARTDATE tASSIGN tDATE;

startTime: tSTARTTIME tASSIGN tTIME;

endDate: tENDDATE tASSIGN tDATE;

endTime: tENDTIME tASSIGN tTIME;

locations: tLOCATIONS tASSIGN identifier_list;

identifier_list:tIDENTIFIER
|  identifier_list tCOMMA tIDENTIFIER;

isRecurring: tISRECURRING tASSIGN tYES
|  tISRECURRING tASSIGN tNO;

optionals:
|repetitionCount
|frequency
|frequency repetitionCount
|subMeetings
|frequency repetitionCount subMeetings;

frequency:	tFREQUENCY tASSIGN tDAILY
|	 tFREQUENCY tASSIGN tWEEKLY
|	 tFREQUENCY tASSIGN tMONTHLY
|	 tFREQUENCY tASSIGN tYEARLY;

repetitionCount:	tREPETITIONCOUNT tASSIGN tINTEGER;

subMeetings:	tSTARTSUBMEETINGS meetingBlocks tENDSUBMEETINGS;


%%


int main ()
{
if (yyparse())
{
// parse error
printf("ERROR\n");
return 1;
}
else
{
// successful parsing
printf("OK\n");
return 0;
}
}
