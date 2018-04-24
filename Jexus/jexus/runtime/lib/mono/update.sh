#!/bin/sh

cp -rf /usr/lib/mono/gac/Accessibility gac
cp -rf /usr/lib/mono/gac/I18N gac
cp -rf /usr/lib/mono/gac/I18N.CJK gac
cp -rf /usr/lib/mono/gac/I18N.MidEast gac
cp -rf /usr/lib/mono/gac/I18N.Other gac
cp -rf /usr/lib/mono/gac/I18N.Rare gac
cp -rf /usr/lib/mono/gac/I18N.West   gac
cp -rf /usr/lib/mono/gac/ICSharpCode.SharpZipLib gac
cp -rf /usr/lib/mono/gac/Microsoft.CSharp gac
cp -rf /usr/lib/mono/gac/Microsoft.VisualC gac
cp -rf /usr/lib/mono/gac/Microsoft.Web.Infrastructure gac
cp -rf /usr/lib/mono/gac/Mono.CSharp gac
cp -rf /usr/lib/mono/gac/Mono.Data.Sqlite gac
cp -rf /usr/lib/mono/gac/Mono.Data.Tds  gac
cp -rf /usr/lib/mono/gac/Mono.Http  gac
cp -rf /usr/lib/mono/gac/Mono.Security gac
cp -rf /usr/lib/mono/gac/Mono.Posix gac
cp -rf /usr/lib/mono/gac/Novell.Directory.Ldap gac
cp -rf /usr/lib/mono/gac/SMDiagnostics gac
cp -rf /usr/lib/mono/gac/System  gac
cp -rf /usr/lib/mono/gac/System.ComponentModel.DataAnnotations gac
cp -rf /usr/lib/mono/gac/System.Configuration gac
cp -rf /usr/lib/mono/gac/System.Configuration.Install  gac
cp -rf /usr/lib/mono/gac/System.Core  gac
cp -rf /usr/lib/mono/gac/System.Data  gac
cp -rf /usr/lib/mono/gac/System.Data.DataSetExtensions  gac
cp -rf /usr/lib/mono/gac/System.Data.Entity  gac
cp -rf /usr/lib/mono/gac/System.Data.Linq  gac
cp -rf /usr/lib/mono/gac/System.Data.OracleClient gac
cp -rf /usr/lib/mono/gac/System.Data.Services gac
cp -rf /usr/lib/mono/gac/System.Data.Services.Client gac
cp -rf /usr/lib/mono/gac/System.Design  gac
cp -rf /usr/lib/mono/gac/System.DirectoryServices  gac
cp -rf /usr/lib/mono/gac/System.DirectoryServices.Protocols gac
cp -rf /usr/lib/mono/gac/System.Drawing  gac
cp -rf /usr/lib/mono/gac/System.Drawing.Design  gac
cp -rf /usr/lib/mono/gac/System.Dynamic  gac
cp -rf /usr/lib/mono/gac/System.EnterpriseServices gac
cp -rf /usr/lib/mono/gac/System.IdentityModel gac
cp -rf /usr/lib/mono/gac/System.IO.Compression  gac
cp -rf /usr/lib/mono/gac/System.IO.Compression.FileSystem  gac
cp -rf /usr/lib/mono/gac/System.Json gac
cp -rf /usr/lib/mono/gac/System.Json.Microsoft gac 
cp -rf /usr/lib/mono/gac/System.Management  gac
cp -rf /usr/lib/mono/gac/System.Messaging gac
cp -rf /usr/lib/mono/gac/System.Net  gac
cp -rf /usr/lib/mono/gac/System.Net.Http  gac
cp -rf /usr/lib/mono/gac/System.Net.Http.Formatting  gac
cp -rf /usr/lib/mono/gac/System.Net.Http.WebRequest  gac
cp -rf /usr/lib/mono/gac/System.Numerics  gac
cp -rf /usr/lib/mono/gac/System.Numerics.Vectors gac
cp -rf /usr/lib/mono/gac/System.Runtime.Caching  gac
cp -rf /usr/lib/mono/gac/System.Runtime.Remoting  gac
cp -rf /usr/lib/mono/gac/System.Runtime.Serialization  gac
cp -rf /usr/lib/mono/gac/System.Runtime.Serialization.Formatters.Soap gac
cp -rf /usr/lib/mono/gac/System.Security  gac
cp -rf /usr/lib/mono/gac/System.ServiceModel gac
cp -rf /usr/lib/mono/gac/System.ServiceModel.Activation gac
cp -rf /usr/lib/mono/gac/System.ServiceModel.Web gac
cp -rf /usr/lib/mono/gac/System.ServiceModel.Internals gac
cp -rf /usr/lib/mono/gac/System.ServiceProcess gac
cp -rf /usr/lib/mono/gac/System.Threading.Tasks.Dataflow gac
cp -rf /usr/lib/mono/gac/System.Transactions  gac
cp -rf /usr/lib/mono/gac/System.Web gac
cp -rf /usr/lib/mono/gac/System.Web.Abstractions gac
cp -rf /usr/lib/mono/gac/System.Web.ApplicationServices gac
cp -rf /usr/lib/mono/gac/System.Web.DynamicData gac
cp -rf /usr/lib/mono/gac/System.Web.Extensions gac
cp -rf /usr/lib/mono/gac/System.Web.Http  gac
cp -rf /usr/lib/mono/gac/System.Web.Http.WebHost gac
cp -rf /usr/lib/mono/gac/System.Web.Mvc gac
cp -rf /usr/lib/mono/gac/System.Web.Razor gac
cp -rf /usr/lib/mono/gac/System.Web.Routing gac
cp -rf /usr/lib/mono/gac/System.Web.Services gac
cp -rf /usr/lib/mono/gac/System.Web.WebPages gac
cp -rf /usr/lib/mono/gac/System.Web.WebPages.Razor gac
cp -rf /usr/lib/mono/gac/System.Web.WebPages.Deployment gac
cp -rf /usr/lib/mono/gac/System.Windows.Forms gac
cp -rf /usr/lib/mono/gac/WindowsBase gac
cp -rf /usr/lib/mono/gac/System.Xaml gac
cp -rf /usr/lib/mono/gac/System.Xml  gac
cp -rf /usr/lib/mono/gac/System.Xml.Linq  gac
cp -rf /usr/lib/mono/gac/System.Xml.Serialization  gac

cp -r /usr/lib/mono/4.5/Facades 4.5/
cp -f /usr/lib/mono/4.5/mscorlib.dll 4.5/

cp -f /usr/lib/mono/4.5/al.exe  4.5/
cp -f /usr/lib/mono/4.5/resgen.exe 4.5/
cp -f /usr/lib/mono/4.5/csc.exe    4.5/
cp -f /usr/lib/mono/4.5/Microsoft.CodeAnalysis.dll 4.5/
cp -f /usr/lib/mono/4.5/Microsoft.CodeAnalysis.CSharp.dll 4.5/
cp -f /usr/lib/mono/4.5/System.Collections.Immutable.dll 4.5/
cp -f /usr/lib/mono/4.5/System.Reflection.Metadata.dll 4.5/
cp -f /usr/lib/mono/4.5/mcs.exe 4.5/
cp -f /usr/lib/mono/4.5/Microsoft.CSharp.targets 4.5/

find gac -name *.mdb | xargs rm >/dev/null 2>&1
find 4.5/Facades -name *.mdb | xargs rm >/dev/null 2>&1

find gac -name *.pdb | xargs rm >/dev/null 2>&1
find 4.5/Facades -name *.pdb | xargs rm >/dev/null 2>&1


