From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 23 Oct 2008 17:32:28 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20081023193228.3e9633bd.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Oct 2008 03:31:52 +0400
"Alexander Beregalov" <a.beregalov@gmail.com> wrote:

> > It seems to me the problem is here:
> >
> > drivers/rtc/rtc-m48t59.c
> > static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >
> > /*  tm->tm_year is 108 here */
> >        val = M48T59_READ(M48T59_WDAY);
> 
> M48T59_READ(M48T59_WDAY) is 0x31 on my host
> M48T59_WDAY_CEB | M48T59_WDAY_CB | M48T59_UNUSED ??
> 
> What is wrong?
> 

It is ok. It is M48T59_WDAY_CEB | M48T59_WDAY_CB and 0x1 means Monday (week day number).

> Should BCD2BIN(M48T59_READ(M48T59_YEAR)) return "8" ?
> 

Yes. It should be 8 if you have not applied the last patch I sent ("Shift the first year to 1968 for Sun SPARC machines").
If the patch has been applied it would be 40 (decimal) means 1968+40  = 2008.

> >        if ((pdata->type = M48T59RTC_TYPE_M48T59) &&
> >            (val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB)) {
> >                dev_dbg(dev, "Century bit is enabled\n");
> >                tm->tm_year += 100;     /* one century */
> >        }
> > /* tm->tm_year  is 208 here */
> >
> > Finally year becomes 2108.
> >
> > It should not enter this condition.
> > Is it obvously how to rewrite the condition or is the problem in another place?

It should enter the condition if the century bit is set. The error is that the century bit is set somehow. 
It is possible in one of the previous versions of the rtc layer conversion code. The mentioned patch should fix it.

If the patch is applied could you reproduce the bug by rebooting the machine with the patched version of the kernel? (Set the correct date once then reboot).

Regards,
Krzysztof
PS. The easy way to reset the century bit should be to set the year before 2000 for a moment.



----------------------------------------------------------------------
Dzwon taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1f4e 

