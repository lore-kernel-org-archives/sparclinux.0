From: David Miller <davem@davemloft.net>
Date: Thu, 09 Jun 2011 22:59:43 +0000
Subject: Re: [PATCH][RFC] Sparc: Remove trigraph in die_if_kernel() message.
Message-Id: <20110609.155943.162785602513776337.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.00.1106071627260.8844@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1106071627260.8844@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jj@chaosbits.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jesper Juhl <jj@chaosbits.net>
Date: Tue, 7 Jun 2011 16:38:19 +0200 (CEST)

> In arch/sparc/kernel/traps_32.c::do_priv_instruction() we have this:
> 
>   die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
> 
> If I'm not mistaken, that "??!" will be taken as a trigraph for "|" by the 
> preprocessor, so the final string will end up either as
>   "Penguin instruction from Penguin mode|?!"
> which I assume is not what we want, or as the correct string but with a 
> warning about an ignored trigraph which I assume we don't want either. So, 
> in order to elliminate the trigraph but keep the original string intact I 
> changed it to
> 
>   die_if_kernel("Penguin instruction from Penguin mode?""?!?!", regs);
> 
> I've tested with a small test program on my x86-64 host and it behaves as 
> I would expect, but I've not tested the actual code in 
> arch/sparc/kernel/traps_32.c since I have no way to compile for sparc 
> (which is why I submit this as a [RFC] patch).
> 
> Please take a look and apply if you agree :-)
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Applied, thanks Jesper :-)
