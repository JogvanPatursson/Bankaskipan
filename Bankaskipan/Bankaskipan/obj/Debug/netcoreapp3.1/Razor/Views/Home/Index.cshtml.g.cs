#pragma checksum "C:\code\Bankaskipan\Bankaskipan\Bankaskipan\Views\Home\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "384ad814235638800e8f054ef9d77595a62f83db"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_Index), @"mvc.1.0.view", @"/Views/Home/Index.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"384ad814235638800e8f054ef9d77595a62f83db", @"/Views/Home/Index.cshtml")]
    public class Views_Home_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 2 "C:\code\Bankaskipan\Bankaskipan\Bankaskipan\Views\Home\Index.cshtml"
  
    ViewData["Title"] = "Index";

#line default
#line hidden
#nullable disable
            WriteLiteral(@"
<h1>Index</h1>

<div class=""container-fluid"">
    <div class=""row"">
        <div class=""col-sm-3"">
            <p>Column A</p>
            <div class=""row"" id=""user-list"">
                <select name=""Persons"" id=""persons"">
                    <option value=""jogvan"">Jogvan</option>
                    <optgroup label=""Spouse"">
                        <option value=""bartal"">Bartal</option>
                    </optgroup>
                    <optgroup label=""Children"">
                        <option value=""brandur"">Brandur</option>
                    </optgroup>
                </select>
            </div>
            <div class=""row"" id=""account-list"">
                <ul style=""list-style-type:none; padding: 0;"">
                    <li>
                        <button>Account 1</button>
                    </li>
                    <li>
                        <button>Account 2</button>
                    </li>
                    <li>
                        <button>Account 3");
            WriteLiteral(@"</button>
                    </li>
                </ul>
            </div>
            <div class=""row"" id=""method-list""></div>
        </div>
        <div class=""col-sm-9"">
            <p>Column B</p>
            <div class=""row"" id=""overview""></div>
            <div class=""row"" id=""transactions""></div>
            <div class=""row"" id=""active-methods""></div>
        </div>
    </div>
</div>

");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
