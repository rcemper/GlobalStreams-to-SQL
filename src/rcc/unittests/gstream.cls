Class rcc.unittests.gstream Extends %UnitTest.TestCase
{

Method OnAfterAllTests() As %Status
{
  kill ^||UnitTestS
  quit $$$OK
}

Method OnBeforeAllTests() As %Status
{
 kill ^||UnitTestS
 quit $$$OK
}

Method TestLoad() As %Status
{
 set ch=##class(%Stream.GlobalCharacter).%New()
    ,ch.%Location="^||UnitTestS"      
 set sc=ch.WriteLine(##class(rcc.gstream).lorem())
 if sc set sc=ch.%Save()
 Do $$$AssertEquals(sc, 1)
}

Method TestMap() As %Status
{
  set new=##class(rcc.gstream).%New()
  do new.use("^||UnitTestS")
  set obj=new.%OpenId(1)
  Do $$$AssertEquals(obj.size, 1379)
}

Method TestQuery() As %Status
{
  set txt=##class(rcc.gstreamT).lorem()
  &sql(SELECT chr INTO :chr FROM rcc.gstream 
       WHERE rcc.use('^||UnitTestS')=1 AND id=1)
  set str=##class(%Stream.Object).%Open(chr)
  set line=str.ReadLine()
  Do $$$AssertEquals(line,txt)
}

Method TestMapT() As %Status
{
  set new=##class(rcc.gstreamT).%New()
  do new.use("^||UnitTestS")
  set obj=new.%OpenId(1)
  Do $$$AssertEquals(obj.size, 1379)
}

Method TestQueryT() As %Status
{
  set txt=##class(rcc.gstreamT).lorem()
  &sql(SELECT chr INTO :chr FROM rcc.gstreamT 
       WHERE rcc.useT('^||UnitTestS')=1 AND id=1)
  set str=##class(%Stream.Object).%Open(chr)
  set line=str.ReadLine()
  Do $$$AssertEquals(line,txt)
}

}
