From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 24 Oct 2006 03:16:43 +0000
Subject: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <20061024031642.GA4403@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a report by Roland Stigge (CC'd), who is trying to run 2.6.18 
on his SunBlade1000:

  I also noticed a regression with 2.6.18-1-sparc64, but it looks
  different from #392078. See screenshot at 
  http://people.debian.org/~stigge/sun4u.jpg : To prevent this "Cheetah
  error trap" ... "Irrecoverable deferred error trap", I'm using my old
  2.6.14-2-sparc64 kernel (didn't try sth. inbetween - considered useful?).

Roland later reported that the last working kernel for his box is 
2.6.16, and that the latest SunBlade 100/150 patch did not help with 
his problem in any way.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
