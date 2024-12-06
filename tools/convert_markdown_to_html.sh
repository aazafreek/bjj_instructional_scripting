explanation_dir=$1
html_dir=$2
plantilla_dir=$3

cd $explanation_dir
for file in *.md; do
	file_name=$( basename $file .md )
	cp $file $file.tmp
	sed -i 's/^```mermaid/<pre class="mermaid">/g' $file.tmp
	sed -i 's/^```/<\/pre>/g' $file.tmp
	touch $html_dir/$file_name.html
	cat "$plantilla_dir"/plantilla.html >> $html_dir/$file_name.html
	markdown $file.tmp >> $html_dir/$file_name.html
	echo "</body></html>" >> $html_dir/$file_name.html
	rm $file.tmp
done

