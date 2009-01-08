From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 12:54:20 +0000
Subject: Re: [PATCH v2 1/5] sparc: Create a new file lib/ksyms.c and add export of all symbols defined in ass
Message-Id: <20090108125420.GA16932@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1D3.9030606@gmail.com>
In-Reply-To: <4965F1D3.9030606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 08, 2009 at 11:30:11PM +1100, Julian Calaby wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> sparc: Create a new file lib/ksyms.c and add export of all symbols
> defined in assembler in lib/ to this file.
> 
> Remove the duplicate entries from kernel/sparc_ksyms_*.c
> 
> The rationale behind this is that the EXPORT_SYMBOL() should be close to
> their definition and we cannot add designate a symbol to be exported in
> assembler so at least put it in a file in the same directory.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Additions by Julian Calaby:
> * Rebased over sparc-2.6.git HEAD
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Hi Julian.

This patch fails a allmodconfig build on sparc64 in lib/ksysm.c

  CC      arch/sparc/lib/ksyms.o
arch/sparc/lib/ksyms.c:43: error: `_mcount' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:43: warning: type defaults to `int' in declaration of `_mcount'
arch/sparc/lib/ksyms.c:171: error: `xor_vis_2' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:171: warning: type defaults to `int' in declaration of `xor_vis_2'
arch/sparc/lib/ksyms.c:172: error: `xor_vis_3' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:172: warning: type defaults to `int' in declaration of `xor_vis_3'
arch/sparc/lib/ksyms.c:173: error: `xor_vis_4' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:173: warning: type defaults to `int' in declaration of `xor_vis_4'
arch/sparc/lib/ksyms.c:174: error: `xor_vis_5' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:174: warning: type defaults to `int' in declaration of `xor_vis_5'
arch/sparc/lib/ksyms.c:176: error: `xor_niagara_2' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:176: warning: type defaults to `int' in declaration of `xor_niagara_2'
arch/sparc/lib/ksyms.c:177: error: `xor_niagara_3' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:177: warning: type defaults to `int' in declaration of `xor_niagara_3'
arch/sparc/lib/ksyms.c:178: error: `xor_niagara_4' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:178: warning: type defaults to `int' in declaration of `xor_niagara_4'
arch/sparc/lib/ksyms.c:179: error: `xor_niagara_5' undeclared here (not in a function)
arch/sparc/lib/ksyms.c:179: warning: type defaults to `int' in declaration of `xor_niagara_5'
make[1]: *** [arch/sparc/lib/ksyms.o] Error 1
make: *** [arch/sparc/lib/ksyms.o] Error 2


Originally I thought that I could use asm/xor.h to pick up the
prototypes for the above functions.
But it turns out that xor.h _define_ two variables.

So my workaround was to add the prototypes in ksyms.c as we originally
did in sparc_ksyms_64.c.

To fix _mcount you need to include <asm/ftrace.h> - including <linux/ftrace.h> does not work.
See my earlier postings to sparclinux where you can see how I fixed this.

Please - keep on going and get these trivialities fixed.

Thanks,
	Sam
