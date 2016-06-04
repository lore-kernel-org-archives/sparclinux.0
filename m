From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Sat, 04 Jun 2016 10:52:03 +0000
Subject: Re: [PATCH] sparc32: remove stale RTC_PORT definition
Message-Id: <20160604105203.GH4594@piout.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, rtc-linux@googlegroups.com, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 04/06/2016 at 11:36:44 +0200, Arnd Bergmann wrote :
> sparc32:allmodconfig fails to build in next-20160602 as follows.
> 
> In file included from drivers/block/floppy.c:185:0:
> include/linux/mc146818rtc.h: In function 'mc146818_is_updating':
> include/linux/mc146818rtc.h:138:9: error: 'rtc_port' undeclared (first use in this function)
> include/linux/mc146818rtc.h:138:9: note: each undeclared identifier is reported only once for each function it appears in
> include/linux/mc146818rtc.h: In function 'mc146818_get_time':
> include/linux/mc146818rtc.h:172:17: error: 'rtc_port' undeclared (first use in this function)
> include/linux/mc146818rtc.h: In function 'mc146818_set_time':
> include/linux/mc146818rtc.h:278:8: error: 'rtc_port' undeclared (first use in this function)
> scripts/Makefile.build:295: recipe for target 'drivers/block/floppy.o' failed
> 
> The reason is a duplicate definition of the RTC_PORT macro. The
> one in arch/sparc/include/asm/io_32.h was apparently used a long time
> ago for the drivers/char/rtc.c driver that is not available on SPARC
> any more, since we now select 'RTC_CLASS' unconditionally.
> 
> Removing the macro fixes the build problem, and for consistency,
> this also removes the RTC_ALWAYS_BCD macro and the comment for both.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: fd09cc80165c ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
> ---
> I thought I'd sent this out yesterday, but cannot find an indication of
> that now, and Alexandre didn't seem to get it. This should probably
> go through the rtc tree that introduced the build failure after my
> earlier patches
> 
>  arch/sparc/include/asm/io_32.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
