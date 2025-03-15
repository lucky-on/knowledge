/*
#include "ascii_table_generator.h"
PrintAsciiTable();
*/

#include <stdio.h>
#include <stdlib.h>

void PrintAsciiTable()
{
  int i{0};

  while(i<255)
  {
    printf("\n \a %d = %c ",i,i);
    i++;
  }
}
