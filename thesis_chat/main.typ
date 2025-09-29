
#import "settings.typ": *

#set document(title: meta.title, author: meta.author)

#titlepage()

#acknowledgment(text: [Optional. If not needed, delete this block.])

#kurzfassung([Kurzfassung Ihrer Arbeit in deutscher Sprache. Verpflichtend!])

#abstract([Abstract of your thesis in English. Compulsory!])

#heading(level: 1, numbering: none)[Contents]
#outline(depth: 3)



#include "frontmatter/introduction.typ"
#include "chapters/chapter-01.typ"
#include "chapters/chapter-02.typ"

#print-bibliography()

#declaration()
