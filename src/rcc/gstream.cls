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

}
