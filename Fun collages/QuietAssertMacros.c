//
//  QuietAssertMacros.c
//  Fun collages
//
//  Created by Yang Song on 8/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#include <dlfcn.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "fishhook.h"

int slient_fprintf(FILE * restrict stream, const char * restrict format, ...)
{
    if (strncmp(format, "AssertMacros:", 13) == 0)
    {
        return 0;
    }
    else
    {
        va_list args;
        va_start(args, format);
        int result = vfprintf(stream, format, args);
        va_end(args);
        return result;
    }
}

__attribute__((constructor)) void QuietAssertMacros(void)
{
    rebind_symbols((struct rebinding[1]){{"fprintf", slient_fprintf}}, 1);
}