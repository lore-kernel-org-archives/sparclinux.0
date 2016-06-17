From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 17 Jun 2016 00:47:56 +0000
Subject: Re: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <CAGRGNgVYA0-hsw+mMwjAxOm-NRTDr9x+XfB2F2YUQEBf+6mAzw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <TYXPR01MB058946C0AC6B6523F82004FC99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB058946C0AC6B6523F82004FC99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?56We55SwIOWwmg==?= <hikanda@zlab.co.jp>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Hisashi,

On Fri, Jun 17, 2016 at 10:05 AM, 神田　尚 <hikanda@zlab.co.jp> wrote:
> From: "Hisashi Kanda" <hikanda at zlab dot co dot jp>

Could you please put your real email address here?

> I found a logical bug in SPARC code.
> So, I send this patch. Please check it.

Leave this part out, we only need the explanation of the potential
bug, if you're not sure, put any notes like this below the "---".

> This bug may occur in the following.
>
> user_rtt_fill_64bit          <= If mna trap occurred, call do_mna
> +-> do_mna                   <= Mistake storing registers for fault code and address
>     +-> winfix_mna
>         +-> user_rtt_fill_fixup  <= Put fault address into thread_info->flag's TI_FAULT_CODE
>             +-> do_sparc64_fault() <= If fault address has FAULT_CODE_ITLB and FAULT_CODE_DTLB bits, call BUG()
>                 +-> BUG()
>
> If mna trap occured in user_rtt_fill_64bit, then do_mna is called.
> So, fault address is loaded into %g4, and fault code is loaded into %g5 in do_mna.
> But, %g4 is stored into thread_info->flag's TI_FAULT_CODE, and
> %g5 is stored into thread_info->flag's TI_FAULT_ADDR in user_rtt_fill_fixup.
> This is a mistake. If fault address has FAULT_CODE_ITLB and
> FAULT_CODE_DTLB bits, BUG() may occur in do_sparc64_fault().
>
> The patch for this bug is the following.
> Kernel version is Linux 4.7-rc3.

You should put the kernel version this applies to below the "---".

> Signed-off-by: Hisashi Kanda <hikanda@zlab.co.jp>
>
> ---

i.e. here.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
