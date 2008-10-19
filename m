From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Sun, 19 Oct 2008 23:31:52 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02 rtcs
Message-Id: <a4423d670810191631n35b08539jc57e7e19db4ac76e@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> It seems to me the problem is here:
>
> drivers/rtc/rtc-m48t59.c
> static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
>
> /*  tm->tm_year is 108 here */
>        val = M48T59_READ(M48T59_WDAY);

M48T59_READ(M48T59_WDAY) is 0x31 on my host
M48T59_WDAY_CEB | M48T59_WDAY_CB | M48T59_UNUSED ??

What is wrong?

Should BCD2BIN(M48T59_READ(M48T59_YEAR)) return "8" ?

>        if ((pdata->type = M48T59RTC_TYPE_M48T59) &&
>            (val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB)) {
>                dev_dbg(dev, "Century bit is enabled\n");
>                tm->tm_year += 100;     /* one century */
>        }
> /* tm->tm_year  is 208 here */
>
> Finally year becomes 2108.
>
> It should not enter this condition.
> Is it obvously how to rewrite the condition or is the problem in another place?
>
