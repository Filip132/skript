#!/bin/bash
function check {
a=`echo $path | awk -F "." '{print $2}' | awk -F " " '{print $1}'`
if [[ $a == "jpg" ]] || [[ $a == "png" ]] || [[ $a == "JPG" ]] || [[ $a == "PNG" ]] || [[ $a == "*" ]]; then
valid=1
else
valid=0
echo "Špatný typ souboru!"
fi
return $valid
}

function ending {
if [[ $choice == 1 ]]; then
end="jpg"
elif [[ $choice == 2 ]]; then
end="png"
fi
npath=`echo $path | awk -F "." '{print $1}'`
if [[ $choice == 1 ]]; then
convert $path $npath.jpg
elif [[ $choice == 2 ]]; then
convert $path $npath.png
fi
return
}

function formatCheck {
a=`echo $path | awk -F "." '{print $2}' | awk -F " " '{print $1}'`
if [ $choice == a ]; then
	if [[ $a == "png" ]] || [[ $a == "PNG" ]]; then
	valid=1
	else
	valid=0
	echo "Špatný typ souboru!"
	fi
elif [ $choice == b ]; then
	if [[ $a == "jpg" ]] || [[ $a == "JPG" ]]; then
        valid=1
        else
        valid=0
        echo "Špatný typ souboru!"
	fi
fi
return $valid
}

choice=55
until [ $choice == e ]; do
	valid=2
	echo "||------------------------------------------------||"
	echo "||------------   MENU   --------------------------||"
	echo "||----------               -----------------------||"
	echo "||--------a) změna rozlišení ---------------------||"
	echo "||--------b) efekty          ---------------------||"
	echo "||------- c) změna formátu   ---------------------||"
	echo "||--------d) otočení         ---------------------||"
	echo "||--------e) změna kvality   ---------------------||"
	echo "||------------------------------------------------||"
	echo "Tvoje volba: "
	read choice
	clear
	if [ $choice == a ]; then
		echo "Rozlišení"
		until [ $valid == 1 ]; do
		echo "Napiš cestu k obrazku: "
		read path
		check
		done
		echo "Napiš nové rozlišení: "
		read kvalita
		convert $path -resize $kvalita $path
		echo "Rozlišení bylo změněno!"
	elif [ $choice == b ]; then
		echo "||------------------------||"
		echo "||----- Efekt MENU   -----||"
		echo "||-----		   -----||"
		echo "||-----(a) Charcoal  -----||"
		echo "||-----(b) Implosion -----||"
		echo "||------------------------||"
		echo "Vyber možnost: "
		read choice
		until [ $valid == 1 ]; do
		echo "Napiš cestu k obrazku:"
		read path
		check
		done
		if [ $choice == a ]; then
			echo "Napiš číslo síly Charcoal efektu "
			read strength
			convert $path -charcoal $strength $path
			echo "Charcoal efekt použit!"
		elif [ $choice == b ]; then
			echo "Napiš číslo síly Implosion efektu: "
			read strength
			convert $path -implode $strength $path
			echo "Implosion efekt použit!"
		fi
	elif [ $choice == c ]; then
		echo "||------------------------||"
                echo "||----- Formát MENU  -----||"
                echo "||-----              -----||"
                echo "||-----1)png -> jpg  -----||"
                echo "||-----2)jpg -> png  -----||"
                echo "||------------------------||"
                echo "Vyber možnost: "

		read choice
		until [ $valid == 1 ]; do
		echo "Napiš cestu k obrázku: "
		read path
		formatCheck
		done
		ending
		echo "Formát změněn!"
	elif [ $choice == d ]; then
		echo "Otočení"
		until [ $valid == 1 ]; do
		echo "Napiš cestu k obrázku: "
		read path
		check
		done
		echo "Napiš úhel otočení: "
		read rotate
		convert $path -rotate $rotate $path
		echo "Obrazek otočen!"
	elif [ $choice == e ]; then
		echo "Kvalita"
		until [ $valid == 1 ]; do
		echo "Napiš cestu k obrázku: "
		read path
		check
		done
		echo "Napiš číslo kvality v obrazku "
		read quality
		convert $path -quality $quality $path
		echo "Kvalita změněna!"
	fi
done


