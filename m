From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 03 Dec 2012 19:35:58 +0000
Subject: Re: [PATCH] sparc64: exit_group should kill register windows just like plain exit.
Message-Id: <20121203193558.GP4939@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20121203.143049.901444782954231849.davem@davemloft.net>
In-Reply-To: <20121203.143049.901444782954231849.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 03, 2012 at 02:30:49PM -0500, David Miller wrote:
> 
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/sys32.S      |  2 +-
>  arch/sparc/kernel/syscalls.S   | 14 ++++++++++++--
>  arch/sparc/kernel/systbls_64.S |  2 +-
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
> index 44025f4..8475a47 100644
> --- a/arch/sparc/kernel/sys32.S
> +++ b/arch/sparc/kernel/sys32.S
> @@ -47,7 +47,7 @@ STUB:	sra	REG1, 0, REG1; \
>  	sra	REG4, 0, REG4
>  
>  SIGN1(sys32_exit, sparc_exit, %o0)
> -SIGN1(sys32_exit_group, sys_exit_group, %o0)
> +SIGN1(sys32_exit_group, sparc_exit_group, %o0)

No need of that part, really.  sys_exit_group() will have its argument
(int) normalized all by itself.  The same goes for sys_exit(), so
sys32_exit is also pointless; just have sparc_exit/sparc_exit_group in
32bit syscall table, same as you do in 64bit one...
