:: Compile LaTeX 'book' into PDF
@echo off


:: Check for file
if exist %1.tex (
	GOTO Build
) else (
	echo No such .tex file: "%1"
	exit 1
)

:Build
	if "%~2"=="" (
		pdflatex.exe %1
	) else (
		pdflatex.exe %1 %2
	)
	echo Project %1 is compiled.
	GOTO prompt
	
:: Do you wish to remove junk files?	
:prompt
	set /P r=Do you wish to remove LaTeX junk (y/n)? 
	if %r%==y GOTO Remove
	if %r%==Y GOTO Remove
	if %r%==n exit 0
	if %r%==N exit 0
	
	GOTO prompt
	
		
:Remove
	:: Remove leftovers from latex
	del /s %1.aux %1.log %1.out
	:: Remove leftovers from bibtex
	del /s %1.bbl %1.blg %1.bcf
	:: Remove leftovers from glossaries
	del /s %1.glg %1.gls %1.glo
	:: Remove leftovers from lists
	del /s %1.lof %1.lot %1.toc
	:: Remove leftovers from minitoc
	del /s %1.mtc* %1.maf
	:: Remove other stuff
	del /s %1.run.xml
	del /s %1.acn %1.acr %1.alg
	del /s %1.ist %1.synctex* %1.alg
	
	echo Latex junk files successfully removed.
	exit 0
