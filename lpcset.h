
#if !defined(lpset_h)
#define lpset_h

#include "lpcset.h"
#include "lpcode.h"


/*
** Extra information for the result of 'charsettype'.  When result is
** IChar, 'aux1' is the character.  When result is ISet, 'aux1' is the
** offset (in bytes), 'size' is the size (in bytes), and
** 'delt' is the default value for bytes outside the set.
*/
typedef struct {
  int aux1;
  int size;
  int deflt;
} charsetinfo;


Opcode charsettype (const byte *cs, charsetinfo *info);
byte getbytefromcharset (const byte *cs, const charsetinfo *info, int index);

#endif
