From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 06 Jan 2009 09:45:37 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090106094537.GB5061@osiris.boeblingen.de.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com> <20090105195415.GA6204@uranus.ravnborg.org> <alpine.DEB.1.10.0901051458460.25066@gandalf.stny.rr.com> <20090105213107.GA27293@uranus.ravnborg.org> <alpine.DEB.1.10.0901051649240.25066@gandalf.stny.rr.com> <20090105220156.GC8592@uranus.ravnborg.org> <alpine.DEB.1.10.0901051710450.25066@gandalf.stny.rr.com> <20090105231136.GA5073@osiris.boeblingen.de.ibm.com> <alpine.DEB.1.10.0901052326180.30989@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901052326180.30989@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

On Mon, Jan 05, 2009 at 11:30:58PM -0500, Steven Rostedt wrote:
> On Tue, 6 Jan 2009, Heiko Carstens wrote:
> Sam and Heiko,
> 
> I'm trying to see if the (a ? b : c) construct is causing the issue. Can 
> you test this patch.
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index d95da10..e13ad24 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -113,7 +113,8 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>   * "Define 'is'", Bill Clinton
>   * "Define 'if'", Steven Rostedt
>   */
> -#define if(cond) if (__builtin_constant_p((cond)) ? !!(cond) :		\
> +#define if(cond) if ((__builtin_constant_p((cond)) && !!(cond)) ||	\
> +		     (!__builtin_constant_p((cond)) &&			\

Doesn't help unfortunately.
