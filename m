From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 23 Oct 2008 21:02:48 +0000
Subject: Re: [PATCH] rtc-m48t59: shift zero year to 1968 on sparc
Message-Id: <a4423d670810231402l14adfc81g925326f203806dd2@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
In-Reply-To: <20081023195123.c25069cd.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2008/10/23 Krzysztof Helt <krzysztof.h1@poczta.fm>:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> Shift the first year to 1968 for Sun SPARC machines.
>
> Move this logic from platform specific files to rtc driver
> as this fixes problems with correctly calculating a century
> bit.
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Tested-by: Alexander Beregalov <a.beregalov@gmail.com>

It works as expected, great. Thanks a lot!

rtc-m48t59 rtc-m48t59.0: setting system clock to 2008-10-24 00:55:11
UTC (1224809711)
