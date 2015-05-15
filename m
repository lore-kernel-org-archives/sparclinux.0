From: John Stultz <john.stultz@linaro.org>
Date: Fri, 15 May 2015 23:46:28 +0000
Subject: Re: [PATCH 1/2] drivers/rtc/interface.c: Change rtc_set_mmss() to use time64_t
Message-Id: <CALAqxLW3e79ZHwvO8-R6KJ2gCxKTZ4tnvUSUN8y+gN6UuYctXw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1431682292-29732-1-git-send-email-xlpang@126.com>
In-Reply-To: <1431682292-29732-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xunlei Pang <xlpang@126.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

On Fri, May 15, 2015 at 2:31 AM, Xunlei Pang <xlpang@126.com> wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
>
> rtc_set_mmss() uses "unsigned long" as its second parameter which
> may have y2038 problem on 32-bit systems.
>
> Change it to use time64_t.
>
> All its call sites will be changed later(there are no problems
> leaving these call sites untouched).

This line isn't super convincing. Better to explain *why* there aren't
problems making this change first, rather then just asserting it, and
to give some confidence you'll address this, point out that sparc is
the only user of this funciton and will be updated by the following
patch in the series.

thanks
-john
