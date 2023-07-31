"use strict";(self.webpackChunkdocumentation=self.webpackChunkdocumentation||[]).push([[386],{3905:(e,t,a)=>{a.d(t,{Zo:()=>s,kt:()=>f});var n=a(7294);function r(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function l(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function i(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?l(Object(a),!0).forEach((function(t){r(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):l(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function o(e,t){if(null==e)return{};var a,n,r=function(e,t){if(null==e)return{};var a,n,r={},l=Object.keys(e);for(n=0;n<l.length;n++)a=l[n],t.indexOf(a)>=0||(r[a]=e[a]);return r}(e,t);if(Object.getOwnPropertySymbols){var l=Object.getOwnPropertySymbols(e);for(n=0;n<l.length;n++)a=l[n],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(r[a]=e[a])}return r}var u=n.createContext({}),p=function(e){var t=n.useContext(u),a=t;return e&&(a="function"==typeof e?e(t):i(i({},t),e)),a},s=function(e){var t=p(e.components);return n.createElement(u.Provider,{value:t},e.children)},c="mdxType",h={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},m=n.forwardRef((function(e,t){var a=e.components,r=e.mdxType,l=e.originalType,u=e.parentName,s=o(e,["components","mdxType","originalType","parentName"]),c=p(a),m=r,f=c["".concat(u,".").concat(m)]||c[m]||h[m]||l;return a?n.createElement(f,i(i({ref:t},s),{},{components:a})):n.createElement(f,i({ref:t},s))}));function f(e,t){var a=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var l=a.length,i=new Array(l);i[0]=m;var o={};for(var u in t)hasOwnProperty.call(t,u)&&(o[u]=t[u]);o.originalType=e,o[c]="string"==typeof e?e:r,i[1]=o;for(var p=2;p<l;p++)i[p]=a[p];return n.createElement.apply(null,i)}return n.createElement.apply(null,a)}m.displayName="MDXCreateElement"},1587:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>u,contentTitle:()=>i,default:()=>h,frontMatter:()=>l,metadata:()=>o,toc:()=>p});var n=a(7462),r=(a(7294),a(3905));const l={title:"YaxUnit. \u0412\u0435\u0440\u0441\u0438\u044f 23.07",authors:"alkoleft",tags:["releases","yaxunit"]},i=void 0,o={permalink:"/yaxunit/blog/2023/07/31/engine-release",source:"@site/blog/2023/07/31-engine-release.md",title:"YaxUnit. \u0412\u0435\u0440\u0441\u0438\u044f 23.07",description:"Release 23.07",date:"2023-07-31T00:00:00.000Z",formattedDate:"July 31, 2023",tags:[{label:"releases",permalink:"/yaxunit/blog/tags/releases"},{label:"yaxunit",permalink:"/yaxunit/blog/tags/yaxunit"}],readingTime:.565,hasTruncateMarker:!1,authors:[{name:"alkoleft",title:"\u0420\u0430\u0437\u0440\u0430\u0431\u043e\u0442\u0447\u0438\u043a YaxUnit",url:"https://github.com/alkoleft",imageURL:"https://github.com/alkoleft.png",key:"alkoleft"}],frontMatter:{title:"YaxUnit. \u0412\u0435\u0440\u0441\u0438\u044f 23.07",authors:"alkoleft",tags:["releases","yaxunit"]},nextItem:{title:"YaxUnit. \u0412\u0435\u0440\u0441\u0438\u044f 23.05",permalink:"/yaxunit/blog/2023/05/25/engine-release"}},u={authorsImageUrls:[void 0]},p=[{value:"\u041d\u043e\u0432\u043e\u0435 \u0432 \u0432\u0435\u0440\u0441\u0438\u0438",id:"\u043d\u043e\u0432\u043e\u0435-\u0432-\u0432\u0435\u0440\u0441\u0438\u0438",level:2},{value:"\u0422\u0435\u0441\u0442\u043e\u0432\u044b\u0435 \u0434\u0430\u043d\u043d\u044b\u0435",id:"\u0442\u0435\u0441\u0442\u043e\u0432\u044b\u0435-\u0434\u0430\u043d\u043d\u044b\u0435",level:3},{value:"\u0417\u0430\u043f\u0440\u043e\u0441\u044b",id:"\u0437\u0430\u043f\u0440\u043e\u0441\u044b",level:3},{value:"\u041f\u0440\u043e\u0447\u0435\u0435",id:"\u043f\u0440\u043e\u0447\u0435\u0435",level:3},{value:"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u043d\u044b\u0435 \u043e\u0448\u0438\u0431\u043a\u0438",id:"\u0438\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u043d\u044b\u0435-\u043e\u0448\u0438\u0431\u043a\u0438",level:2},{value:"\u041c\u043e\u043a\u0438\u0442\u043e",id:"\u043c\u043e\u043a\u0438\u0442\u043e",level:3},{value:"\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f",id:"\u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f",level:3}],s={toc:p},c="wrapper";function h(e){let{components:t,...a}=e;return(0,r.kt)(c,(0,n.Z)({},s,a,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("p",null,(0,r.kt)("a",{parentName:"p",href:"https://github.com/bia-technologies/edt-test-runner/releases/tag/23.07"},"Release 23.07")),(0,r.kt)("h2",{id:"\u043d\u043e\u0432\u043e\u0435-\u0432-\u0432\u0435\u0440\u0441\u0438\u0438"},"\u041d\u043e\u0432\u043e\u0435 \u0432 \u0432\u0435\u0440\u0441\u0438\u0438"),(0,r.kt)("h3",{id:"\u0442\u0435\u0441\u0442\u043e\u0432\u044b\u0435-\u0434\u0430\u043d\u043d\u044b\u0435"},"\u0422\u0435\u0441\u0442\u043e\u0432\u044b\u0435 \u0434\u0430\u043d\u043d\u044b\u0435"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"Faker for YaxUnit (\u0413\u0435\u043d\u0435\u0440\u0430\u0446\u0438\u044f \u0432\u0430\u043b\u0438\u0434\u043d\u044b\u0445 \u0431\u0438\u0437\u043d\u0435\u0441), ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/issues/88"},"#88"),", ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/issues/80"},"#80"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/Daabramov"},"@Daabramov"))),(0,r.kt)("h3",{id:"\u0437\u0430\u043f\u0440\u043e\u0441\u044b"},"\u0417\u0430\u043f\u0440\u043e\u0441\u044b"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"\u0414\u043e\u0431\u0430\u0432\u043b\u0435\u043d\u044b \u043d\u043e\u0432\u044b\u0435 \u043c\u0435\u0442\u043e\u0434\u044b \u043c\u043e\u0434\u0443\u043b\u044f \u042e\u0422\u0417\u0430\u043f\u0440\u043e\u0441\u044b, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/pull/122"},"#122"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/potoyalo"},"@potoyalo"))),(0,r.kt)("h3",{id:"\u043f\u0440\u043e\u0447\u0435\u0435"},"\u041f\u0440\u043e\u0447\u0435\u0435"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"\u041f\u0435\u0440\u0435\u043e\u043f\u0440\u0435\u0434\u0435\u043b\u0435\u043d\u0438\u0435 \u043e\u0431\u0440\u0430\u0431\u043e\u0442\u0447\u0438\u043a\u043e\u0432 \u0441\u043e\u0431\u044b\u0442\u0438\u0439 \u0442\u0435\u0441\u0442\u043e\u0432\u043e\u0433\u043e \u043c\u043e\u0434\u0443\u043b\u044f, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/pull/124"},"#124"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/potoyalo"},"@potoyalo")),(0,r.kt)("li",{parentName:"ul"},"\u041d\u0435\u043e\u0431\u044f\u0437\u0430\u0442\u0435\u043b\u044c\u043d\u043e\u0435 \u0437\u043d\u0430\u0447\u0435\u043d\u0438\u0435 \u0434\u043e\u043f\u043e\u043b\u043d\u0438\u0442\u0435\u043b\u044c\u043d\u043e\u0433\u043e \u0441\u0432\u043e\u0439\u0441\u0442\u0432\u0430  ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/pull/106"},"#106"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/alexandr-yang"},"@alexandr-yang")),(0,r.kt)("li",{parentName:"ul"},"\u0412 \u0440\u0435\u043f\u043e\u0437\u0438\u0442\u043e\u0440\u0438\u0439 \u0434\u043e\u0431\u0430\u0432\u043b\u0435\u043d\u0430 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u044f \u0434\u043b\u044f \u043f\u0440\u043e\u0433\u043e\u043d\u0430 \u0442\u0435\u0441\u0442\u043e\u0432, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/pull/123"},"#123"))),(0,r.kt)("h2",{id:"\u0438\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u043d\u044b\u0435-\u043e\u0448\u0438\u0431\u043a\u0438"},"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u043d\u044b\u0435 \u043e\u0448\u0438\u0431\u043a\u0438"),(0,r.kt)("h3",{id:"\u043c\u043e\u043a\u0438\u0442\u043e"},"\u041c\u043e\u043a\u0438\u0442\u043e"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u0430 \u043e\u0448\u0438\u0431\u043a\u0430 \u043e\u043f\u0440\u0435\u0434\u0435\u043b\u0435\u043d\u0438\u044f \u043f\u0440\u0435\u0434\u0438\u043a\u0430\u0442\u043e\u0432 \u043f\u0440\u0438 \u043e\u0431\u0443\u0447\u0435\u043d\u0438\u0438, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/issues/108"},"#108"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/dlyubanevich"},"@dlyubanevich")),(0,r.kt)("li",{parentName:"ul"},"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u0430 \u043e\u0448\u0438\u0431\u043a\u0430 \u0430\u043d\u0430\u043b\u0438\u0437\u0430 \u043a\u043e\u043b\u0438\u0447\u0435\u0441\u0442\u0432\u0430 \u0432\u044b\u0437\u043e\u0432\u043e\u0432 \u043c\u043e\u043a\u0438\u0440\u0443\u0435\u043c\u043e\u0433\u043e \u043c\u0435\u0442\u043e\u0434\u0430, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/pull/118"},"#118")),(0,r.kt)("li",{parentName:"ul"},"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u0430 \u043e\u0448\u0438\u0431\u043a\u0430 \u043f\u0440\u0438 \u043c\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0438 \u043c\u0435\u0442\u043e\u0434\u0430 \u0432\u044b\u0437\u044b\u0432\u0430\u0435\u043c\u043e\u0433\u043e \u043f\u0440\u0438 \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0435 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u043e\u0432 \u0441\u0435\u0430\u043d\u0441\u0430, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/issues/116"},"#116"))),(0,r.kt)("h3",{id:"\u0443\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f"},"\u0423\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u0430 \u043e\u0448\u0438\u0431\u043a\u0430 \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0438 \u0440\u0430\u0432\u0435\u043d\u0441\u0442\u0432\u0430 \u0437\u043d\u0430\u0447\u0435\u043d\u0438\u044f \u0441\u043e\u043e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u044f, \u0435\u0441\u043b\u0438 \u043a\u043b\u044e\u0447\u043e\u043c \u0441\u043e\u043e\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u044f \u044f\u0432\u043b\u044f\u0435\u0442\u0441\u044f \u043d\u0435 \u0441\u0442\u0440\u043e\u043a\u0430, ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/bia-technologies/yaxunit/issues/114"},"#114"),". \u0421\u043f\u0430\u0441\u0438\u0431\u043e ",(0,r.kt)("a",{parentName:"li",href:"https://github.com/alexandr-yang"},"@alexandr-yang"))))}h.isMDXComponent=!0}}]);