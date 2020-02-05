From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 05 Feb 2020 17:30:42 +0000
Subject: Re: [PATCH] kdb: Fix compiling on architectures w/out DBG_MAX_REG_NUM defined
Message-Id: <20200205173042.chqij5i53mncfzar@holly.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
In-Reply-To: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Chuhong Yuan <hslester96@gmail.com>, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Feb 04, 2020 at 02:12:25PM -0800, Douglas Anderson wrote:
> In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
> if current task has no regs") I tried to clean things up by using "if"
> instead of "#ifdef".  Turns out we really need "#ifdef" since not all
> architectures define some of the structures that the code is referring
> to.
> 
> Let's switch to #ifdef again, but at least avoid using it inside of
> the function.
> 
> Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for being so quick with this (especially when if I had been less
delinquent with linux-next it might have been spotted sooner).


> ---
> I don't have a sparc64 compiler but I'm pretty sure this should work.
> Testing appreciated.

I've just add sparc64 into my pre-release testing (although I have had to
turn off a bunch of additional compiler warnings in order to do so).


>  kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index b22292b649c4..c84e61747267 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
>  /*
>   * kdb_rd - This function implements the 'rd' command.
>   */
> +
> +/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
> +#if DBG_MAX_REG_NUM <= 0
> +static int kdb_rd(int argc, const char **argv)
> +{
> +	if (!kdb_check_regs())
> +		kdb_dumpregs(kdb_current_regs);
> +	return 0;
> +}
> +#else

The original kdb_rd (and kdb_rm which still exists in this file) place
the #if inside the function and users > 0 so the common case was
covered at the top and the fallback at the bottom.

Why change style when re-introducing this code?


Daniel.
