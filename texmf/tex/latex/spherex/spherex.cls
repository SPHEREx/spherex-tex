%% SPHEREx document class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{spherex}[2021/04/26 SPHEREx document class]

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

%% \diagramIndex (sets \@diagramindex and SpherexDiagramIndex toggle)
\newtoggle{SpherexDiagramIndex}
\newcommand{\diagramindex}[1]{
  \toggletrue{SpherexDiagramIndex}
  \newcommand{\@diagramindex}{#1}
}

%% \difficulty (sets \@difficulty and SpherexDifficulty toggle)
\newtoggle{SpherexDifficulty}
\newcommand{\difficulty}[1]{
  \toggletrue{SpherexDifficulty}
  \newcommand{\@difficulty}{#1}
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

%% \spherexHandle
\newcommand{\@spherexHandle}{}
\newcommand{\spherexHandle}[1]{
  \renewcommand{\@spherexHandle}{#1}
}

%% Headers
\pagestyle{fancy}
\fancyhf{}
\headheight = 0.6in
\topmargin = -0.5in
\headwidth = 6.5in
\lhead{\includegraphics[height=0.5in]{SPHEREx_logo.png}}
\chead{\large\ \@docCategoryName \vspace{10pt}\\\@docShortTitle}
\rhead{\@spherexHandle \vspace{10pt}\\Version \@version, \@docDate}
\footskip = 8.4pt
\cfoot{Page \thepage\ of \pageref{LastPage}}

%% Page layout
\RequirePackage[margin=1in]{geometry}

%% Title
\renewcommand{\maketitle}{
    \begin{center}
        {\LARGE\@spherexHandle}
        \vskip 0.25in
        {\Huge\bf\@title}
        \vskip 0.25in
        \iftoggle{SpherexVersion}{
            {\LARGE\bf Version: \@version}
            \vskip 0.25in
        }{}
        \iftoggle{SpherexPipeLevel}{
            {\LARGE\noindent\bf Pipeline Level: \@pipelevel \iftoggle{SpherexDiagramIndex}{\hspace{0.5in}Diagram Index: \@diagramindex}{} \iftoggle{SpherexDifficulty}{\hspace{0.5in}Difficulty: \@difficulty}{}}
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

%% Bibliography
\bibliographystyle{aasjournal}

%% Macros
\newcommand{\spherex}{SPHEREx}
\newcommand{\ipac}{IPAC}

%% Journal macros (adapted from aastex)
\let\jnl@style=\rmfamily 
\def\ref@jnl#1{{\jnl@style#1}}% 
\newcommand{\aj}{\ref@jnl{AJ}}%        % Astronomical Journal 
\newcommand{\araa}{\ref@jnl{ARA\&A}}%  % Annual Review of Astron and Astrophys 
\newcommand{\apj}{\ref@jnl{ApJ}}%    % Astrophysical Journal 
\newcommand{\apjl}{\ref@jnl{ApJL}}     % Astrophysical Journal, Letters 
\newcommand{\apjs}{\ref@jnl{ApJS}}%    % Astrophysical Journal, Supplement 
\newcommand{\ao}{\ref@jnl{ApOpt}}%   % Applied Optics 
\newcommand{\apss}{\ref@jnl{Ap\&SS}}%  % Astrophysics and Space Science 
\newcommand{\aap}{\ref@jnl{A\&A}}%     % Astronomy and Astrophysics 
\newcommand{\aapr}{\ref@jnl{A\&A~Rv}}%  % Astronomy and Astrophysics Reviews 
\newcommand{\aaps}{\ref@jnl{A\&AS}}%    % Astronomy and Astrophysics, Supplement 
\newcommand{\azh}{\ref@jnl{AZh}}%       % Astronomicheskii Zhurnal 
\newcommand{\baas}{\ref@jnl{BAAS}}%     % Bulletin of the AAS 
\newcommand{\icarus}{\ref@jnl{Icarus}}% % Icarus
\newcommand{\jaavso}{\ref@jnl{JAAVSO}}  % The Journal of the American Association of Variable Star Observers
\newcommand{\jrasc}{\ref@jnl{JRASC}}%   % Journal of the RAS of Canada 
\newcommand{\memras}{\ref@jnl{MmRAS}}%  % Memoirs of the RAS 
\newcommand{\mnras}{\ref@jnl{MNRAS}}%   % Monthly Notices of the RAS 
\newcommand{\pra}{\ref@jnl{PhRvA}}% % Physical Review A: General Physics 
\newcommand{\prb}{\ref@jnl{PhRvB}}% % Physical Review B: Solid State 
\newcommand{\prc}{\ref@jnl{PhRvC}}% % Physical Review C 
\newcommand{\prd}{\ref@jnl{PhRvD}}% % Physical Review D 
\newcommand{\pre}{\ref@jnl{PhRvE}}% % Physical Review E 
\newcommand{\prl}{\ref@jnl{PhRvL}}% % Physical Review Letters 
\newcommand{\pasp}{\ref@jnl{PASP}}%     % Publications of the ASP 
\newcommand{\pasj}{\ref@jnl{PASJ}}%     % Publications of the ASJ 
\newcommand{\qjras}{\ref@jnl{QJRAS}}%   % Quarterly Journal of the RAS 
\newcommand{\skytel}{\ref@jnl{S\&T}}%   % Sky and Telescope 
\newcommand{\solphys}{\ref@jnl{SoPh}}% % Solar Physics 
\newcommand{\sovast}{\ref@jnl{Soviet~Ast.}}% % Soviet Astronomy 
\newcommand{\ssr}{\ref@jnl{SSRv}}% % Space Science Reviews 
\newcommand{\zap}{\ref@jnl{ZA}}%       % Zeitschrift fuer Astrophysik 
\newcommand{\nat}{\ref@jnl{Nature}}%  % Nature 
\newcommand{\iaucirc}{\ref@jnl{IAUC}}% % IAU Cirulars 
\newcommand{\aplett}{\ref@jnl{Astrophys.~Lett.}}%  % Astrophysics Letters 
\newcommand{\apspr}{\ref@jnl{Astrophys.~Space~Phys.~Res.}}% % Astrophysics Space Physics Research 
\newcommand{\bain}{\ref@jnl{BAN}}% % Bulletin Astronomical Institute of the Netherlands 
\newcommand{\fcp}{\ref@jnl{FCPh}}%   % Fundamental Cosmic Physics 
\newcommand{\gca}{\ref@jnl{GeoCoA}}% % Geochimica Cosmochimica Acta 
\newcommand{\grl}{\ref@jnl{Geophys.~Res.~Lett.}}%  % Geophysics Research Letters 
\newcommand{\jcp}{\ref@jnl{JChPh}}%     % Journal of Chemical Physics 
\newcommand{\jgr}{\ref@jnl{J.~Geophys.~Res.}}%     % Journal of Geophysics Research 
\newcommand{\jqsrt}{\ref@jnl{JQSRT}}%   % Journal of Quantitiative Spectroscopy and Radiative Trasfer 
\newcommand{\memsai}{\ref@jnl{MmSAI}}% % Mem. Societa Astronomica Italiana 
\newcommand{\nphysa}{\ref@jnl{NuPhA}}%     % Nuclear Physics A 
\newcommand{\physrep}{\ref@jnl{PhR}}%       % Physics Reports 
\newcommand{\physscr}{\ref@jnl{PhyS}}%        % Physica Scripta 
\newcommand{\planss}{\ref@jnl{Planet.~Space~Sci.}}%  % Planetary Space Science 
\newcommand{\procspie}{\ref@jnl{Proc.~SPIE}}%      % Proceedings of the SPIE 
\newcommand{\actaa}{\ref@jnl{AcA}}%  % Acta Astronomica
\newcommand{\caa}{\ref@jnl{ChA\&A}}%  % Chinese Astronomy and Astrophysics
\newcommand{\cjaa}{\ref@jnl{ChJA\&A}}%  % Chinese Journal of Astronomy and Astrophysics
\newcommand{\jcap}{\ref@jnl{JCAP}}%  % Journal of Cosmology and Astroparticle Physics
\newcommand{\na}{\ref@jnl{NewA}}%  % New Astronomy
\newcommand{\nar}{\ref@jnl{NewAR}}%  % New Astronomy Review
\newcommand{\pasa}{\ref@jnl{PASA}}%  % Publications of the Astron. Soc. of Australia
\newcommand{\rmxaa}{\ref@jnl{RMxAA}}%  % Revista Mexicana de Astronomia y Astrofisica
\newcommand{\maps}{\ref@jnl{M\&PS}}% Meteoritics and Planetary Science
\newcommand{\aas}{\ref@jnl{AAS Meeting Abstracts}}% American Astronomical Society Meeting Abstracts
\newcommand{\dps}{\ref@jnl{AAS/DPS Meeting Abstracts}}% American Astronomical Society/Division for Planetary Sciences Meeting Abstracts
\let\astap=\aap 
\let\apjlett=\apjl 
\let\apjsupp=\apjs 
\let\applopt=\ao 
