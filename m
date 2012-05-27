From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 27 May 2012 21:15:29 +0000
Subject: Re: [PATCH 1/4] sparc32: refactor cpu_idle()
Message-Id: <20120527211528.GA509@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1338043409-6827-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1338043409-6827-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 26, 2012 at 04:43:26PM +0200, Sam Ravnborg wrote:
> With the removal of sun4c we can use the same cpu_idle()
> implementation on UP and SMP.
> This also fix it so we use the same version independent on LEON
> enabled or not.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Hellstrom <daniel@gaisler.com>
> Cc: Konrad Eisele <konrad@gaisler.com>
> ---
>  arch/sparc/kernel/process_32.c |   28 ++--------------------------
>  1 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
> index fe6787c..7d6f60e 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -65,13 +65,13 @@ extern void fpsave(unsigned long *, unsigned long *, void *, unsigned long *);
>  struct task_struct *last_task_used_math = NULL;
>  struct thread_info *current_set[NR_CPUS];
>  
> -#ifndef CONFIG_SMP
> -
>  /*
>   * the idle loop on a Sparc... ;)
>   */
>  void cpu_idle(void)
>  {
> +        set_thread_flag(TIF_POLLING_NRFLAG);

That seems to be 8 spaces instead of a tab there.

-- 
     2. That which causes joy or happiness.
