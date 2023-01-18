## The Idea  
In general Global Streams are data objects embedded in Classes / Tables.  
Using and viewing them with SQL is normally a part of the access to the containing tables.  
**SO WHAT?**  
During debugging or searching for strange or unexpected behavior there could be the need to    
get closer to the stored stream. No big problem with direct access to Globals with SMP or Terminal.  
But with SQL you are lost.  
So my tool provides dynamic access to Global Streams wherever you may need this  
Special thanks to  @Oliver Wilms  for the inspiration for this tool.   
Mapping of globals to SQL is a rather traditional art from past.  
Though Global Streams are somehow specialized.  
But even as their Object classes have changed their representation in Global is the same.
   
The tricky point is that we see 4 different types of Global Streams in a common structure  
but only the embedding Class / Table knows the meaning of the content.   
- %Stream.GlobalCharacter   -  raw text  
- %Stream.GblChrCompress - zipped text  
- %Stream.GlobalBinary - raw binary sequence  
- %Stream.GblBinCompress - zipped binary sequence  
   
The Global itself has no indication, of what format it holds.  
Dumping the Global just helps for raw text, the rest needs special treatment.  
In combination with SQL you meet the problem of maximum field lengths.  
  
I cover this issue by mapping all 4 types over the same stream and the user decides.   
In addition, the total size and number of subnodes is also available.
For string manipulation, the first subscript level is also available as "body" VARCHAR
The Global Stream to examine is provided by a static where clause like this:
```
select * from rcc.gstream where rcc.use('^txtS')=1
```
![](https://community.intersystems.com/sites/default/files/inline/images/images/image(5234).png)  
WinSQL is friendly enough to let you see the full content.   
eg. for id=1  chr    
![](https://community.intersystems.com/sites/default/files/inline/images/images/image(5235).png)   
and czip   
![](https://community.intersystems.com/sites/default/files/inline/images/images/image(5236).png)  

with SQL the compressed data can be viewed unzipped.

### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

### Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/rcemper/GlobalStreams-to-SQL.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
```
docker-compose exec iris iris session iris
```
or use [Webterminal](http://localhost:42773/terminal/)  

For testing we have to know the names of the Stream Globals  
I have prepared 3 globals with both flat abnd complessed content in sequence.   
We load them first:  
```
do ##class(rcc.gstream).docker()     
```
If not on Docker you may pass the directory containing the demo files as parameter.   
**^txtS** for long text, **^pdfS** holds a PDF file, **^jpgS** holds some images, **^mp3S** holds sound.  
the default Stream Global is **^CacheStream** (also in IRIS !)    

The global to display is passed as parameter in a static WHERE clause  
**....WHERE RCC.USE('^global_name')=1**   
this is the init sequence for dynamic switching.   

### Examples
Use any external SQL Client for testing.   
I tried SQuirrel, DBeaver, WinSQL.   The last is used in my video.     
SQLshell() and SMP are unable to handle streams but return the Stream's %OID instead   
**Test Queries:**       
```
SELECT * FROM RCC.GSTREAM WHERE RCC.USE('^txtS')=1
```
```
SELECT * FROM RCC.GSTREAM WHERE RCC.USE('^pdfS')=1
```
```
SELECT * FROM RCC.GSTREAM WHERE RCC.USE('^mp3S')=1
```
```
SELECT * FROM RCC.GSTREAM WHERE RCC.USE('^jpgS')=1
```
You can see it in action in my [Video](https://youtu.be/YPzdLceFmMg)

[Article in DC](https://community.intersystems.com/post/global-streams-sql)    
