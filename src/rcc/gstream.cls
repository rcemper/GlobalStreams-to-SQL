Class rcc.gstream Extends %Persistent [ SqlRowIdPrivate, StorageStrategy = NewStorage1 ]
{
Class rcc.gstream Extends %Persistent [ SqlRowIdPrivate, StorageStrategy = NewStorage1 ]
{

Property id As %Integer;

Property junks As %Integer [ ReadOnly ];

Property size As %Integer [ ReadOnly ];

Property body As %String(MAXLEN = "") [ ReadOnly ];

Property chr As %Stream.GlobalCharacter [ ReadOnly ];

Property czip As %Stream.GblChrCompress(EXTERNALSQLTYPE = "LONGVARBINARY") [ ReadOnly ];

Property bin As %Stream.GlobalBinary [ ReadOnly ];

Property bzip As %Stream.GblBinCompress [ ReadOnly ];

Index idx On id [ IdKey ];

ClassMethod use(global = "^CacheStream") As %Integer [ SqlName = use, SqlProc ]
{
  new %rccstream
  set %rccstream=global
  if '$d(@%rccstream) quit '$$$OK
  kill ^||rccstream
  merge ^||rccstream=@%rccstream
  s id=""
  for  {
    set id=$o(^||rccstream(id)) quit:id=""
    set ^(id,"id")=id
  }
  quit $$$OK
}

ClassMethod lorem(Output lorem) As %String
{
  set lorem="Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy "_
            "nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. "_
            "Ut wisi enim ad minim veniam, quis nostrud exercitation ulliam corper "_
            "suscipit lobortis nisl ut aliquip ex ea commodo consequat. "_
            "Duis autem veleum iriure dolor in hendrerit in vulputate velit esse molestie "_
            "consequat, vel willum lunombro dolore eu feugiat nulla facilisis at vero "_
            "eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril "_
            "delenit augue duis dolore te feugait nulla facilisi. "_
            "Li Europan lingues es membres del sam familie. "_
            "Lor separat existentie es un myth. Por scientie, musica, sport etc., "_
            "li tot Europa usa li sam vocabularium. Li lingues differe solmen in li grammatica, "_
            "li pronunciation e li plu commun vocabules. Omnicos directe al desirabilit… "_
            "de un nov lingua franca: on refusa continuar payar custosi traductores. "_
            "It solmen va esser necessi far uniform grammatica, pronunciation e plu sommun "_
            "paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es "_
            "plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca "_
            "va esser plu simplic e regulari quam li existent Europan lingues. "_
            "It va esser tam simplic quam Occidental: in fact, it va esser Occidental. "_
            "A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge "_
            "amico dit me que Occidental es."
  quit lorem
}

ClassMethod loadtxt(txt = "") As %Status
{
  if txt="" set txt=..lorem()
  set gbl="^txtS"
  set ch=##class(%Stream.GlobalCharacter).%New()
      ,ch.%Location=gbl
  set zip=##class(%Stream.GblChrCompress).%New()
      ,zip.%Location=gbl
  for i=1:1:3 do ch.WriteLine(txt),zip.WriteLine(txt)
  set sc1=ch.%Save()
      ,sc2=zip.%Save()
  write gbl," loaded",!    
  quit sc1*sc2
}

ClassMethod loadbin(
	file = "",
	repeat = 1) As %Status
{
  set fs=##class(%Stream.FileBinary).%New()
  set sc=fs.LinkToFile(file)
  if sc set sc=fs.Size>0
  if 'sc quit sc
  set gbl="^"_$p(file,".",*)_"S"
  set bin=##class(%Stream.GlobalBinary).%New()
      ,bin.%Location=gbl
  set zip=##class(%Stream.GblBinCompress).%New()
      ,zip.%Location=gbl
  for i=1:1:repeat {
    set sc1=bin.CopyFromAndSave(fs)
    set sc2=zip.CopyFromAndSave(fs)
    quit:'sc1*sc2
  }
  write gbl," loaded",!    
  quit sc1*sc2
}

Storage NewStorage1
{
<SQLMap name="Map1">
<Data name="bin">
<Node>"id"</Node>
</Data>
<Data name="body">
<Node>1</Node>
</Data>
<Data name="bzip">
<Node>"id"</Node>
</Data>
<Data name="chr">
<Node>"id"</Node>
</Data>
<Data name="czip">
<Node>"id"</Node>
</Data>
<Data name="junks"/>
<Data name="size">
<Node>0</Node>
</Data>
<Global>^||rccstream</Global>
<Subscript name="1">
<Expression>{id}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^||rccstream</StreamLocation>
<Type>%CacheSQLStorage</Type>
}

}
