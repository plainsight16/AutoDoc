module JavaDocExtractor
import ParseTree;
import JavaCommentParser;
import ParseJava;
import IO;

data DocElement = description(str desc)
                | param(str paraName, str paraDesc)
                | returnVal(str returnDesc)
                ;

List[DocElement] extractDocumentation(Tree tree){
    list[DocElement] docElements = [];
    str desc = "";
    list[DocElement] params = [];
    str returnDesc = "";

    visit(tree){
        case /TextLine content: {
            desc = " " + trim(content);
        }
        case /Annotation "@param" ParamName paramName ParamDesc paramDesc:{
            params += param(paramName, paramDesc);
        }
    }
    if (desc != "") docElements += description(desc);
    docElements += params;
    if (returnDesc != "") docElements += returnVal(returnDesc);

    return docElements;
}

str generateHtml(List[DocElement] docElements){
    str htmlContent = "\<html\>\<body\>\<h2\>Documentation\<\/h2\>\<div\>";
    for (DocElement element <- docElements){
        switch(element){
            case description(desc):
                htmlContent += "\<p\>\<strong\>Description:\<\/strong\> "+ desc + "\<\/p\>";
            case param(paramName, paramDesc):
                htmlContent += "\<p\>\<strong\>Parameter:\<\/strong\> "+ paramName + " - " + paramDesc +"\<\/p\>";
            case returnVal(returnDesc):
                htmlContent += "\<p\>\<strong\>Returns:\<\/strong\> " + returnDesc +"\<\/p\>";
        }
    }
    htmlContent += "\<\/div\>\<\/body\>\<\/html\>";
    return htmlContent;
}

str trim(str s) = replaceAll(s, "\\s+", " ");

void main(){
    List[DocElement] docs = extractDocumentation(ParseExp());
    print(docs);

    str htmlDocs = generateHtml(docs);
    print(htmlDocs);
}