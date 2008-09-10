From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 10 Sep 2008 05:16:57 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20080910071657.006d4520.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 09 Sep 2008 22:07:47 -0400
Robert Reif <reif@earthlink.net> wrote:

> Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> >
> > Fix setting of a year in m48t08 and m48t02 clocks.
> > They do not have century bits and setting them
> > causes the year to overflow (bit 0x80 set).
> >   
> I think this fix is also needed.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>
> 

It should not be needed because these bits are always 0
on m48t08 and m48t02. The previous fix did not set them
so they should not change.

Have you needed this?

Anyway, this patch does not hurt, either.

Regards,
Krzysztof

> 
> 
[rtc.diff.txt  text/plain (592B)]
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 761e9d7..ce4eff6 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -82,7 +82,8 @@ static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday	= BCD2BIN(M48T59_READ(M48T59_MDAY));
 
 	val = M48T59_READ(M48T59_WDAY);
-	if ((val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB)) {
+	if ((pdata->type = M48T59RTC_TYPE_M48T59) &&
+	    (val & M48T59_WDAY_CEB) && (val & M48T59_WDAY_CB)) {
 		dev_dbg(dev, "Century bit is enabled\n");
 		tm->tm_year += 100;	/* one century */
 	}


----------------------------------------------------------------------
Tanie polaczenia z Polska i ze swiatem
Sprawdz >>  http://link.interia.pl/f1f00 


