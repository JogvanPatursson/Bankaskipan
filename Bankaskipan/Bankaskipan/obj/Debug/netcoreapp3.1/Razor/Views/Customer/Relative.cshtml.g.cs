#pragma checksum "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "c3b4bf28863b42e80140c6a4e31b81114deccd9c"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Customer_Relative), @"mvc.1.0.view", @"/Views/Customer/Relative.cshtml")]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c3b4bf28863b42e80140c6a4e31b81114deccd9c", @"/Views/Customer/Relative.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"05367a78f60ee4a41011d4069f084ab9b0de1cf5", @"/Views/_ViewImports.cshtml")]
    public class Views_Customer_Relative : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<Bankaskipan.Models.Person>
    {
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::AspNetCore.Views_Customer_Relative.__Generated__AccountsViewComponentTagHelper __AccountsViewComponentTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\r\n");
#nullable restore
#line 3 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
  
    ViewData["Title"] = "DogeBank - Relative - " + Model.first_name;

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n<div class=\"dropdown-container\">\r\n    <div class=\"dropdown\">\r\n        <a class=\"btn dropdown-toggle\" data-toggle=\"dropdown\">\r\n            ");
#nullable restore
#line 10 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
       Write(Model.relative);

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n            <span class=\"caret\"></span>\r\n        </a>\r\n        <ul class=\"dropdown-menu\">\r\n            <li><a class=\"dropdown-item\"");
            BeginWriteAttribute("href", " href=\"", 401, "\"", 442, 2);
            WriteAttributeValue("", 408, "/Customer/Person/", 408, 17, true);
#nullable restore
#line 14 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
WriteAttributeValue("", 425, Model.first_name, 425, 17, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 14 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
                                                                              Write(Model.first_name);

#line default
#line hidden
#nullable disable
            WriteLiteral("</a></li>\r\n");
#nullable restore
#line 15 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
             foreach (var person in Model.relatives)
            {

#line default
#line hidden
#nullable disable
            WriteLiteral("                <li><a class=\"dropdown-item\"");
            BeginWriteAttribute("href", " href=\"", 585, "\"", 647, 4);
            WriteAttributeValue("", 592, "/Customer/Relative/", 592, 19, true);
#nullable restore
#line 17 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
WriteAttributeValue("", 611, Model.first_name, 611, 17, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 628, "/", 628, 1, true);
#nullable restore
#line 17 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
WriteAttributeValue("", 629, person.first_name, 629, 18, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 17 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
                                                                                                       Write(person.first_name);

#line default
#line hidden
#nullable disable
            WriteLiteral("</a></li>\r\n");
#nullable restore
#line 18 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
            }

#line default
#line hidden
#nullable disable
            WriteLiteral("        </ul>\r\n");
#nullable restore
#line 20 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
         foreach (var person in Model.relatives)
        {
            if (person.first_name == Model.relative)
            {

#line default
#line hidden
#nullable disable
            WriteLiteral("                <span>");
#nullable restore
#line 24 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
                 Write(person.last_name);

#line default
#line hidden
#nullable disable
            WriteLiteral("</span>\r\n");
#nullable restore
#line 25 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
            }
        }

#line default
#line hidden
#nullable disable
            WriteLiteral("    </div>\r\n</div>\r\n<br />\r\n<div class=\"accounts-container\">    \r\n    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("vc:accounts", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.SelfClosing, "c3b4bf28863b42e80140c6a4e31b81114deccd9c6809", async() => {
            }
            );
            __AccountsViewComponentTagHelper = CreateTagHelper<global::AspNetCore.Views_Customer_Relative.__Generated__AccountsViewComponentTagHelper>();
            __tagHelperExecutionContext.Add(__AccountsViewComponentTagHelper);
            BeginWriteTagHelperAttribute();
#nullable restore
#line 31 "C:\Bankaskipan\Bankaskipan\Bankaskipan\Bankaskipan\Views\Customer\Relative.cshtml"
           WriteLiteral(Model.relative);

#line default
#line hidden
#nullable disable
            __tagHelperStringValueBuffer = EndWriteTagHelperAttribute();
            __AccountsViewComponentTagHelper.name = __tagHelperStringValueBuffer;
            __tagHelperExecutionContext.AddTagHelperAttribute("name", __AccountsViewComponentTagHelper.name, global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n</div>\r\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<Bankaskipan.Models.Person> Html { get; private set; }
        [Microsoft.AspNetCore.Razor.TagHelpers.HtmlTargetElementAttribute("vc:accounts")]
        public class __Generated__AccountsViewComponentTagHelper : Microsoft.AspNetCore.Razor.TagHelpers.TagHelper
        {
            private readonly global::Microsoft.AspNetCore.Mvc.IViewComponentHelper __helper = null;
            public __Generated__AccountsViewComponentTagHelper(global::Microsoft.AspNetCore.Mvc.IViewComponentHelper helper)
            {
                __helper = helper;
            }
            [Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeNotBoundAttribute, global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewContextAttribute]
            public global::Microsoft.AspNetCore.Mvc.Rendering.ViewContext ViewContext { get; set; }
            public System.String name { get; set; }
            public override async global::System.Threading.Tasks.Task ProcessAsync(Microsoft.AspNetCore.Razor.TagHelpers.TagHelperContext __context, Microsoft.AspNetCore.Razor.TagHelpers.TagHelperOutput __output)
            {
                (__helper as global::Microsoft.AspNetCore.Mvc.ViewFeatures.IViewContextAware)?.Contextualize(ViewContext);
                var __helperContent = await __helper.InvokeAsync("Accounts", new { name });
                __output.TagName = null;
                __output.Content.SetHtmlContent(__helperContent);
            }
        }
    }
}
#pragma warning restore 1591