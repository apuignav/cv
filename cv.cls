\ProvidesClass{cv}[2014/09/15 CV class]
% Heavily based on friggieri-cv
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{amsmath}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{cvblue}{rgb}{0.22,0.45,0.70}

\ifdefined\@cv@print
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{cvblue}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{cvblue}
\colorlet{subheadercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%
\RequirePackage{xspace}
\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

% For the header
\newfontfamily\surnameheaderfont[]{Myriad Pro SemiCondensed}
\newfontfamily\nameheaderfont[]{Myriad Pro Light}
\newfontfamily\rolefont[]{Myriad Pro Light}
% For text
\newfontfamily\bodyfont[]{Myriad Pro SemiCondensed}
\newfontfamily\headingfont[]{Myriad Pro Bold Condensed}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text,
             Color=textcolor,
             Numbers=OldStyle,
             ItalicFont = {Myriad Pro Light Italic},
             BoldFont = {Myriad Pro Light}]{Myriad Pro Light}
\setmathfont{Myriad Pro Light Italic}
\setmathfont[range=\mathup,Color=textcolor]{Myriad Pro Light}
\setmathfont[range=\mathit,Color=textcolor]{Myriad Pro Light Italic}
\setmathfont[range=\mathbfit]{Myriad Pro SemiCondensed}
\setmathfont[range=\mathbfup]{Myriad Pro SemiCondensed Italic}
\setmathfont[range=\rightarrow]{Source Sans Pro Light}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\nameheaderfont #1}{\surnameheaderfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \rolefont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {
    \Large\headingfont\color{subheadercolor} #1%
  }
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%
\setlength{\tabcolsep}{0pt}

\renewcommand{\bfseries}{\headingfont\color{subheadercolor}}

\newcommand{\cventry}[4]{%
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
  #1
  &\parbox[t]{11.8cm}{%
    {\bodyfont #2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    \ifx
  &#4& 
    \else
      {\small #4}\vspace{1.5\parsep}%
    \fi
    }        
    \end{tabular*}\\[-1mm]
}

\newcommand{\desc}[2]{%
  #1&\parbox[t]{11.8cm}{%
    \ifx&#2& 
    \else
        #2\vspace{1.5\parsep}%
    \fi
}\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{subheadercolor} ##1\\[0.5mm]}
  }
  \begin{textblock}{3.6}(1.5, 4.33)
  \begin{flushright}
  %\obeycr
}{%
  %\restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}

% EOF
