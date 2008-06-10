From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 20:01:13 +0000
Subject: Re: [PATCH 01/21] sparc: copy exported sparc64 specific header
Message-Id: <20080610.130113.186484755.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri,  6 Jun 2008 23:00:13 +0200

> To get rid of ALTARCH in Kbuild copy remaining
> exported header files that are sparc64 specific to asm-sparc.
> 
> Copy was done using the following simple script:
> 
> set -e
> SPARC64="apb.h bbc.h display7seg.h envctrl.h psrcompat.h pstate.h uctx.h utrap.h watchdog.h"
> for FILE in ${SPARC64}; do
> 	if [ -f asm-sparc/$FILE ]; then
> 		echo $FILE exist in asm-sparc
> 	fi
> 	cat asm-sparc64/$FILE > asm-sparc/$FILE
> 	printf "#include <asm-sparc/$FILE>\n" > asm-sparc64/$FILE
> done
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Thanks for doing this work Sam.

Looking over this particular patch made me notice that
asm/apb.h and asm/bbc.h should not be exported to userspace
at all.  And with some searching I verified that no userland
source bases include these files.

They are simply definitions of chip registers and do not
describe a userland interface of any kind, so this seems
about right.

psrcompat.h and pstate.h fall roughly into the same category,
but unfortunately things like strace include these files
(even though they really don't use the defines) so we have
to keep exporting them in order to not break userspace.

So what I'm going to do is apply the patch below first to
sparc-next-2.6, then apply this patch with the apb.h and bbc.h parts
removed.

Thanks!

sparc64 Kbuild: apb.h and bbc.h should not be exported to userspace

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 include/asm-sparc64/Kbuild |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/asm-sparc64/Kbuild b/include/asm-sparc64/Kbuild
index dce1cf9..7e88c12 100644
--- a/include/asm-sparc64/Kbuild
+++ b/include/asm-sparc64/Kbuild
@@ -4,9 +4,7 @@ ALTARCH := sparc
 ARCHDEF := defined __sparc__ && defined __arch64__
 ALTARCHDEF := defined __sparc__ && !defined __arch64__
 
-header-y += apb.h
 header-y += asi.h
-header-y += bbc.h
 header-y += bpp.h
 header-y += display7seg.h
 header-y += envctrl.h
-- 
1.5.5.1.308.g1fbb5

