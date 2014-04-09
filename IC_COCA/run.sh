#!/bin/bash
gcc -c mersenne.c -lm
gcc mersenne.o -o alg algorithm.c -lm
mv alg Testes
cd Testes
chmod +x vns_testes.sh
./vns_testes.sh
