From: Ingo Molnar <mingo@elte.hu>
Date: Sat, 13 Jun 2009 19:40:27 +0000
Subject: Re: [PATCH] Bring sparc64 dynamic ftrace up to snuff...
Message-Id: <20090613194027.GA25439@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090613.011020.214065340.davem@davemloft.net>
In-Reply-To: <20090613.011020.214065340.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, rostedt@goodmis.org


* David Miller <davem@davemloft.net> wrote:

>  int ftrace_update_ftrace_func(ftrace_func_t func)
>  {
>  	unsigned long ip = (unsigned long)(&ftrace_call);
> -	unsigned char old[MCOUNT_INSN_SIZE], *new;
> +	u32 old, new;
>  
> -	memcpy(old, &ftrace_call, MCOUNT_INSN_SIZE);
> +	old = *(u32 *) &ftrace_call;

btw., just one (really stupid) question here: can ftrace_call be 
misaligned, and is misalignment a problem on Sparc? If it's not a 
problem then disregard the rest of the mail.

I dont see a particular alignment done in mcount.S:

ftrace_caller:
        mov             %i7, %o1
        mov             %o7, %o0
        .globl          ftrace_call
ftrace_call:
        call            ftrace_stub

so replacing an memcpy (which can copy misaligned buffers) with a 
direct assignment (which cannot) - wont that cause misalignment on 
Sparc?

	Ingo
