<!DOCTYPE html><html lang="en"><head>
<style>
:root {
    --urldd87ecd4d06034b: url(${url.resourcesPath}/build/static/media/6d795810e8af1dac12b102665533399c.6d795810.svg);
}
</style>

<script>
    window.kcContext= 
<#assign pageId="login-idp-link-email.ftl">
(()=>{

    const out =
${ftl_object_to_js_code_declaring_an_object(.data_model, [])?no_esc};

    out["msg"]= function(){ throw new Error("use import { useKcMessage } from 'keycloakify'"); };
    out["advancedMsg"]= function(){ throw new Error("use import { useKcMessage } from 'keycloakify'"); };

    out["messagesPerField"]= {
        <#assign fieldNames = [
            "global", "userLabel", "username", "email", "firstName", "lastName", "password", "password-confirm",
            "totp", "totpSecret", "SAMLRequest", "SAMLResponse", "relayState", "device_user_code", "code",
            "password-new", "rememberMe", "login", "authenticationExecution", "cancel-aia", "clientDataJSON",
            "authenticatorData", "signature", "credentialId", "userHandle", "error", "authn_use_chk", "authenticationExecution",
            "isSetRetry", "try-again", "attestationObject", "publicKeyCredentialId", "authenticatorLabel"
        ]>

        <#attempt>
            <#if profile?? && profile.attributes?? && profile.attributes?is_enumerable>
                <#list profile.attributes as attribute>
                    <#if fieldNames?seq_contains(attribute.name)>
                        <#continue>
                    </#if>
                    <#assign fieldNames += [attribute.name]>
                </#list>
            </#if>
        <#recover>
        </#attempt>

        "printIfExists": function (fieldName, x) {
            <#list fieldNames as fieldName>
                if(fieldName === "${fieldName}" ){
                    <#attempt>
                        return "${messagesPerField.printIfExists(fieldName,'1')}" ? x : undefined;
                    <#recover>
                    </#attempt>
                }
            </#list>
            throw new Error("There is no " + fieldName + " field");
        },
        "existsError": function (fieldName) {
            <#list fieldNames as fieldName>
                if(fieldName === "${fieldName}" ){
                    <#attempt>
                        return <#if messagesPerField.existsError('${fieldName}')>true<#else>false</#if>;
                    <#recover>
                    </#attempt>
                }
            </#list>
            throw new Error("There is no " + fieldName + " field");
        },
        "get": function (fieldName) {
            <#list fieldNames as fieldName>
                if(fieldName === "${fieldName}" ){
                    <#attempt>
                        <#if messagesPerField.existsError('${fieldName}')>
                            return "${messagesPerField.get('${fieldName}')?no_esc}";
                        </#if>
                    <#recover>
                    </#attempt>
                }
            </#list>
            throw new Error("There is no " + fieldName + " field");
        },
        "exists": function (fieldName) {
            <#list fieldNames as fieldName>
                if(fieldName === "${fieldName}" ){
                    <#attempt>
                        return <#if messagesPerField.exists('${fieldName}')>true<#else>false</#if>;
                    <#recover>
                    </#attempt>
                }
            </#list>
            throw new Error("There is no " + fieldName + " field");
        }
    };

    out["pageId"] = "${pageId}";

    return out;

})()
<#function ftl_object_to_js_code_declaring_an_object object path>

        <#local isHash = "">
        <#attempt>
            <#local isHash = object?is_hash || object?is_hash_ex>
        <#recover>
            <#return "ABORT: Can't evaluate if " + path?join(".") + " is hash">
        </#attempt>

        <#if isHash>

            <#if path?size gt 10>
                <#return "ABORT: Too many recursive calls">
            </#if>

            <#local keys = "">

            <#attempt>
                <#local keys = object?keys>
            <#recover>
                <#return "ABORT: We can't list keys on this object">
            </#attempt>


            <#local out_seq = []>

            <#list keys as key>

                <#if ["class","declaredConstructors","superclass","declaringClass" ]?seq_contains(key) >
                    <#continue>
                </#if>

                <#if
                    (
                        ["loginUpdatePasswordUrl", "loginUpdateProfileUrl", "loginUsernameReminderUrl", "loginUpdateTotpUrl"]?seq_contains(key) &&
                        are_same_path(path, ["url"])
                    ) || (
                        key == "updateProfileCtx" &&
                        are_same_path(path, [])
                    ) || (
                        <#-- https://github.com/InseeFrLab/keycloakify/pull/65#issuecomment-991896344 -->
                        key == "loginAction" &&
                        are_same_path(path, ["url"]) &&
                        pageId == "saml-post-form.ftl"
                    )
                >
                    <#local out_seq += ["/*If you need '" + key + "' on " + pageId + ", please submit an issue to the Keycloakify repo*/"]>
                    <#continue>
                </#if>

                <#if key == "attemptedUsername" && are_same_path(path, ["auth"])>

                    <#attempt>
                        <#-- https://github.com/keycloak/keycloak/blob/3a2bf0c04bcde185e497aaa32d0bb7ab7520cf4a/themes/src/main/resources/theme/base/login/template.ftl#L63 -->
                        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                            <#continue>
                        </#if>
                    <#recover>
                    </#attempt>

                </#if>

                <#attempt>
                    <#if !object[key]??>
                        <#continue>
                    </#if>
                <#recover>
                    <#local out_seq += ["/*Couldn't test if '" + key + "' is available on this object*/"]>
                    <#continue>
                </#attempt>

                <#local propertyValue = "">

                <#attempt>
                    <#local propertyValue = object[key]>
                <#recover>
                    <#local out_seq += ["/*Couldn't dereference '" + key + "' on this object*/"]>
                    <#continue>
                </#attempt>

                <#local rec_out = ftl_object_to_js_code_declaring_an_object(propertyValue, path + [ key ])>

                <#if rec_out?starts_with("ABORT:")>

                    <#local errorMessage = rec_out?remove_beginning("ABORT:")>

                    <#if errorMessage != " It's a method" >
                        <#local out_seq += ["/*" + key + ": " + errorMessage + "*/"]>
                    </#if>

                    <#continue>
                </#if>

                <#local out_seq +=  ['"' + key + '": ' + rec_out + ","]>

            </#list>

            <#return (["{"] + out_seq?map(str -> ""?right_pad(4 * (path?size + 1)) + str) + [ ""?right_pad(4 * path?size) + "}"])?join("\n")>

        </#if>

        <#local isMethod = "">
        <#attempt>
            <#local isMethod = object?is_method>
        <#recover>
            <#return "ABORT: Can't test if it'sa method.">
        </#attempt>

        <#if isMethod>
            <#return "ABORT: It's a method">
        </#if>

        <#local isBoolean = "">
        <#attempt>
            <#local isBoolean = object?is_boolean>
        <#recover>
            <#return "ABORT: Can't test if it's a boolean">
        </#attempt>

        <#if isBoolean>
            <#return object?c>
        </#if>

        <#local isEnumerable = "">
        <#attempt>
            <#local isEnumerable = object?is_enumerable>
        <#recover>
            <#return "ABORT: Can't test if it's an enumerable">
        </#attempt>


        <#if isEnumerable>

            <#local out_seq = []>

            <#local i = 0>

            <#list object as array_item>

                <#local rec_out = ftl_object_to_js_code_declaring_an_object(array_item, path + [ i ])>

                <#local i = i + 1>

                <#if rec_out?starts_with("ABORT:")>

                    <#local errorMessage = rec_out?remove_beginning("ABORT:")>

                    <#if errorMessage != " It's a method" >
                        <#local out_seq += ["/*" + i?string + ": " + errorMessage + "*/"]>
                    </#if>

                    <#continue>
                </#if>

                <#local out_seq += [rec_out + ","]>

            </#list>

            <#return (["["] + out_seq?map(str -> ""?right_pad(4 * (path?size + 1)) + str) + [ ""?right_pad(4 * path?size) + "]"])?join("\n")>

        </#if>

        <#attempt>
            <#return '"' + object?js_string + '"'>;
        <#recover>
        </#attempt>

        <#return "ABORT: Couldn't convert into string non hash, non method, non boolean, non enumerable object">

</#function>
<#function are_same_path path searchedPath>

    <#if path?size != path?size>
        <#return false>
    </#if>

    <#local i=0>

    <#list path as property>

        <#local searchedProperty=searchedPath[i]>

        <#if searchedProperty?is_string && searchedProperty == "*">
            <#continue>
        </#if>

        <#if searchedProperty?is_string && !property?is_string>
            <#return false>
        </#if>

        <#if searchedProperty?is_number && !property?is_number>
            <#return false>
        </#if>

        <#if searchedProperty?string != property?string>
            <#return false>
        </#if>

        <#local i+= 1>

    </#list>

    <#return true>

</#function>
;
</script>

<#if scripts??>
    <#list scripts as script>
        <script src="${script}" type="text/javascript"></script>
    </#list>
</#if><meta charset="utf-8"><link rel="icon" href="${url.resourcesPath}/build/favicon.ico"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="theme-color" content="#000000"><meta name="description" content="Web site created using create-react-app"><link rel="apple-touch-icon" href="${url.resourcesPath}/build/logo192.png"><link rel="manifest" href="${url.resourcesPath}/build/manifest.json"><title>React App</title><style>@font-face{font-family:"Work Sans";src:url(${url.resourcesPath}/build/fonts/worksans-bold-webfont.woff2) format("woff2"),url(${url.resourcesPath}/build/fonts/worksans-bold-webfont.woff) format("woff");font-weight:700;font-style:normal}@font-face{font-family:"Work Sans";src:url(${url.resourcesPath}/build/fonts/worksans-semibold-webfont.woff2) format("woff2"),url(${url.resourcesPath}/build/fonts/worksans-semibold-webfont.woff) format("woff");font-weight:600;font-style:normal}@font-face{font-family:"Work Sans";src:url(${url.resourcesPath}/build/fonts/worksans-medium-webfont.woff2) format("woff2"),url(${url.resourcesPath}/build/fonts/worksans-medium-webfont.woff) format("woff");font-weight:500;font-style:normal}@font-face{font-family:"Work Sans";src:url(${url.resourcesPath}/build/fonts/worksans-regular-webfont.woff2) format("woff2"),url(${url.resourcesPath}/build/fonts/worksans-regular-webfont.woff) format("woff");font-weight:400;font-style:normal}</style><link href="${url.resourcesPath}/build/static/css/2.910f74b9.chunk.css" rel="stylesheet"><link href="${url.resourcesPath}/build/static/css/main.40eeb6a5.chunk.css" rel="stylesheet"></head><body><noscript>You need to enable JavaScript to run this app.</noscript><div id="root"></div><script>!function(e){function t(t){for(var n,l,a=t[0],f=t[1],i=t[2],p=0,s=[];p<a.length;p++)l=a[p],Object.prototype.hasOwnProperty.call(o,l)&&o[l]&&s.push(o[l][0]),o[l]=0;for(n in f)Object.prototype.hasOwnProperty.call(f,n)&&(e[n]=f[n]);for(c&&c(t);s.length;)s.shift()();return u.push.apply(u,i||[]),r()}function r(){for(var e,t=0;t<u.length;t++){for(var r=u[t],n=!0,a=1;a<r.length;a++){var f=r[a];0!==o[f]&&(n=!1)}n&&(u.splice(t--,1),e=l(l.s=r[0]))}return e}var n={},o={1:0},u=[];function l(t){if(n[t])return n[t].exports;var r=n[t]={i:t,l:!1,exports:{}};return e[t].call(r.exports,r,r.exports,l),r.l=!0,r.exports}l.m=e,l.c=n,l.d=function(e,t,r){l.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:r})},l.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},l.t=function(e,t){if(1&t&&(e=l(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var r=Object.create(null);if(l.r(r),Object.defineProperty(r,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var n in e)l.d(r,n,function(t){return e[t]}.bind(null,n));return r},l.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return l.d(t,"a",t),t},l.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},l.p="/";var a=this["webpackJsonpkeycloak-theme"]=this["webpackJsonpkeycloak-theme"]||[],f=a.push.bind(a);a.push=t,a=a.slice();for(var i=0;i<a.length;i++)t(a[i]);var c=f;r()}([])</script><script src="${url.resourcesPath}/build/static/js/2.246d9643.chunk.js"></script><script src="${url.resourcesPath}/build/static/js/main.a62448ad.chunk.js"></script></body></html>