From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Thu, 04 Sep 2008 16:57:04 +0000
Subject: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02 rtcs
Message-Id: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix setting of a year in m48t08 and m48t02 clocks.
They do not have century bits and setting them
causes the year to overflow (bit 0x80 set).

Problem found by Robert Reif on Sun Sparcstation 20.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

I am sorry. I was sure I had tested setting of time
and date on SS20 but I did not obviously.

diff -urp linux-old/drivers/rtc/rtc-m48t59.c linux-sparc/drivers/rtc/rtc-m48t59.c
--- linux-old/drivers/rtc/rtc-m48t59.c	2008-09-03 18:14:22.000000000 +0200
+++ linux-sparc/drivers/rtc/rtc-m48t59.c	2008-09-04 18:47:40.636685547 +0200
@@ -126,7 +126,7 @@ static int m48t59_rtc_set_time(struct de
 	M48T59_WRITE((BIN2BCD(tm->tm_mon + 1) & 0x1F), M48T59_MONTH);
 	M48T59_WRITE(BIN2BCD(tm->tm_year % 100), M48T59_YEAR);
 
-	if (tm->tm_year/100)
+	if (pdata->type = M48T59RTC_TYPE_M48T59 && (tm->tm_year / 100))
 		val = (M48T59_WDAY_CEB | M48T59_WDAY_CB);
 	val |= (BIN2BCD(tm->tm_wday) & 0x07);
 	M48T59_WRITE(val, M48T59_WDAY);


----------------------------------------------------------------------
Nie szukam kochanka!
>> http://link.interia.pl/f1eeb

