module ParseJava
import ParseTree;
import JavaCommentParser;

Tree parseExp(loc txt = |project://autogen/example.myjava|) = parse(#Comment, txt);