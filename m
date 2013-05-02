From: "=?EUC-KR?B?uc7C+cij?=" <chanho.min@lge.com>
Date: Thu, 02 May 2013 00:58:02 +0000
Subject: Re: [PATCH] lib: add weak __clzsi2()/__clzdi2() functions
Message-Id: <OF7904F8C7.4731B9DC-ON49257B5F.00055048-49257B5F.0005504A@lge.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1367214005-14302-1-git-send-email-chanho.min@lge.com>
	<CAMuHMdWk4oi_KCmZv7hLZ7JSwy=meziKPBMQ1HJiJR9W8AdrDg@mail.gmail.com>
	<20130430144605.1a99a7397702b332ee818fc8@linux-foundation.org>
In-Reply-To: <20130430144605.1a99a7397702b332ee818fc8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, =?EUC-KR?B?wMyw5r3E?= <kyungsik.lee@lge.com>, Yann Collet <yann.collet.73@gmail.com>, Bob Pearson <rpearson@systemfabricworks.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Next <linux-next@vger.kernel.org>


>No, the link errors are for __ctzdi2, not __clzdi2.
>__ctzdi2 can be implemented using __ffs().
>> How's about we stop using __builtin_ctz[ll]() altogether?  Use N-fls()?
>
>That was my first suggestion ;-)
>
Do we remove existing __builtin_ct[l]z?
Some architecture's __builtin_clz will be more optimized than N-fls
IMHO, This is not only about __builtin- but also supporting another
libgcc functions in kernel.
Some future user may need __clz[t]s[d]i2 symbol also.

>> btw, this:
>>
>> int __weak __clzsi2(int val)
>> {
>>        return BITS_PER_LONG - fls(val);
>> }
>>
>> looks wrong.  It will give a different result for 32- and 64-bit.
>
>Indeed. It should be hardcoded 32.
>
I will re-work this for 64-bit, and ctz also.

Thanks
Chanho Min

