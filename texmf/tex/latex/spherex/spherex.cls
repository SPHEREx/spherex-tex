%% SPHEREx document class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{spherex}[2021/03/05 SPHEREx document class]

%% Base class
\LoadClass[11pt,letterpaper]{article}

%% General Packages
\RequirePackage{etoolbox}
\RequirePackage{pgfkeys}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{natbib}
%% Load amsmath packages before loading fonts
\RequirePackage{amsmath}
\RequirePackage{amstext}

%% Class Options
\newtoggle{SpherexChangeControlled}
\newcommand{\@docCategoryCode}{null}
\newcommand{\@docCategoryName}{null}
\DeclareOption{RQ}{
    \renewcommand{\@docCategoryCode}{RQ}
    \renewcommand{\@docCategoryName}{Requirements}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{PM}{
    \renewcommand{\@docCategoryCode}{PM}
    \renewcommand{\@docCategoryName}{Project Management}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{MS}{
    \renewcommand{\@docCategoryCode}{MS}
    \renewcommand{\@docCategoryName}{Module Specification}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{DP}{
    \renewcommand{\@docCategoryCode}{DP}
    \renewcommand{\@docCategoryName}{Data Products}
}
\DeclareOption{TN}{
    \renewcommand{\@docCategoryCode}{TN}
    \renewcommand{\@docCategoryName}{Technical Notes}
}
\DeclareOption{IF}{
    \renewcommand{\@docCategoryCode}{IF}
    \renewcommand{\@docCategoryName}{Interface}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{TR}{
    \renewcommand{\@docCategoryCode}{TR}
    \renewcommand{\@docCategoryName}{Test/Technical Reports}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{RV}{
    \renewcommand{\@docCategoryCode}{RV}
    \renewcommand{\@docCategoryName}{Review Materials}
    \toggletrue{SpherexChangeControlled}
}
\DeclareOption{OP}{
    \renewcommand{\@docCategoryCode}{OP}
    \renewcommand{\@docCategoryName}{Operations Procedures}
    \toggletrue{SpherexChangeControlled}
}
% Pass additional options to the "base" class
% \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% Document metadata commands

% Reset this to be empty by default to work better with conditional
% rendering in \maketitle
\renewcommand{\@author}{}

% Structured person info
\pgfkeys{
  /person/.is family, /person,
  email/.estore in = \personEmail,
}
\newcommand{\personEmail}{}
\newcommand{\person}[2][]{
  \pgfkeys{/person, #1}%
  #2 \ifdefempty{\personEmail}{}{\href{mailto:\personEmail}{\personEmail}}%
  \renewcommand{\personEmail}{}
}

%% \title and \shortTitle
%% \title sets both the title and subtitle to be the same by default.
%% Set \shortTitle to override and set the subtitle specifically.
\newcommand{\@docShortTitle}{null}
\renewcommand{\title}[1]{
    \renewcommand{\@title}{#1}
    \renewcommand{\@docShortTitle}{#1}
}
\newcommand{\shortTitle}[1]{
    \renewcommand{\@docShortTitle}{#1}
}

%% \docDate (sets \@docDate)
%% For default date, use vcsDate if available, or today otherwise
\newcommand{\@docDate}{\ifdef{\vcsDate}{\vcsDate}{\today}}
\newcommand{\docDate}[1]{\renewcommand{\@docDate}{#1}}
% Standard \date{} works as an alias of \setDocDate
\renewcommand{\date}[1]{\docDate{#1}}

%% \modulename (sets \@modulename and SpherexModuleName toggle)
\newtoggle{SpherexModuleName}
\newcommand{\modulename}[1]{
    \toggletrue{SpherexModuleName}
    \newcommand{\@modulename}{#1}
    \title{#1}
    \shortTitle{#1}
}

%% \pipelevel (sets \@setpipelevel and SpherexPipeLevel toggle)
\newtoggle{SpherexPipeLevel}
\newcommand{\pipelevel}[1]{
    \toggletrue{SpherexPipeLevel}
    \newcommand{\@pipelevel}{#1}
}

%% \version (sets @version and SpherexVersion toggle)
\newtoggle{SpherexVersion}
\newcommand{\@version}{Not Set}
\newcommand{\version}[1]{
    \toggletrue{SpherexVersion}
    \renewcommand{\@version}{#1}
}

%% \ipaclead (sets @ipacleadname and SpherexIpacLead toggle)
\newtoggle{SpherexIpacLead}
\newcommand{\@ipacleademail}{}
\pgfkeys{
  /ipaclead/.is family, /ipaclead,
  email/.estore in = \@ipacleademail
}
\newcommand{\ipaclead}[2][]{
    \pgfkeys{/ipaclead, #1}%
    \toggletrue{SpherexIpacLead}
    \newcommand{\@ipacleadname}{#2}
}

%% \spherexlead (sets @spherexleadname and SpherexSpherexLead toggle)
\newtoggle{SpherexSpherexLead}
\newcommand{\@spherexleademail}{}
\pgfkeys{
  /spherexlead/.is family, /spherexlead,
  email/.estore in = \@spherexleademail
}
\newcommand{\spherexlead}[2][]{
    \pgfkeys{/spherexlead, #1}%
    \toggletrue{SpherexSpherexLead}
    \newcommand{\@spherexleadname}{#2}
}

%% \approved (sets @approvername, @approvaldate and SpherexApproved toggle)
\newtoggle{SpherexApproved}
\newcommand{\approved}[2]{
    \toggletrue{SpherexApproved}
    \newcommand{\@approvername}{#2}
    \newcommand{\@approvaldate}{#1}
}

%% Headers
\pagestyle{fancy}
\fancyhf{}
\headheight = 0.6in
\topmargin = -0.5in
\headwidth = 6.5in
\lhead{\includegraphics[height=0.5in]{SPHEREx_logo.png}}
\chead{\large\ \@docCategoryName \vspace{10pt}\\\@docShortTitle}
\rhead{Version \@version, \@docDate}
\footskip = 8.4pt
\cfoot{Page \thepage\ of \pageref{LastPage}}

%% Page layout
\RequirePackage[margin=1in]{geometry}

%% Title
\renewcommand{\maketitle}{
    \begin{center}
        {\Huge\bf\@title}
        \vskip 0.25in
        \iftoggle{SpherexVersion}{
            {\LARGE\bf Version: \@version}
            \vskip 0.25in
        }{}
        \iftoggle{SpherexPipeLevel}{
            {\LARGE\noindent\bf Pipeline Level: \@pipelevel}
            \vskip 0.25in
        }{}
        \iftoggle{SpherexIpacLead}{
            {\noindent\bf \ipac\ Lead: \@ipacleadname\ifdefempty{\@ipacleademail}{}{~\href{mailto:\@ipacleademail}{\@ipacleademail}} }
            \vskip 0.125in
        }{}
        \iftoggle{SpherexSpherexLead}{
            {\noindent\bf \spherex\ Lead: \@spherexleadname\ifdefempty{\@spherexleademail}{}{~\href{mailto:\@spherexleademail}{\@spherexleademail}} }
            \vskip 0.125in
        }{}
    \end{center}

    \ifdefempty{\@author}{}{
      \iftoggle{SpherexSpherexLead}{
        \iftoggle{SpherexIpacLead}{{\noindent\bf Other Authors:}\\ }{}
      }{{\noindent\bf Authors:}\\}
      \@author\\
    }

    \vskip 0.25in

    \iftoggle{SpherexApproved}{
        {\LARGE\noindent\bf Approved By: \@approvername \\ \\}
        {\LARGE\noindent\bf Date: \@approvaldate}\\
        \vskip 0.25in
    }{}

    \tableofcontents

    \newpage
} % end \renewcommand{\maketitle}


%% Macros
\newcommand{\spherex}{SPHEREx}
\newcommand{\ipac}{IPAC}
