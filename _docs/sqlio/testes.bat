sqlio -kR -frandom     -s10 -t4 -o4 -b64  -LS -Fparam.txt > c-r-ran-064.txt
sqlio -kR -fsequential -s10 -t4 -o4 -b64  -LS -Fparam.txt > c-r-seq-064.txt
sqlio -kW -frandom     -s10 -t4 -o4 -b64  -LS -Fparam.txt > c-w-ran-064.txt
sqlio -kW -fsequential -s10 -t4 -o4 -b64  -LS -Fparam.txt > c-w-seq-064.txt