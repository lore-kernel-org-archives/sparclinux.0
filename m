From: David Miller <davem@davemloft.net>
Date: Sat, 18 Jun 2016 06:12:34 +0000
Subject: Re: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <20160617.231234.1295900275353757289.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <TYXPR01MB0589F696D4EADB7B1244D97A99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB0589F696D4EADB7B1244D97A99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: hikanda@zlab.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

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

