From: =?iso-2022-jp?B?GyRCP0BFRCEhPjAbKEI=?= <hikanda@zlab.co.jp>
Date: Tue, 21 Jun 2016 10:36:42 +0000
Subject: RE: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <TYXPR01MB05893FD71E27BA04B44B5625992B0@TYXPR01MB0589.jpnprd01.prod.outlook.com>
List-Id: <sparclinux.vger.kernel.org>
References: <TYXPR01MB0589F696D4EADB7B1244D97A99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>,<20160617.231234.1295900275353757289.davem@davemloft.net>
In-Reply-To: <20160617.231234.1295900275353757289.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, David

Thank you for your reply.

> If you can really trigger this code path, please post the kernel log
> backtrace that happens when the BUG() triggers.  That way we can
> figure out what the real problem is.
I'm sorry I cannot show the information. I don't have now.
In fact, BUG() in do_sparc64_fault occurred in modified version
of linux-2.6.25.8 on SPARC64VIIIfx. I'm misunderstanding that
the same problem remains in the latest. 

> Your patch is also wrong for other reasons, it would break the
> unaligned trap code paths that don't go via user_rtt_fill_64bit
> fixups.
And from the first, I was wrong. I got it.

I have some questions.
I think that if %tl > 1, winfix_mna will be called. Is it correct?
And, the call trace is never occurred?

________________________________________
From: David Miller <davem@davemloft.net>
Date: 2016年6月18日 15:12
To: 神田　尚
CC: sparclinux@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Swap registers for fault code and address in mna trap

From: 神田　尚 <hikanda@zlab.co.jp>
Date: Fri, 17 Jun 2016 01:49:11 +0000

> This bug may occur in the following.
>
> user_rtt_fill_64bit          <= If mna trap occurred, call do_mna
> +-> do_mna                   <= Mistake storing registers for fault code and address
>     +-> winfix_mna
>         +-> user_rtt_fill_fixup  <= Put fault address into thread_info->flag's TI_FAULT_CODE
>             +-> do_sparc64_fault() <= If fault address has FAULT_CODE_ITLB and FAULT_CODE_DTLB bits, call BUG()
>                 +-> BUG()

We should not be invoking do_sparc64_fault() in this case.

Instead, we call either sun4v_do_mna() or mem_address_unaligned().

Neither of which care about the values stored in the thread's fault
address and code.

If you can really trigger this code path, please post the kernel log
backtrace that happens when the BUG() triggers.  That way we can
figure out what the real problem is.

Your patch is also wrong for other reasons, it would break the
unaligned trap code paths that don't go via user_rtt_fill_64bit
fixups.

