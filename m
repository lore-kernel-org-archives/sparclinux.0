From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Aug 2008 06:32:33 +0000
Subject: Re: [PATCH] sh: fix semtimedop syscall
Message-Id: <20080828063232.GB21243@linux-sh.org>
List-Id: <sparclinux.vger.kernel.org>
References: <48B5379E.5050901@renesas.com>
In-Reply-To: <48B5379E.5050901@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 27, 2008 at 08:16:46PM +0900, Yoshihiro Shimoda wrote:
> fix the problem that cannot work semtimedop system call.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
> 
>  I think that SPARC has the similar bug.
>  However I cannot confirm it, because I don't have SPARC system.
> 
>  arch/sh/kernel/sys_sh.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
> index 59cd285..9061b86 100644
> --- a/arch/sh/kernel/sys_sh.c
> +++ b/arch/sh/kernel/sys_sh.c
> @@ -170,7 +170,7 @@ asmlinkage int sys_ipc(uint call, int first, int second,
>  	version = call >> 16; /* hack for backward compatibility */
>  	call &= 0xffff;
> 
> -	if (call <= SEMCTL)
> +	if (call <= SEMTIMEDOP)
>  		switch (call) {
>  		case SEMOP:
>  			return sys_semtimedop(first,

Good catch! This has been broken for a long time, at least it predates
git history.  At first glance, sh, sparc, and sparc64 have a
sys_semtimedop() reference that will never be invoked, while other
platforms (h8300, m68k, and m68knommu) don't implement it at all and
simply -ENOSYS (or -EINVAL) out.

Since these nommu platforms haven't supported semtimedop() since its
introduction in 2.5.52, they may want to think about hooking it up at
some point. Both glibc and uClibc support it today.

sparc64's compat_sys_ipc() does the right thing while the built-in
sys_ipc() has the same bug you've noted. So, here are the sparc/sparc64
bits.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sparc/kernel/sys_sparc.c   |    2 +-
 arch/sparc64/kernel/sys_sparc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc.c b/arch/sparc/kernel/sys_sparc.c
index 4d73421..af653a1 100644
--- a/arch/sparc/kernel/sys_sparc.c
+++ b/arch/sparc/kernel/sys_sparc.c
@@ -119,7 +119,7 @@ asmlinkage int sys_ipc (uint call, int first, int second, int third, void __user
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
-	if (call <= SEMCTL)
+	if (call <= SEMTIMEDOP)
 		switch (call) {
 		case SEMOP:
 			err = sys_semtimedop (first, (struct sembuf __user *)ptr, second, NULL);
diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
index 39749e3..4446730 100644
--- a/arch/sparc64/kernel/sys_sparc.c
+++ b/arch/sparc64/kernel/sys_sparc.c
@@ -439,7 +439,7 @@ asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 	long err;
 
 	/* No need for backward compatibility. We can start fresh... */
-	if (call <= SEMCTL) {
+	if (call <= SEMTIMEDOP) {
 		switch (call) {
 		case SEMOP:
 			err = sys_semtimedop(first, ptr,
