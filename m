From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Mar 2012 20:16:49 +0000
Subject: Re: [PATCH] sparc: fix compile failure in kgdb_64.c
Message-Id: <20120330201649.GA16291@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Mar 30, 2012 at 03:31:24PM -0400, Paul Gortmaker wrote:
> To fix:
>=20
>   CC      arch/sparc/kernel/kgdb_64.o
>  arch/sparc/kernel/kgdb_64.c: In function 'smp_kgdb_capture_client':
>  arch/sparc/kernel/kgdb_64.c:121: error: implicit declaration of function=
 'flushw_all'
>  make[2]: *** [arch/sparc/kernel/kgdb_64.o] Error 1
>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>=20
> [tested on linux-next; presumably caused by the asm/system.h split]
>=20
> diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
> index 768290a..e916169 100644
> --- a/arch/sparc/kernel/kgdb_64.c
> +++ b/arch/sparc/kernel/kgdb_64.c
> @@ -8,6 +8,7 @@
>  #include <linux/ftrace.h>
> =20
>  #include <asm/kdebug.h>
> +#include <asm/cacheflush.h>
>  #include <asm/ptrace.h>
>  #include <asm/irq.h>

David already fixed this in the sparc tree and sent a pull request to Linus.
You can see his patch here:
https://git.kernel.org/?p=3Dlinux/kernel/git/davem/sparc.git;a=3Dcommitdiff=
;h=8Befc9f23c695395de011ced289c611fada22f35

Please note a small difference...
The include is placed in the top to maintain the "inverse christmas tree" o=
rder.
Longest includes first - and these with equal length are sorted alphabetica=
lly.

This is used for all new sparc code.

	Sam
