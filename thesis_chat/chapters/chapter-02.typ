#import "../settings.typ": *

#chapter("Frequently Asked Questions",[
== Satzspiegel ändern
Für gut proportionierte Seitenränder kann in Typst direkt `#set page(margin: ...)` verwendet werden.
Bei doppelseitigem Druck unterscheiden wir `inside` und `outside`-Ränder.

== Lange Kapitelüberschriften
Geben Sie bei Bedarf eine kurze Version über das optionale `short:`-Argument von `#chapter(...)` an.

== Artikel einbinden
Fremde PDFs können mit `#embed` oder über Tools vorab eingebunden werden. Für kumulative Arbeiten
empfiehlt es sich, jeden Artikel in einem eigenen Anhangskapitel zu referenzieren.
])
