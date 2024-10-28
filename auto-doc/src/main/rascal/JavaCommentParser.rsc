module JavaCommentParser

start syntax Comment = "/**" Lines "*/";
syntax Lines = Line*;

syntax Line = textLine: "* "  TextLine
            | annotation: "* "  Annotation
            ;

syntax TextLine = [^*\n]+;

syntax Annotation = param: "@param" ParamName ParamDesc | returnVal: "@return" ReturnDesc;

syntax ParamName = [a-zA-Z0-9_]+;
syntax ParamDesc = TextLine;
syntax ReturnDesc = [a-zA-Z0-9_]+;

layout Whitespace = [\t-\n\r\ ]*;