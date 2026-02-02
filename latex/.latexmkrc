# ============================================
# NOM DU FICHIER DE SORTIE
# Modifiez cette ligne pour chaque projet
# ============================================
my $output_name = 'output_document';

$out_dir = 'build';
$aux_dir = 'build';
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

$bibtex_use = 2;
$biber = 'biber --output-directory build %O %S';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('alg', 'alg', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    return system("makeglossaries", "-d", "build", $base_name);
}

$pdf_mode = 1;
$dvi_mode = 0;
$postscript_mode = 0;
$preview_continuous_mode = 1;
$max_repeat = 5;

$clean_ext = 'synctex.gz run.xml bbl bcf fdb_latexmk fls nav snm vrb acn acr alg glg glo gls ist lof lot out toc xwm app tdo';

$pdf_previewer = 'zathura %O %S';
$pdf_update_method = 4;
$pdf_update_command = 'kill -HUP %R';

$warnings_as_errors = 0;
