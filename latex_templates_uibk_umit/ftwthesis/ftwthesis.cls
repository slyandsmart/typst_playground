% Copyright 2024, Hans-Peter Schröcker, <hans-peter.schroecker@uibk.ac.at>,
% https://geometrie.uibk.ac.at/schroecker/
%
% This program is free software: you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
% PARTICULAR PURPOSE. See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with
% this program. If not, see <http://www.gnu.org/licenses/>.

%% Changes
%%
%% Version 2.04 [2025-02-24]
%% - Replace all occurances of "UMIT Tirol" by "UMIT TIROL")
%%
%% Version 2.03 [2025-02-24]
%% - Replace all occurances of "UMIT" by "UMIT Tirol" (or "UMIT TIROL")
%% - Update version information to be printed during normal LaTeX run
%%
%% Version 2.02 [2024-12-04]
%% - Corrected intendation bug for PhD exposes.
%%
%% Version 2.02 [2024-07-01]
%% - Publish under GNU General Public License.
%%
%% Version 2.01 [2023-11-23]
%% - New Version Eidesstattliche Erklaerung.
%%
%% Version 2.0 [2022-08-29]
%% - Switch from memoir to KOMA-script.
%% - Code cleanup (avoid unnecessary case distinctions).
%%
%% Version 1.15 [2022-07-14]
%% - Use new official name of UMIT.
%% - Create templates for master thesis in electrical engineering.
%% empty.
%%
%% Changes
%% Version 1.14 [2021-06-03]
%% - Headline on page with Verpflichtungs- und Einverstaendniserklaerung is now
%%   empty.
%%
%% Version 1.13 [2020-06-08]
%% - Include new UMIT logo
%%
%% Version 1.12 [2020-06-08]
%% - Correct table of contents and running heads for BA theses.
%%
%% Version 1.11 [2019-11-20]
%% - Correct logo position.
%% - Add command \publicafter for displaying information on "exclusion from
%%   use".
%%
%% Version 1.10 [2019-09-12]
%% - Support all types of exposes (BA, MA, PhD) via new class option
%% expose=true/false. Changes in the user interface: study=Expose is no longer
%% possible.
%% - Fix page layout bug (asymmetric inner margins).
%%
%% Version 1.9 [2019-07-01]
%% - Improve explanation text for "Mitbetreuer/-in"
%%
%% Version 1.8 [2019-01-30]
%% - New option for master specialization.
%% - Use language option naustrian instead of ngerman
%% - New type ``expose''
%%
%% Version 1.7 [2018-07-19]
%% - Fix language selection error.
%% - Fix command description error in german explanation text.
%% - Improve blindtext.
%% - Also number subsections in text and table of contents of BA thesis.
%% - Include support for electrical engineering.
%%
%% Version 1.6 [2018-03-06]
%% - Fix page number and explanation text on page three (for MA and PhD).
%%
%% Version 1.5 [2018-01-31]
%% - Fix ugly page numbering in frontmatter (for BA, MA, and PhD).
%%
%% Version 1.4 [2017-11-27]
%% - Remove bug in case of explanation=false (explanation partly shown).
%%
%% Version 1.3 [2017-10-18]
%% - Corrected formulation and logic of "Einverstaendnis und Verpflichtungserklaerung"
%% - Clarification on citation style (numeric and author-year are ok)
%% - Corrected spelling.
%%
%% Version 1.2 [2017-09-29]
%% - Support UMIT theses (BA and MA)
%% - Correct academic title (Bachelor of Sciences -- Bachelor of Science)
%% - Replace \AuthorSurname by \AuthorGivenName (\AuthorSurname may
%%   still be used)

%% ftwthesis.cls
\NeedsTeXFormat{LaTeX2e}\relax
\ProvidesClass{ftwthesis}%
[2025/02/25, version 2.04; Thesis Style (Bachelor, Master, PhD) for the Faculty
of Engineering Sciences, University of Innsbruck; Thesis Style (Bachelor, Master
in Mechatronics or Electrical Engineering) and for the Department of Biomedical
Computer Science and Mechatronics, UMIT -- The Tyrolean Private University]


%% Load required packages.
%%
%% Select language.
\RequirePackage[english,ngerman,naustrian]{babel}
%% Select fonts (LaTeX clone of Times New Roman).
%% Sans-serif (Helvetica) is needed for titlepage.
\RequirePackage{mathptmx}
\RequirePackage[scaled]{helvet}
%% Dummy text for illustration purposes.
\RequirePackage{blindtext}
%% Inclusion of logo graphics.
\RequirePackage{graphicx}
%% Packages for logical operations and key-value interface.
\RequirePackage{xifthen}
%% Coloring of titlepage
\RequirePackage{color}
\definecolor{uibkgray}{cmyk}{0,0,0,0.9}%
\definecolor{uibkblue}{cmyk}{1,0.6,0,0.65}%
%\definecolor{umitbrown}{cmyk}{0,0.08,0.08,0.80}%
\definecolor{umitbrown}{cmyk}{0,0.0,0.0,1.00}%
\definecolor{uibkorange}{cmyk}{0,.5,1,0}%
\definecolor{umitemph}{cmyk}{0.0,0.7,0.7,0}%
%% More possibilities for environments.
\RequirePackage{environ}

%% Setup class options.
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=FTW,
  prefix=FTW@
}

%% Declare option lang. Possible values are german or english.
%% Default is german.
\DeclareStringOption{lang}[german]

%% Declare option type. Possible values are BA, MA, PhD, or Expose.
%% Default is PhD.
\DeclareStringOption{type}[PhD]

%% Declare option uni. Possible values are LFUI or UMIT.
%% Defaults is LFUI.
\DeclareStringOption{uni}[LFUI]

%% Declare option study. Possible values are
%% BauUmwelt (Bau und Umweltingenieurwissenschaften)
%% Elek (Elektrotechnik)
%% Mech (Mechatronik)
%% Bau (Bauingenieurwissenschaften)
%% Umwelt (Umweltingenieurwissenschaften)
%% Doktorat (Doktorat Technische Wissenschaften)
\DeclareStringOption{study}[Doktorat]

%% Declare option specialization. Possible values are
%% BBP (Baustoffe, Baubetrieb und Projektmanagement)
%% KIB (Konstruktiver Ingenieurbau)
%% MOS (Modellierung und Simulation)
%% EEG (Energieeffiziente Gebäude)
%% GVW (Geotechnik, Vermessung und Wasserbau)
%% UVW (Umwelttechnik und Verkehrswesen)
\DeclareStringOption[\textcolor{uibkorange}{\bfseries{Spezialisierung fehlt!}}]{specialization}[]

%% Declare option expose.
\DeclareBoolOption[false]{expose}

%% Declare option explanation.
\DeclareBoolOption[false]{explanation}

\ProcessKeyvalOptions*

%% Code to handle option lang. Defaults to english. Note that german is actually
%% naustrian.
\newboolean{langEnglish}
\newboolean{langGerman}
\setboolean{langEnglish}{true}
\setboolean{langGerman}{false}

\ifthenelse{\equal{\FTW@lang}{german}}{%
  \setboolean{langEnglish}{false}
  \setboolean{langGerman}{true}}{}

%% Code to handle option type
\newboolean{isBAthesis}
\newboolean{isMAthesis}
\newboolean{isPhDthesis}
\newboolean{Seminar}
\setboolean{isBAthesis}{false}
\setboolean{isMAthesis}{false}
\setboolean{isPhDthesis}{true} % default
\setboolean{Seminar}{true}

\ifthenelse{\equal{\FTW@type}{BA}}{%
  \setboolean{isBAthesis}{true}
  \setboolean{isMAthesis}{false}
  \setboolean{isPhDthesis}{false}}{}

\ifthenelse{\equal{\FTW@type}{MA}}{%
  \setboolean{isBAthesis}{false}
  \setboolean{isMAthesis}{true}
  \setboolean{isPhDthesis}{false}}{}

\ifthenelse{\equal{\FTW@type}{PhD}}{%
  \setboolean{isBAthesis}{false}
  \setboolean{isMAthesis}{false}
  \setboolean{isPhDthesis}{true}}{}


%% Code to handle option uni.
\newboolean{LFUI}
\newboolean{UMIT}
\setboolean{LFUI}{true} % default
\setboolean{UMIT}{false}
\ifthenelse{\equal{\FTW@uni}{UMIT}}{
  \setboolean{LFUI}{false}
  \setboolean{UMIT}{true}}

%% Code to handle option study.
\newboolean{Bau}
\newboolean{Umwelt}
\newboolean{Elek}
\newboolean{Mech}
\newboolean{Doktorat}
\setboolean{Bau}{true}
\setboolean{Umwelt}{false}
\setboolean{Mech}{false}
\setboolean{Doktorat}{false}

\ifthenelse{\equal{\FTW@study}{Umwelt}}{%
  \setboolean{Bau}{false}
  \setboolean{Umwelt}{true}}

\ifthenelse{\equal{\FTW@study}{Elek}}{%
  \setboolean{Bau}{false}
  \setboolean{Elek}{true}}

\ifthenelse{\equal{\FTW@study}{Mech}}{%
  \setboolean{Bau}{false}
  \setboolean{Mech}{true}}

\ifthenelse{\equal{\FTW@study}{Doktorat}}{%
  \setboolean{Bau}{false}
  \setboolean{Doktorat}{true}}

%% Code to handle option specialization
\ifthenelse{\equal{\FTW@specialization}{BBP}}%
    {\gdef\FTW@specialization{Baustoffe, Baubetrieb und Projektmanagement}}{}
\ifthenelse{\equal{\FTW@specialization}{KIB}}%
    {\gdef\FTW@specialization{Konstruktiver Ingenieurbau}}{}
\ifthenelse{\equal{\FTW@specialization}{MOS}}%
    {\gdef\FTW@specialization{Modellierung und Simulation}}{}
\ifthenelse{\equal{\FTW@specialization}{EEG}}%
    {\gdef\FTW@specialization{Energieeffiziente Geb\"aude}}{}
\ifthenelse{\equal{\FTW@specialization}{GVW}}%
    {\gdef\FTW@specialization{Geotechnik, Vermessung und Wasserbau}}{}
\ifthenelse{\equal{\FTW@specialization}{UVW}}%
    {\gdef\FTW@specialization{Umwelttechnik und Verkehrswesen}}{}

%% Code to handle option expose
\newboolean{isExpose}
\ifFTW@expose
  \setboolean{isExpose}{true}
\else
  \setboolean{isExpose}{false}
\fi

%% Code to handle option explanation
\newboolean{showExplanation}
\ifFTW@explanation
  \setboolean{showExplanation}{true}
\else
  \setboolean{showExplanation}{false}
\fi
\newcommand{\ftwExplanationFont}{\color{uibkorange}}
\ifthenelse{\boolean{UMIT}}{\renewcommand{\ftwExplanationFont}{\color{umitemph}}}{}

% String to describe exclusion from use.
\gdef\FTW@ExclusionText{%
  \"Uber Antrag
  \ifthenelse{\boolean{UseFemaleTitle}}{der}{des}
  Studierenden wurde der Ausschluss der Ben\"utzung der
  \FTW@ThesisName{}
  gem\"a\ss\ \S~86~Abs.~4~UG bis zum
  \FTW@publicafter\
  genehmigt.}

%% This class is based on the KOMA-Script document bundle.
%% Load class with options depending on thesis type.
%% BA thesis and exposes are printed single sided.
\ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}%
{\LoadClass[a4paper,oneside,titlepage,11pt,toc=listof,toc=bib]{scrartcl}}%
{\LoadClass[a4paper,twoside,titlepage,openright,11pt,toc=listof,toc=bib]{scrbook}}%

%% configure appearance
\setkomafont{sectioning}{\normalfont\bfseries}
\setkomafont{descriptionlabel}{\normalfont\bfseries}
\setkomafont{pagehead}{\normalfont}
\RequirePackage{enumitem}
\setlist{noitemsep}
\ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}%
{
  \setcounter{secnumdepth}{2}
}%
{
  % TODO: Select appropriate chapter style.
  % \chapterstyle{hangnum} % chapter style for non-BA theses and non exposes
}

%% Macros to collect data from user.
%%
%% subtitle
\newcommand*{\FTW@Subtitle}{}
\newcommand{\Subtitle}[1]{\gdef\FTW@Subtitle{#1}}
%% author given name and familyname
\newcommand*{\FTW@AuthorGivenName}{}
\newcommand{\AuthorGivenName}[1]{\gdef\FTW@AuthorGivenName{#1}}
% correct earlier translation bug
\let\AuthorSurname=\AuthorGivenName
\newcommand*{\FTW@AuthorFamilyname}{}
\newcommand{\AuthorFamilyname}[1]{\gdef\FTW@AuthorFamilyname{#1}}
%% author academic titles
\newboolean{academictitlepre}
\setboolean{academictitlepre}{false}
\newcommand*{\FTW@AcademicTitlePre}{} % Mag., Dipl.-Ing. etc.
\newcommand{\AcademicTitlePre}[1]{%
  \ifthenelse{\isempty{#1}}{}{\setboolean{academictitlepre}{true}}%
  \gdef\FTW@AcademicTitlePre{#1}}
\newboolean{academictitlepost}
\setboolean{academictitlepost}{false}
\newcommand*{\FTW@AcademicTitlePost}{} % MA, BA etc.
\newcommand{\AcademicTitlePost}[1]{
  \ifthenelse{\isempty{#1}}{}{\setboolean{academictitlepost}{true}}%
  \gdef\FTW@AcademicTitlePost{#1}}
%% author gender
\newboolean{AuthorFemale}
\setboolean{AuthorFemale}{true}
\newboolean{UseFemaleTitle}
\ifthenelse{\boolean{AuthorFemale}}%
           {\setboolean{UseFemaleTitle}{true}}%
           {\setboolean{UseFemaleTitle}{false}}

%% advisor data
\newcommand*{\FTW@Advisor}{}
\newcommand{\Advisor}[1]{\gdef\FTW@Advisor{#1}}
\newcommand*{\FTW@AdvisorUniversity}{}
\newcommand{\AdvisorUniversity}[1]{\gdef\FTW@AdvisorUniversity{#1}}
\newcommand*{\FTW@AdvisorDepartment}{}
\newcommand{\AdvisorDepartment}[1]{\gdef\FTW@AdvisorDepartment{#1}}
\newcommand*{\FTW@AdvisorResearchUnit}{}
\newcommand{\AdvisorResearchUnit}[1]{\gdef\FTW@AdvisorResearchUnit{#1}}
\newboolean{AdvisorFemale}
\setboolean{AdvisorFemale}{true}

%% second advisor data
\newcommand*{\FTW@AdvisorTwo}{}
\newcommand{\AdvisorTwo}[1]{\gdef\FTW@AdvisorTwo{#1}}
\newcommand*{\FTW@AdvisorTwoUniversity}{}
\newcommand{\AdvisorTwoUniversity}[1]{\gdef\FTW@AdvisorTwoUniversity{#1}}
\newcommand*{\FTW@AdvisorTwoDepartment}{}
\newcommand{\AdvisorTwoDepartment}[1]{\gdef\FTW@AdvisorTwoDepartment{#1}}
\newcommand*{\FTW@AdvisorTwoResearchUnit}{}
\newcommand{\AdvisorTwoResearchUnit}[1]{\gdef\FTW@AdvisorTwoResearchUnit{#1}}
\newboolean{AdvisorTwoFemale}
\setboolean{AdvisorTwoFemale}{true}

%% third advisor data
\newcommand*{\FTW@AdvisorThree}{}
\newcommand{\AdvisorThree}[1]{\gdef\FTW@AdvisorThree{#1}}
\newcommand*{\FTW@AdvisorThreeUniversity}{}
\newcommand{\AdvisorThreeUniversity}[1]{\gdef\FTW@AdvisorThreeUniversity{#1}}
\newcommand*{\FTW@AdvisorThreeDepartment}{}
\newcommand{\AdvisorThreeDepartment}[1]{\gdef\FTW@AdvisorThreeDepartment{#1}}
\newcommand*{\FTW@AdvisorThreeResearchUnit}{}
\newcommand{\AdvisorThreeResearchUnit}[1]{\gdef\FTW@AdvisorThreeResearchUnit{#1}}
\newboolean{AdvisorThreeFemale}
\setboolean{AdvisorThreeFemale}{true}

%% first evaluator data
\newcommand*{\FTW@Evaluator}{}
\newcommand{\Evaluator}[1]{\gdef\FTW@Evaluator{#1}}
\newcommand*{\FTW@EvaluatorUniversity}{}
\newcommand{\EvaluatorUniversity}[1]{\gdef\FTW@EvaluatorUniversity{#1}}
\newcommand*{\FTW@EvaluatorDepartment}{}
\newcommand{\EvaluatorDepartment}[1]{\gdef\FTW@EvaluatorDepartment{#1}}
\newcommand*{\FTW@EvaluatorResearchUnit}{}
\newcommand{\EvaluatorResearchUnit}[1]{\gdef\FTW@EvaluatorResearchUnit{#1}}
\newboolean{EvaluatorFemale}
\setboolean{EvaluatorFemale}{true}

%% second evaluator data
\newcommand*{\FTW@EvaluatorTwo}{}
\newcommand{\EvaluatorTwo}[1]{\gdef\FTW@EvaluatorTwo{#1}}
\newcommand*{\FTW@EvaluatorTwoUniversity}{}
\newcommand{\EvaluatorTwoUniversity}[1]{\gdef\FTW@EvaluatorTwoUniversity{#1}}
\newcommand*{\FTW@EvaluatorTwoDepartment}{}
\newcommand{\EvaluatorTwoDepartment}[1]{\gdef\FTW@EvaluatorTwoDepartment{#1}}
\newcommand*{\FTW@EvaluatorTwoResearchUnit}{}
\newcommand{\EvaluatorTwoResearchUnit}[1]{\gdef\FTW@EvaluatorTwoResearchUnit{#1}}
\newboolean{EvaluatorTwoFemale}
\setboolean{EvaluatorTwoFemale}{true}

\newcommand{\FTW@ThesisName}{}
\newcommand{\FTW@AcademicDegree}{}

% publically available after
\newcommand{\FTW@publicafter}{}
\newcommand{\publicafter}[1]{\gdef\FTW@publicafter{#1}}

%% University logo
\newcommand{\FTW@UniLogo}{}
%\ifthenelse{\boolean{LFUI}}{\gdef\FTW@UniLogo{fakultaet-fuer-technische-wissenschaften_logo-cmyk}}{}
\ifthenelse{\boolean{LFUI}}%
{\gdef\FTW@UniLogo{universitaet-innsbruck-logo-cmyk-farbe}}%
{\ifthenelse{\boolean{langEnglish}}%
  {\gdef\FTW@UniLogo{logo_umit_eng}}%
  {\gdef\FTW@UniLogo{logo_umit_de}}}

%% Prepare optional and compulsory environments at beginning of thesis
%% (thanks, Kurzfassung, abstract).
\newcommand{\FTW@AcknowledgmentName}{}
\gdef\FTW@AcknowledgmentName{Acknowledgment}
\ifthenelse{\boolean{langGerman}}
           {\gdef\FTW@AcknowledgmentName{Danksagung}}
           {}
\newcommand{\FTW@DoNotUseEnvironment}[1]{
  {\color{uibkorange}\bfseries
    \ifthenelse{\boolean{langGerman}}{%
      \textcolor{uibkorange}{Verwenden Sie die Umgebung \texttt{#1} nicht f\"ur ein Expos\'e!}%
    }{%
      \textcolor{uibkorange}{Do not use the environment \texttt{#1} for an expos\'e!}%
    }
  }
  \par
}
\NewEnviron{Acknowledgment}{
  \ifx\BODY\@empty
  \else
  \ifthenelse{\boolean{isBAthesis}}
  {\section*{\FTW@AcknowledgmentName}}
  {\chapter*{\FTW@AcknowledgmentName}}
  \ifthenelse{\boolean{isExpose}}{\FTW@DoNotUseEnvironment{Acknowledgment}}{}%
  \BODY
  \cleardoublepage
  \fi
}

\newenvironment{Kurzfassung}{\selectlanguage{naustrian}
  \ifthenelse{\boolean{isBAthesis}}
  {\section*{Kurzfassung}}
  {\chapter*{Kurzfassung}}
  \ifthenelse{\boolean{isExpose}}{\FTW@DoNotUseEnvironment{Kurzfassung}}{}%
}{\cleardoublepage}
\newenvironment{Abstract}{\selectlanguage{english}
  \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}
  {\section*{Abstract}}
  {\chapter*{Abstract}}
  \ifthenelse{\boolean{isExpose}}{\FTW@DoNotUseEnvironment{Abstract}}{}%
}{\cleardoublepage}


%% Set page layout
\RequirePackage{geometry}
\geometry{left=37.125mm,right=37.125mm,top=37.5mm,bottom=35.5mm,headsep=7.5mm}
% \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}%
% {\geometry{left=37.0mm,right=37.0mm,top=37.5mm,bottom=35.5mm,headsep=7.5mm}}%
% {\geometry{left=37.0mm,right=37.0mm,top=37.5mm,bottom=35.5mm,headsep=7.5mm}}

% Language selection must be early enough!
\ifthenelse{\boolean{langGerman}}{\selectlanguage{naustrian}}{}
\ifthenelse{\boolean{langEnglish}}{\selectlanguage{english}}{}

\AtBeginDocument{%
  % Confirm language selection once more.
  \ifthenelse{\boolean{langGerman}}{\selectlanguage{naustrian}}{}
  \ifthenelse{\boolean{langEnglish}}{\selectlanguage{english}}{}

  % Define academic degree at begin document as only then the author's gender is
  % determined.
  \ifthenelse{\boolean{isBAthesis}}{%
    \gdef\FTW@ThesisName{Bachelorarbeit}
    \gdef\FTW@AcademicDegree{Bachelor of Science}
  }{}
  \ifthenelse{\boolean{isMAthesis}}{%
      \gdef\FTW@ThesisName{Masterarbeit}
      \ifthenelse{\boolean{UseFemaleTitle}}
                 {\gdef\FTW@AcademicDegree{Diplomingenieurin}}
                 {\gdef\FTW@AcademicDegree{Diplomingenieur}}
               }{}
  \ifthenelse{\boolean{isPhDthesis}}{
        \gdef\FTW@ThesisName{Dissertation}
        \ifthenelse{\boolean{UseFemaleTitle}}
                   {\gdef\FTW@AcademicDegree{Doktorin der Technischen Wissenschaften}}
                   {\gdef\FTW@AcademicDegree{Doktor der Technischen Wissenschaften}}
               }{}
  % re-define thesis name in case of expose
  \ifthenelse{\boolean{isExpose}}{
	  \ifthenelse{\boolean{isBAthesis}}{\gdef\FTW@ThesisName{Expos\'e zur Bachelorarbeit}}{}
	  \ifthenelse{\boolean{isMAthesis}}{\gdef\FTW@ThesisName{Expos\'e zur Masterarbeit}}{}
	  \ifthenelse{\boolean{isPhDthesis}}{\gdef\FTW@ThesisName{Dissertationsexpos\'e}}{}
	  }{}


  % Now typeset the title page.
  \begin{titlepage}
    \par\vspace*{-27mm}
    \begin{addmargin}{10mm}
    \ifthenelse{\boolean{LFUI}}%
      {\begin{addmargin}[-18.5mm]{0pt}\includegraphics[width=75mm]{\FTW@UniLogo}\end{addmargin}}%
      {\begin{addmargin}[0pt]{0pt}\includegraphics[width=75mm]{\FTW@UniLogo}\end{addmargin}}%
    \ifthenelse{\boolean{LFUI}}{\color{uibkgray}}{}
    % \color{uibkgray} % also goes well with umitbrown
    \raggedright
    % \sffamily
    \ifthenelse{\boolean{LFUI}}{%
      \par\vspace*{-4.8mm}%\medskip
      {\large\noindent{\sffamily\color{uibkgray}Fakult\"at f\"ur
          Technische\\Wissenschaften}}}%
    { % UMIT code
      \par\vspace*{0.0mm}%\medskip
      {\large\noindent{\sffamily\color{umitbrown}\ifthenelse{\boolean{langEnglish}}{Department for
          Biomedical Informatics and Mechatronics}{Department f\"ur
          Biomedizinische Informatik und Mechatronik}}}%
    } % END: UMIT
    \par\bigskip\noindent
    % Reserve enough space for title and subtitle.
    % TODO: Is this necessary?
    \parbox[t][8\baselineskip][t]{\linewidth}{%
      \raggedright
      \vfill
      {\LARGE\bfseries\ifthenelse{\boolean{LFUI}}{\color{uibkblue}}{\color{umitbrown}}
        {
          \@title\ifthenelse{\boolean{showExplanation}}{%
            \ifthenelse{\boolean{langEnglish}}{%
              \thanks{\ftwExplanationFont Title and subtitle in English if
                text is written in English. Remaining parts of titlepage must
                be in German!}}{}}{}
        }}
      \par
      \bigskip
      {\Large
        {
          \FTW@Subtitle%
          \ifthenelse{\boolean{showExplanation}}{%
            \ifthenelse{\boolean{langEnglish}}%
            {\thanks{\ftwExplanationFont Subtitle is optional.}}%
            {\thanks{\ftwExplanationFont Untertitel optional.}}}{}%
        }}
      \vfill
    }
    % author, date, location
    \par\bigskip\noindent
    \large
    \ifthenelse{\boolean{academictitlepre}}{\FTW@AcademicTitlePre~}{}%
    \FTW@AuthorGivenName~\FTW@AuthorFamilyname%
    \ifthenelse{\boolean{academictitlepost}}{,~\FTW@AcademicTitlePost}{}%
    \par\bigskip\noindent
    \ifthenelse{\boolean{LFUI}}{Innsbruck}{Hall in Tirol}, \@date
    \vfill
    {\Large\FTW@ThesisName} % bachelor/master/phd thesis or expose
    \ifthenelse{\boolean{isBAthesis} \OR \boolean{isMAthesis}}{%
      \ifthenelse{\boolean{Mech} \OR \(\boolean{Elek} \AND \boolean{isBAthesis}\)}{
        \par\bigskip
        verfasst im Rahmen eines gemeinsamen
        \ifthenelse{\boolean{isBAthesis}}{Bachelorstudienprogramms}{Masterstudienprogramms}
        % \ifthenelse{\boolean{Mech}}{Mechatronik}{}
        % \ifthenelse{\boolean{Elek}}{Elektrotechnik}{}
        von LFUI und UMIT TIROL -- Joint Degree Programme}{}}{} % END: joint study program with UMIT
    \par\bigskip
    \ifthenelse{\boolean{isExpose}}{%
      \ifthenelse{\boolean{isPhDthesis} \AND \boolean{Seminar}}
      {verfasst im Rahmen des Seminars
      \glqq Konzipierung der Dissertation\grqq%
      \ifthenelse{\boolean{showExplanation}}{%
        \ifthenelse{\boolean{langEnglish}}
        {\thanks{\ftwExplanationFont This template is to be used
            \textbf{exclusively} for exposes written within the seminar
            ``Konzipierung der Dissertation''.}}%
        {\thanks{\ftwExplanationFont Diese Vorlage ist \textbf{ausschlie\ss lich} f\"ur Expos\'es zu verwenden, die
          im Rahmen des Seminars \glqq Konzipierung der Dissertation\grqq{}
          verfasst werden!}}}{}% END: explanation
      }{}
    }{} % END: isExpose
    \ifthenelse{\NOT\boolean{isExpose}}{%
    eingereicht an der
    \ifthenelse{\boolean{LFUI}}%
      {Leopold-Franzens-Universit\"at Innsbruck, Fakult\"at f\"ur Technische Wissenschaften}%
      {UMIT TIROL -- Privatuniversit\"at f\"ur Gesundheitswissenschaften und -technologie, Department f\"ur Biomedizinische Informatik und Mechatronik}
    zur Erlangung des akademischen Grades
    \par\bigskip
    {\Large \FTW@AcademicDegree}}{}

    \ifthenelse{\boolean{isMAthesis}\AND\NOT\boolean{isExpose}}{%
      {\ifthenelse{\boolean{Bau}\OR\boolean{Umwelt}}{%
          \par\vspace*{2\bigskipamount}
          Diese Masterarbeit ist der Vertiefungsrichtung \glqq\FTW@specialization\grqq{} des
          Masterstudiums
          \ifthenelse{\boolean{Bau}}{Bauingenieurwissenschaften}{}%
          \ifthenelse{\boolean{Umwelt}}{Umweltingenieurwissenschaften}{}%
          \ifthenelse{\boolean{Mech}}{Mechatronik}{}%
          \ifthenelse{\boolean{Elek}}{Elektrotechnik}{}%
          \ zugeordnet.\ifthenelse{\boolean{showExplanation}}{%
            {\ifthenelse{\boolean{langEnglish}}
              {\thanks{\ftwExplanationFont Only applicable to MA Bau- or
                Umweltingenieurwissenschaften. ``Vertiefungsrichtung'' according
                to curriculum.}}
              {\thanks{\ftwExplanationFont Nur f\"ur MA Bau- und MA
                  Umweltingenieurwissenschaften. Vertiefungsrichtungen laut Curriculum.}}
            }}{}%
        }{}}
    }{}
    \ifthenelse{\equal{\FTW@publicafter}{}}{}{%
      \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{}{%
      \par\bigskip\FTW@ExclusionText%
      \ifthenelse{\boolean{showExplanation}}{%
        \ifthenelse{\boolean{langEnglish}}
        {\thanks{\ftwExplanationFont
            Compulsory, if exclusion from use has been approved of. Otherwise
            not permitted.
          }}
        {\thanks{\ftwExplanationFont
           {Verpflichtend, wenn Ausschluss von Ben\"utzung genehmigt wurde.
             Ansonsten nicht zul\"assig.}%
          }}}}{}% end explanation for publicafter
      }%
    \ifthenelse{\NOT\boolean{isExpose}}{
      \ifthenelse{\boolean{isBAthesis} \OR \boolean{isMAthesis}}%
      {\par\vspace*{2\bigskipamount}
        \ifthenelse{\boolean{UseFemaleTitle}}{Beurteilerin:}{Beurteiler:}%
        \ifthenelse{\boolean{showExplanation}}{%
          \ifthenelse{\boolean{isBAthesis}}{%
            \ifthenelse{\boolean{langEnglish}}%
            {\thanks{\ftwExplanationFont Evaluator is instructor of lecture in
                which bachelor thesis is written.}}%
            {\thanks{\ftwExplanationFont Beurteiler/in ist Betreuer/in der
                Lehrveranstaltung im Rahmen derer die Bachelorarbeit verfasst wird.}}%
          }{%
            \ifthenelse{\boolean{langEnglish}}%
            {\thanks{\ftwExplanationFont Evaluator is advisor of master thesis.
                Co-advisor must not act as evaluator.}}
            {\thanks{\ftwExplanationFont Beurteiler/in ist gleichzeitig
                Betreuer/in der Masterarbeit. Mitbetreuer/in kann nicht
                als Beurteiler/in fungieren.}}
          }}{}%
      \par\smallskip
      \FTW@Advisor
      \par\smallskip
      \FTW@AdvisorDepartment
      \par
      \FTW@AdvisorResearchUnit}{}}{}
    %\par\bigskip
    % Innsbruck, \thedate
    \@thanks
    \end{addmargin}
  \end{titlepage}
  % Typeset following pages with names of advisor(s) and evaluators,
  % if applicable.
  \ifthenelse{\NOT\boolean{isExpose}}{%
    \ifthenelse{\boolean{isMAthesis}}{
      \cleardoublepage
      \pagenumbering{gobble}
      \mbox{}\par\vfill
      \begin{minipage}[t]{0.3\linewidth}
        \ifthenelse{\boolean{UseFemaleTitle}}{Betreuerin:}{Betreuer:}%
        \ifthenelse{\boolean{showExplanation}}{\footnotemark{}}{}%
      \end{minipage}%
      \ifthenelse{\boolean{showExplanation}}{%
        \footnotetext{\ftwExplanationFont \ifthenelse{\boolean{langEnglish}}%
          {Only scientific staff of the \ifthenelse{\boolean{LFUI}}{University of
              Innsbruck or the UMIT TIROL}{UMIT TIROL or the University of Innsbruck} are
            eligible. Supervisors muss satisfy the criteria laid out in
            Satzungsteil \glqq Studienrechtliche Bestimmungen\grqq\ \S~24.}%
          {Als Betreuer/in kommen ausschlie\ss lich
            wissenschaftliche Mitarbeiter/-innen der \ifthenelse{\boolean{LFUI}}{Universit\"at Innsbruck und der
            UMIT TIROL}{UMIT TIROL und der Universit\"at Innsbruck} in Betracht, die
          den im Satzungsteil \glqq Studienrechtliche Bestimmungen\grqq\
          \S~24 genannten Kriterien gen\"ugen.}
        }}{}
      \begin{minipage}[t]{0.7\linewidth}
        \flushleft
        \FTW@Advisor%
        \ifthenelse{\equal{\FTW@AdvisorUniversity}{}}{}{, \FTW@AdvisorUniversity}%
        \ifthenelse{\equal{\FTW@AdvisorDepartment}{}}{}{, \FTW@AdvisorDepartment}%
        \ifthenelse{\equal{\FTW@AdvisorResearchUnit}{}}{}{, \FTW@AdvisorResearchUnit}%
      \end{minipage}%
      \ifthenelse{\equal{\FTW@AdvisorTwo}{}}{}{
        \par\bigskip
        \begin{minipage}[t]{0.3\linewidth}
          \ifthenelse{\boolean{AdvisorTwoFemale}}{Mitbetreuerin:}{Mitbetreuer:}%
          \ifthenelse{\boolean{showExplanation}}{\footnotemark{}}{}%
        \end{minipage}%
        \ifthenelse{\boolean{showExplanation}}{%
          \footnotetext{\ftwExplanationFont
            \ifthenelse{\boolean{langEnglish}}%
            {Optional co-supervisor that has been approved of when registering the
              master thesis.}%
            {Optional Mitbetreuer/in, der/die bei der Anmeldung der Masterarbeit
              genehmigt wurde.}
	  }}{}
        \begin{minipage}[t]{0.7\linewidth}
          \flushleft
          \FTW@AdvisorTwo%
          \ifthenelse{\equal{\FTW@AdvisorTwoUniversity}{}}{}{, \FTW@AdvisorTwoUniversity}%
          \ifthenelse{\equal{\FTW@AdvisorTwoDepartment}{}}{}{, \FTW@AdvisorTwoDepartment}%
          \ifthenelse{\equal{\FTW@AdvisorTwoResearchUnit}{}}{}{, \FTW@AdvisorTwoResearchUnit}%
        \end{minipage}%
      }
    }{}% END: MA thesis
  }{}% END: not expose
  \ifthenelse{\boolean{isPhDthesis} \AND \NOT\boolean{isExpose}}{
    \cleardoublepage
    \pagenumbering{gobble}
    \mbox{}\par\vfill
    % Use advisor data if evaluator is empty
    \ifthenelse{\equal{\FTW@Evaluator}{}}{
      \Evaluator{\FTW@Advisor}
      \EvaluatorUniversity{\FTW@AdvisorUniversity}
      \EvaluatorDepartment{\FTW@AdvisorDepartment}
      \EvaluatorResearchUnit{\FTW@AdvisorResearchUnit}
      \ifthenelse{\boolean{UseFemaleTitle}}{\setboolean{EvaluatorFemale}{true}}{\setboolean{EvaluatorFemale}{false}}
    }{}
    \begin{minipage}[t]{0.3\linewidth}
      \ifthenelse{\boolean{EvaluatorFemale}}{Erste Beurteilerin:}{Erster Beurteiler:}
      \ifthenelse{\boolean{showExplanation}}{\footnotemark{}}{}
    \end{minipage}%
    \ifthenelse{\boolean{showExplanation}}{%
      \footnotetext{
        \ifthenelse{\boolean{langEnglish}}%
        {\ftwExplanationFont The evaluators must be coordinated with the Dean of
          Studies \emph{prior to printing.} Only persons with habilitation are eligible.
          Only one of the advisors can act as evaluator.}%
        {\ftwExplanationFont Die Wahl der Beurteilere/innen ist \emph{vor
            Drucklegung} mit dem Studiendekan abzustimmen. Als Beurteiler/innen von
          Dissertationen kommen nur Personen mit Lehrbefugnis in Betracht. Als
          Beurteiler/in darf nur eine/r der Betreuer/innen herangezogen werden.}
      }}{}
    \begin{minipage}[t]{0.7\linewidth}
      \flushleft
      \FTW@Evaluator%
      \ifthenelse{\equal{\FTW@EvaluatorUniversity}{}}{}{, \FTW@EvaluatorUniversity}%
      \ifthenelse{\equal{\FTW@EvaluatorDepartment}{}}{}{, \FTW@EvaluatorDepartment}%
      \ifthenelse{\equal{\FTW@EvaluatorResearchUnit}{}}{}{, \FTW@EvaluatorResearchUnit}%
    \end{minipage}%
    \ifthenelse{\equal{\FTW@EvaluatorTwo}{}}{}{
      \par\bigskip
      \begin{minipage}[t]{0.3\linewidth}
        \ifthenelse{\boolean{EvaluatorTwoFemale}}{Zweite Beurteilerin:}{Zweiter Beurteiler:}
      \end{minipage}%
      \begin{minipage}[t]{0.7\linewidth}
        \flushleft
        \FTW@EvaluatorTwo%
        \ifthenelse{\equal{\FTW@EvaluatorTwoUniversity}{}}{}{, \FTW@EvaluatorTwoUniversity}%
        \ifthenelse{\equal{\FTW@EvaluatorTwoDepartment}{}}{}{, \FTW@EvaluatorTwoDepartment}%
        \ifthenelse{\equal{\FTW@EvaluatorTwoResearchUnit}{}}{}{, \FTW@EvaluatorTwoResearchUnit}%
      \end{minipage}%
    }
    \cleardoublepage
    \pagestyle{empty}
    \mbox{}\par\vfill
    \begin{minipage}[t]{0.3\linewidth}
      \ifthenelse{\boolean{UseFemaleTitle}}{Hauptbetreuerin:}{Hauptbetreuer:}
      \ifthenelse{\boolean{showExplanation}}{\footnotemark{}}{}
    \end{minipage}%
    \ifthenelse{\boolean{showExplanation}}{
      \footnotetext{%
        \ifthenelse{\boolean{langEnglish}}%
        {\ftwExplanationFont Only persons with habilitation are eligible.}%
        {\ftwExplanationFont Als Betreuer/in von Dissertationen kommen nur
          Personen mit Lehrbefugnis in Betracht.}%
      }%
    }{}%
    \begin{minipage}[t]{0.7\linewidth}
      \flushleft
      \FTW@Advisor%
      \ifthenelse{\equal{\FTW@AdvisorUniversity}{}}{}{, \FTW@AdvisorUniversity}%
      \ifthenelse{\equal{\FTW@AdvisorDepartment}{}}{}{, \FTW@AdvisorDepartment}%
      \ifthenelse{\equal{\FTW@AdvisorResearchUnit}{}}{}{, \FTW@AdvisorResearchUnit}%
    \end{minipage}%
    \ifthenelse{\equal{\FTW@AdvisorTwo}{}}{}{
      \par\bigskip
      \begin{minipage}[t]{0.3\linewidth}
        \ifthenelse{\boolean{AdvisorTwoFemale}}{Zweite Betreuerin:}{Zweiter Betreuer:}
        \ifthenelse{\boolean{showExplanation}}{\footnotemark{}}{}
      \end{minipage}%
      \ifthenelse{\boolean{showExplanation}}{%
        \footnotetext{\ifthenelse{\boolean{langEnglish}}%
          {\ftwExplanationFont If applicable.}%
          {\ftwExplanationFont Falls zutreffend.}%
        }%
      }{}%
      \begin{minipage}[t]{0.7\linewidth}
        \flushleft
        \FTW@AdvisorTwo%
        \ifthenelse{\equal{\FTW@AdvisorTwoUniversity}{}}{}{, \FTW@AdvisorTwoUniversity}%
        \ifthenelse{\equal{\FTW@AdvisorTwoDepartment}{}}{}{, \FTW@AdvisorTwoDepartment}%
        \ifthenelse{\equal{\FTW@AdvisorTwoResearchUnit}{}}{}{, \FTW@AdvisorTwoResearchUnit}%
      \end{minipage}%
    }
    \ifthenelse{\equal{\FTW@AdvisorThree}{}}{}{
      \par\bigskip
      \begin{minipage}[t]{0.3\linewidth}
        \ifthenelse{\boolean{AdvisorThreeFemale}}{Dritte Betreuerin:}{Dritter Betreuer:}
      \end{minipage}%
      \begin{minipage}[t]{0.7\linewidth}
        \flushleft
        \FTW@AdvisorThree%
        \ifthenelse{\equal{\FTW@AdvisorThreeUniversity}{}}{}{, \FTW@AdvisorThreeUniversity}%
        \ifthenelse{\equal{\FTW@AdvisorThreeDepartment}{}}{}{, \FTW@AdvisorThreeDepartment}%
        \ifthenelse{\equal{\FTW@AdvisorThreeResearchUnit}{}}{}{, \FTW@AdvisorThreeResearchUnit}%
      \end{minipage}%
    }
  }{} % END: Phd thesis
  \ifthenelse{\boolean{showExplanation}}{%
    \clearpage
    \begingroup
    \ftwExplanationFont
    \ifthenelse{\boolean{isBAthesis}}{%
      \ifthenelse{\boolean{isExpose}}{%
        \ifthenelse{\boolean{langEnglish}}
        {\section*{Typical Structure of a Bachelor Thesis Expos\'e}
          \begin{itemize}
          \item Introduction, Motivation
          \item State of the Art
          \item Research questions, aims
          \item Methods
          \item Workplan, if needed
          \end{itemize}}
        {\section*{Typische Struktur eines Expos\'es zur Bachelorarbeit}
          \begin{itemize}
          \item Einleitung, Motivation
          \item Stand der Forschung
          \item Forschungsfragen, Ziele
          \item Methoden
          \item allenfalls Zeitplan
          \end{itemize}}
      }{%
        \ifthenelse{\boolean{langEnglish}}%
        {\section*{Formal Structure of a Bachelor Thesis}}%
        {\section*{Formale Struktur einer Bachelorarbeit}}
        \ifthenelse{\boolean{langEnglish}}%
        {This bachelor thesis is to be printed one-sided.}%
        {Diese Bachelorarbeit ist einseitig zu drucken.}
        \begin{itemize}
        \item \ifthenelse{\boolean{langEnglish}}
          {The bachelor thesis is structured as follows:}
          {Der Aufbau der Bachelorarbeit ist wie folgt:}
          \begin{itemize}
          \item \ifthenelse{\boolean{langEnglish}}{Page 1: Titlepage}{1. Blatt: Deckblatt}
          \item \ifthenelse{\boolean{langEnglish}}{Page 2: Acknowledgment (optional)}{2. Blatt: Dank (optional)}
          \item \ifthenelse{\boolean{langEnglish}}{Page 3: Kurzfassung (in German!)}{3. Blatt: Kurzfassung (auf Deutsch!)}
          \item \ifthenelse{\boolean{langEnglish}}{Page 4: Abstract (in English!)}{4. Blatt: Abstract (auf Englisch!)}
          \end{itemize}
        \item \ifthenelse{\boolean{langEnglish}}{This is followed by:}{Es folgen:}
          \begin{itemize}
          \item \ifthenelse{\boolean{langEnglish}}{Table of Contents}{Inhaltsverzeichnis}
          \item \ifthenelse{\boolean{langEnglish}}{List of Figures (optional)}{Verzeichnis der Abbildungen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}{List of Tables (optional)}{Verzeichnis der Tabellen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}{First Chapter}{Erstes Kapitel}
          \item \ldots
          \item \ifthenelse{\boolean{langEnglish}}{Last Chapter}{Letztes Kapitel}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Bibliography (numeric citation style as in this template is not obligatory; you may also use an author-year style)}%
            {Literaturverzeichnis (numerischer Zitationsstil wie in dieser Vorlage ist nicht verpflichtend; Autor-Jahr Stil kann ebenfalls verwendet werden)}
          \item \ifthenelse{\boolean{langEnglish}}{Appendix (optional)}{Anhang (optional)}
          \item \ifthenelse{\boolean{langEnglish}}{Last page: Verpflichtungs- und Einverst\"andniserkl\"arung (in German!)}{Letztes Blatt: Verpflichtungs- und Einverst\"andniserkl\"arung}
          \end{itemize}
        \end{itemize}
      }
    }{} % END: BA thesis
    \ifthenelse{\boolean{isMAthesis}}{%
      \ifthenelse{\boolean{isExpose}}{%
        \ifthenelse{\boolean{langEnglish}}
        {\section*{Typical Structure of a Master Thesis Expos\'e}
          \begin{itemize}
          \item Introduction, Motivation
          \item State of the Art
          \item Research questions, aims
          \item Methods
          \item Workplan
          \end{itemize}}
        {\section*{Typische Struktur eines Expos\'es zur Masterarbeit}
          \begin{itemize}
          \item Einleitung, Motivation
          \item Stand der Forschung
          \item Forschungsfragen, Ziele
          \item Methoden
          \item Zeitplan
          \end{itemize}}
      }{%
        \ifthenelse{\boolean{langEnglish}}%
        {\section*{Formal Structure of a Master Thesis}}%
         {\section*{Formale Struktur einer Masterarbeit}}
         \ifthenelse{\boolean{langEnglish}}%
         {This master thesis is to be printed two-sided. New chapters start on a
           new page.}%
         {Diese Masterarbeit ist zweiseitig zu drucken. Jedes Kapitel beginnt auf
           einer neuen Seite.}
         \begin{itemize}
         \item \ifthenelse{\boolean{langEnglish}}
           {The master thesis is structured as follows:}
           {Der Aufbau der Masterarbeit ist wie folgt:}
           \begin{itemize}
           \item \ifthenelse{\boolean{langEnglish}}%
             {Page 1: Titlepage}%
             {1. Blatt: Deckblatt}
           \item \ifthenelse{\boolean{langEnglish}}%
             {Page 2: Betreuer/in (equals Evaluator), Mitbetreuer/in (if
               applicable; at most one)}%
             {2. Blatt: Betreuer/in (gleich Beurteiler/in), allenfalls
               Mitbetreuer/in (maximal eine Person); als Betreuer/in und
               Mitbetreuer/in kommen au\ss schlie\ss lich wissenschaftliche
               Mitarbeiter/innen der Universit\"at Innsbruck und der UMIT TIROL in Betracht.}
           \item \ifthenelse{\boolean{langEnglish}}%
             {Page 3: Acknowledgment (optional)}%
             {3. Blatt: Dank (optional)}
           \item \ifthenelse{\boolean{langEnglish}}%
             {Page 4: Kurzfassung (in German!)}%
             {4. Blatt: Kurzfassung (auf Deutsch!)}
           \item \ifthenelse{\boolean{langEnglish}}%
             {Page 5: Abstract (in English!)}%
             {5. Blatt: Abstract (auf Englisch!)}
           \end{itemize}
        \item \ifthenelse{\boolean{langEnglish}}%
          {This is followed by:}%
          {Es folgen:}
          \begin{itemize}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Table of Contents}%
            {Inhaltsverzeichnis}
          \item \ifthenelse{\boolean{langEnglish}}%
            {List of Figures (optional)}%
            {Verzeichnis der Abbildungen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {List of Tables (optional)}%
            {Verzeichnis der Tabellen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {First Chapter}%
            {Erstes Kapitel}
          \item \ldots
          \item \ifthenelse{\boolean{langEnglish}}%
            {Last Chapter}%
            {Letztes Kapitel}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Bibliography (numeric citation style as in this template is not obligatory; you may also use an author-year style)}%
            {Literaturverzeichnis (numerischer Zitationsstil wie in dieser Vorlage ist nicht verpflichtend; Autor-Jahr Stil kann ebenfalls verwendet werden)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Appendix (if necessary)}%
            {Anhang (falls erforderlich)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Last page: Verpflichtungs- und Einverst\"andniserkl\"arung (in
              German!)}%
            {Letztes Blatt: Verpflichtungs- und Einverst\"andniserkl\"arung}
          \end{itemize}
        \end{itemize}}% END: is expose (else branch)
    }{}% END: MA thesis
    \ifthenelse{\boolean{isPhDthesis}}{%
      \ifthenelse{\boolean{isExpose}}{%
        \ifthenelse{\boolean{langEnglish}}
        {\section*{Typical Structure of an Expos\'e}
          \begin{itemize}
          \item Introduction, Motivation
          \item State of the Art
          \item Research questions, aims
          \item Methods
          \item Workplan
          \item Agreement upon lectures to attend
          \item Signatures by student, advisor and seminar teacher
          \end{itemize}}
        {\section*{Typische Struktur eines Dissertationsexpos\'es}
          \begin{itemize}
          \item Einleitung, Motivation
          \item Stand der Forschung
          \item Forschungsfragen, Ziele
          \item Methoden
          \item Zeitplan
          \item Vereinbarung \"uber zu absolvierende Lehrveranstaltungen
          \item Unterschriften von Student/in, Betreuer/in und Lehrveranstaltungsleiter/in
          \end{itemize}}
      }{} % END: isExpose
      \ifthenelse{\NOT\boolean{isExpose}}{%
        \ifthenelse{\boolean{langEnglish}}%
        {\section*{Formal Structure of a Doctoral Thesis}}%
        {\section*{Formale Struktur einer Dissertation}}
        \ifthenelse{\boolean{langEnglish}}%
        {This doctoral thesis is to be printed two-sided. New chapters start on a
          new page.}%
        {Diese Dissertation ist zweiseitig zu drucken. Jedes Kapitel beginnt auf
          einer neuen Seite.}
        \begin{itemize}
        \item \ifthenelse{\boolean{langEnglish}}
          {The doctoral thesis is structured as follows:}
          {Der Aufbau der Dissertation ist wie folgt:}
          \begin{itemize}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 1: Titlepage}%
            {1. Blatt: Deckblatt}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 2: first evaluator, second evaluator; only people with
              habilitation are eligible}%
            {2. Blatt: erste/r Beurteiler/in, zweite/r Beurteiler/in; nur Personen mit Lehrbefugnis kommen in Betracht.}%
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 3: Team of advisors:
              \begin{itemize}
              \item principal advisor
              \item first co-advisor (if applicable)
              \item second co-advisor (if applicable)
              \end{itemize}
            }%
            {3. Blatt: Betreuer/innenteam:
              \begin{itemize}
              \item Hauptbetreuer/in
              \item zweite/r Betreuer/in (falls vorhanden)
              \item dritte/r Betreuer/in (falls vorhanden)
              \end{itemize}
            }
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 4: Acknowledgment (optional)}%
            {4. Blatt: Dank (optional)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 5: Kurzfassung (in German!)}%
            {5. Blatt: Kurzfassung (auf Deutsch!)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Page 6: Abstract (in English!)}%
            {6. Blatt: Abstract (auf Englisch!)}
          \end{itemize}
        \item \ifthenelse{\boolean{langEnglish}}%
          {This is followed by:}%
          {Es folgen:}
          \begin{itemize}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Table of Contents}%
            {Inhaltsverzeichnis}
          \item \ifthenelse{\boolean{langEnglish}}%
            {List of Figures (optional)}%
            {Verzeichnis der Abbildungen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {List of Tables (optional)}%
            {Verzeichnis der Tabellen (optional)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {First Chapter}%
            {Erstes Kapitel}
          \item \ldots
          \item \ifthenelse{\boolean{langEnglish}}%
            {Last Chapter}%
            {Letztes Kapitel}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Bibliography (numeric citation style as in this template is not obligatory; you may also use an author-year style)}%
            {Literaturverzeichnis (numerischer Zitationsstil wie in dieser Vorlage ist nicht verpflichtend; Autor-Jahr Stil kann ebenfalls verwendet werden)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Appendix (if necessary)}%
            {Anhang (falls erforderlich)}
          \item \ifthenelse{\boolean{langEnglish}}%
            {Last page: Verpflichtungs- und Einverst\"andniserkl\"arung (in
              German!)}%
            {Letztes Blatt: Verpflichtungs- und Einverst\"andniserkl\"arung}
          \end{itemize}
        \end{itemize}
        \par
        \ifthenelse{\boolean{langEnglish}}
        {In case of a cumulative dissertation, the rules of the
          curriculum must be obeyed. \emph{In particular a verbal description of your
          own contribution to the individual articles is required.}}
        {Im Fall einer kumulativen Dissertation müssen die diesbezüglichen Regeln
          des Curriculums eingehalten werden. \emph{Insbesondere ist es erforderlich,
          den eigenen Beitrag zu den einzelnen Publikationen in Worten zu beschreiben.}}
        }{} % END: no expose
      }{} % END: Phd thesis
    \ifthenelse{\NOT\boolean{isExpose}}{%
      \ifthenelse{\boolean{langEnglish}}%
        {\section*{Electronic Submission}}%
        {\section*{Elektronische Einreichung}}
      \ifthenelse{\boolean{langEnglish}}%
        {For electronic submission the thesis is to be converted into
          pdf-format. It is required that this file is not password protected!}%
        {F\"ur die elektronische Einreichung der Arbeit ist diese in das
          pdf-Format zu konvertieren. Es ist unbedingt darauf zu achten, dass die
          eingereichte Datei keinen Kennwortschutz enth\"alt!}%
     }{}%

      % General explanations for all types of thesis/exposes follow.
      \ifthenelse{\boolean{langEnglish}}
      {\section*{Using the LaTeX Template}}%
      {\section*{Verwendung der LaTeX Vorlage}}%
      \ifthenelse{\boolean{langEnglish}}%
      {The LaTeX template is based on the KOMA-script bundle. You may
        use configuration options of this group of classes to customize the look
        of your thesis.}%
      {Die LaTeX Vorlage basiert auf dem KOMA-Script Bündel. Sie k\"onnen die
        Konfigurationsm\"oglichkeiten dieser Klassengruppe benutzen, um das
        Aussehen Ihrer Arbeit zu ver\"andern.}%
      \par\bigskip\noindent
      Markus Kohm. \emph{KOMA-Script.} Edition DANTE. Lehmanns Media, Berlin, 7.
      Auflage, 2020, ISBN 978-3-96543-097-6. Print Ausgabe.
      \newline
      \texttt{https://komascript.de/~mkohm/scrguide.pdf}.
      \subsection*{Short description of class options}
      \begin{description}
      \item[uni:] Options are \texttt{LFUI} or \texttt{UMIT}.
      \item[type:] Options are \texttt{BA} (Bachelor), \texttt{MA} (Master),
        or \texttt{PhD} (PhD).
      \item[lang] Options are \texttt{english} or \texttt{german}.
      \item[study] Options are \texttt{BauUmwelt} (Bau und
        Umweltingenieurwissenschaften), \texttt{Bau}
        (Bauingenieurwissenschaften), \texttt{Umwelt}
        (Umweltingenieurwissenschaften),
        \texttt{Mech} (Mechatronik),
        \texttt{Elek} (Elektrotechnik),
        or \texttt{Doktorat} (Doktorat Technische Wissenschaften).
      % \item[uni] LFUI,%
      \item[specialization] Options are
        \begin{itemize}
        \item \texttt{BBP} (Baustoffe, Baubetrieb und Projektmanagement)
        \item \texttt{KIB} (Konstruktiver Ingenieurbau)
        \item \texttt{MOS} (Modellierung und Simulation)
        \item \texttt{EEG} (Energieeffiziente Gebäude)
        \item \texttt{GVW} (Geotechnik, Vermessung und Wasserbau)
        \item \texttt{UVW} (Umwelttechnik und Verkehrswesen)
        \end{itemize}
        This option only has an effect for the Master programs
        Bauingenieurwissenschaften or Umweltingenieurwissenschaften.
      \item[expose] Options are \texttt{false} and \texttt{true}. Default is
        is \texttt{false}. Can be used for all sorts of expos\'es (BA, MA, PhD).
      \item[explanation] Options are \texttt{false} and \texttt{true}. Set to
        \texttt{false} for final version!
      \end{description}
      \par\bigskip\noindent
      {\ttfamily
        \textbackslash documentclass[\newline
        uni=\ifthenelse{\boolean{UMIT}}{UMIT}{LFUI},\newline
        type=MA,\newline
        lang=english,\newline
        study=Mech,\newline
        \% specialization=BBP,\newline
        \% expose=false,\newline
        \% explanation=false,\newline
        ]\{ftwthesis\}}
      \ifthenelse{\boolean{isBAthesis}}{}{%
        \ifthenelse{\boolean{langEnglish}}
        {\subsection*{Exclusion from use (``Sperre'')}
          If the exclusion from use (``Sperre'') has been approved of, the end
          of blocking period must be given via the command \texttt{\textbackslash
            publicafter\{\}}. If the exclusion from use has not been applied for
          or has not been granted, this command must not be used.
        }% German
        {\subsection*{Ausschluss von der Benützung (``Sperre'')}
          Wurde der Ausschluss der Benützung (``Sperre'') genehmigt, so ist das
          Ende der Sperrfrist über den Befehl \texttt{\textbackslash
            publicafter\{\}} anzugeben. Wurde der Ausschluss der Benützung nicht
          beantragt oder nicht genehmigt, so darf dieser Befehl nicht verwendet werden.
          Am Titelblatt wird dann kein entsprechender Vermerk angezeigt.
        }% German
      }% isBAthesis
    \clearpage
    \endgroup
  }{} % END: explanation
  \RequirePackage{scrlayer-scrpage}
  \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{%
    \pagestyle{scrheadings}
    \clearmainofpairofpagestyles
    \automark{section}
    \ihead{\MakeUppercase{\headmark}}
    \ohead{\pagemark}
    \cfoot{}
  }{%
    \pagestyle{scrheadings}
    \clearmainofpairofpagestyles
    \automark{chapter}
    \automark*[section]{}
    \ihead{\MakeUppercase{\headmark}}
    \ohead{\pagemark}
    \cfoot{}
  }%
} % END: AtBeginDocument

%% Print "Verpflichtungs- und Einverst\"andniserkl\"arung" or signature lines on last page.
\AtEndDocument{%
  \cleardoublepage
  \selectlanguage{naustrian}
  \ifthenelse{\boolean{isExpose}}{%
    \ifthenelse{\boolean{Seminar} \AND \boolean{isPhDthesis}}{%
      \clearpage
      \thispagestyle{empty} % remove header on last page
      \ifthenelse{\boolean{showExplanation}}{{%
          \ftwExplanationFont
          \ifthenelse{\boolean{langGerman}}
          {\par\noindent Verpflichtende Unterschriften von Studierendem, Betreuer/in und Lehrveranstaltungsleiter/in:}
          {\par\noindent Signatures by student, advisor and seminar teacher are compulsory:}
          \par\vspace*{3\bigskipamount}}}{}
      \noindent
      \begin{minipage}{35mm}
        \hrulefill
        \par
        \ifthenelse{\boolean{langEnglish}}{Date}{Datum}
      \end{minipage}
      \hfill
      \begin{minipage}{75mm}
        \hrulefill
        \par
        \FTW@AcademicTitlePre{} \FTW@AuthorGivenName{} \FTW@AuthorFamilyname\ifthenelse{\boolean{academictitlepost}}{, \FTW@AcademicTitlePost}{}
      \end{minipage}
      \par{\vspace*{5\bigskipamount}}\noindent
      \begin{minipage}{35mm}
        \hrulefill
        \par
        \ifthenelse{\boolean{langEnglish}}{Date}{Datum}
      \end{minipage}
      \hfill
      \begin{minipage}{75mm}
        \hrulefill
        \par
        \FTW@Advisor
      \end{minipage}
      \par{\vspace*{5\bigskipamount}}\noindent
      \begin{minipage}{35mm}
        \hrulefill
        \par
        \ifthenelse{\boolean{langEnglish}}{Date}{Datum}
      \end{minipage}
      \hfill
      \begin{minipage}{75mm}
        \hrulefill
        \par
        Leiter/in SE Konzipierung der Dissertation
      \end{minipage}\par
    }{}
  }{} % END: isExpose
  \ifthenelse{\NOT\boolean{isExpose}}{%
    \ifthenelse{\boolean{isBAthesis}}
      {\section*{Verpflichtungs- und Einverst\"andniserkl\"arung}}
      {\chapter*{Verpflichtungs- und Einverst\"andniserkl\"arung}}
      \thispagestyle{empty}

      Ich erkl\"are hiermit an Eides statt durch meine eigenh\"andige
      Unterschrift, dass ich die vorliegende Arbeit selbst\"andig verfasst und
      keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe.
      Alle Stellen, die w\"ortlich oder inhaltlich den angegebenen Quellen
      entnommen wurden, sind als solche kenntlich gemacht.

      Die vorliegende Arbeit wurde bisher in gleicher oder \"ahnlicher Form noch
      nicht als wissenschaftliche Arbeit eingereicht.

      % Ich erkl\"are, dass ich meine \FTW@ThesisName{} selbst\"andig verfasst und
      % alle in ihr verwendeten Unterlagen, Hilfsmittel und die zugrunde gelegte
      % Literatur genannt habe.

      % Ich nehme zur Kenntnis, dass auch bei auszugsweiser Ver\"offentlichung
      % meiner \FTW@ThesisName{} die Universit\"at, das/die Institut/e und der/die
      % Arbeitsbereich/e%
      % \ifthenelse{\boolean{isBAthesis}}%
      % { sowie die Leiterin bzw. der Leiter der Lehrveranstaltung, im Rahmen derer
      %   die \FTW@ThesisName{} abgefasst wurde,}%
      % {, an dem/denen die \FTW@ThesisName{} ausgearbeitet wurde, und die
      %   Betreuerin/nen bzw. der/die Betreuer} zu nennen sind.

      % Ich nehme zur Kenntnis, dass meine \FTW@ThesisName{} zur internen
      % Dokumentation und Archivierung sowie zur Abgleichung mit der
      % Plagiatssoftware elektronisch im Dateiformat pdf ohne Kennwortschutz bei
      % \ifthenelse{\boolean{isBAthesis}}%
      % {der Leiterin bzw. beim Leiter der Lehrveranstaltung einzureichen ist,}%
      % {der/dem Betreuer/in einzureichen ist,} wobei auf die elektronisch
      % archivierte \FTW@ThesisName{} nur \ifthenelse{\boolean{isBAthesis}}%
      % {die Leiterin bzw. der Leiter der Lehrveranstaltung, im Rahmen derer die
      %   \FTW@ThesisName{} abgefasst wurde,}%
      % {die/der Betreuerin/Betreuer der \FTW@ThesisName{}} und das
      % studienrechtliche Organ Zugriff haben.

      \par\vspace*{3\bigskipamount}
      \noindent
      \begin{minipage}[t]{0.35\linewidth}
        \ifthenelse{\boolean{UMIT}}{Hall in Tirol}{Innsbruck} am
        \dotfill
      \end{minipage}
      \hfill
      \begin{minipage}[t]{0.5\linewidth}
        \flushright
        \dotfill\\
        \ifthenelse{\boolean{academictitlepre}}{\FTW@AcademicTitlePre~}{}%
        \FTW@AuthorGivenName{} \FTW@AuthorFamilyname
        \ifthenelse{\boolean{academictitlepost}}{,~\FTW@AcademicTitlePost}{}%
      \end{minipage}
  }{}
  } % END: AtEndDocument

% Define command to print short info according to chosen language.
\gdef\FTWBaseClassInfo{%
  \ifthenelse{\boolean{langGerman}}%
  {Die Dokumentklasse \texttt{ftwthesis} basiert auf dem KOMA-Script
    Klassenbündel von Markus Kohm, siehe \cite{kohm20}. Sie k\"onnen die
    Konfigurationsm\"oglichkeiten dieser Klasse nutzen, um das Aussehen Ihrer
    Arbeit zu ver\"andern.}%
  {The documentclass \texttt{ftwthesis} is based on the KOMA-script class bundle
    by Markus Kohm, see \cite{kohm20}. You may use the configuration option of
    this class to change the layout of your thesis.}
}

% Define \FTWBlindDocument command
\gdef\FTWBlindDocument{%
  \ifthenelse{\boolean{langGerman}}{%
    % german
    \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{%
      \section{Informationen zu dieser Klasse}
    }{%
      \chapter{Informationen zu dieser Klasse}
    }
    \FTWBaseClassInfo\par
    \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{}{%
      \chapter{\"Uberschrift auf Ebene 0 (chapter)}
    }
    \section{\"Uberschrift auf Ebene 1 (section)}
    \section{\"Uberschrift auf Ebene 1 (section)}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    \subsection{\"Uberschrift auf Ebene 2 (subection)}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    \subsubsection{\"Uberschrift auf Ebene 3 (subsubsection)}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    \paragraph{\"Uberschrift auf Ebene 4 (paragraph)}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    {\selectlanguage{ngerman}\blindtext\par}
    \section{Listen}
    \paragraph{Beispiel einer Liste (itemize)}
    {\selectlanguage{ngerman}\blinditemize}
    {\selectlanguage{ngerman}\blindtext}
    \paragraph{Beispiel einer Liste (4 * itemize)}
    {\selectlanguage{ngerman}\blindlistlist{itemize}}
    {\selectlanguage{ngerman}\blindtext}
    \paragraph{Beispiel einer Liste (enumerate)}
    {\selectlanguage{ngerman}\blindenumerate}
    {\selectlanguage{ngerman}\blindtext}
    \paragraph{Beispiel einer Liste (4 * enumerate)}
    {\selectlanguage{ngerman}\blindlistlist{enumerate}}
    {\selectlanguage{ngerman}\blindtext}
    \paragraph{Beispiel einer Liste (description}
    {\selectlanguage{ngerman}\blinddescription}
    {\selectlanguage{ngerman}\blindtext}
  }{%
    % english
    \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{%
      \section{Information on this Class}
    }{%
      \chapter{Information on this Class}
    }
    \FTWBaseClassInfo\par
    \ifthenelse{\boolean{isBAthesis} \OR \boolean{isExpose}}{}{%
      \chapter{Heading at Level 0 (chapter)}
    }
    \section{Heading at Level 1 (section)}
    \blindtext\par
    \blindtext\par
    \blindtext\par
    \subsection{Heading at Level 2 (subection)}
    \blindtext\par
    \blindtext\par
    \blindtext\par
    \subsubsection{Heading at Level 3 (subsubsection)}
    \blindtext\par
    \blindtext\par
    \blindtext\par
    \paragraph{Heading at Level 4 (paragraph)}
    \blindtext\par
    \blindtext\par
    \blindtext\par
    \section{Lists}
    \paragraph{Example of a List (itemize)}
    \blinditemize
    \blindtext\par
    \paragraph{Example of a List (4 * itemize)}
    \blindlistlist{itemize}
    \blindtext\par
    \paragraph{Example of a List (enumerate)}
    \blindenumerate
    \blindtext\par
    \paragraph{Example of a List (4 * enumerate)}
    \blindlistlist{enumerate}
    \blindtext\par
    \paragraph{Example of a List (description}
    \blinddescription
    \blindtext\par
  }
  \begin{figure}
    \centering
    \ifthenelse{\boolean{LFUI}}
    {
      \includegraphics{\FTW@UniLogo}
      \ifthenelse{\boolean{langGerman}}
          {\caption{Logo der Universit\"at Innsbruck (Beispiel für eine Abbildung)}}
          {\caption{Logo of the University of Innsbruck (example of a figure)}}
    }%
    {
      \includegraphics[width=0.7\linewidth]{\FTW@UniLogo}
      \ifthenelse{\boolean{langGerman}}
          {\caption{Logo der UMIT TIROL (Beispiel für eine Abbildung)}}
          {\caption{Logo of the UMIT TIROL (example for a figure)}}
    }
  \end{figure}
  \begin{table}
    \centering
    \ifthenelse{\boolean{langGerman}}%
    {\caption{Multiplikationstabelle für Quaternionen (Beispiel für eine Tabelle)}}%
    {\caption{Multiplication table for quaternions (example of a table)}}
    \begin{tabular}{c|cccc}
                   & $1$          & $\mathbf{i}$  & $\mathbf{j}$  & $\mathbf{k}$  \\
      \hline
        $1$        & $1$          & $\mathbf{i}$  & $\mathbf{j}$  & $\mathbf{k}$  \\
      $\mathbf{i}$ & $\mathbf{i}$ & $-1$          & $\mathbf{k}$  & $-\mathbf{j}$ \\
      $\mathbf{j}$ & $\mathbf{j}$ & $-\mathbf{k}$ & $-1$          & $\mathbf{i}$ \\
      $\mathbf{k}$ & $\mathbf{k}$ & $\mathbf{j}$  & $-\mathbf{i}$ & $-1$
    \end{tabular}
  \end{table}
  \par
  \input{faq}
}
