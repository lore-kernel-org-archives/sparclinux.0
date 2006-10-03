From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 03 Oct 2006 04:53:59 +0000
Subject: Problems with qla2xxx drivers in recent kernels
Message-Id: <20061003045359.GA4269@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The qlogicfc driver has been removed starting with 2.6.17, and qla2xxx driver was 
supposed to replace its functionality. By now we have received a couple of 
reports, stating that the qla2xxx drive in 2.6.17 and 2.6.18 does not detect the 
drives in SunFire 280R [0] and SunBlade 1000 [1], which qlogicfc in 2.6.16 works 
fine. I wonder whether this problem is known, and if it is, whether there are any 
plans to resolve it. 


[0] http://lists.debian.org/debian-sparc/2006/09/msg00053.html
[1] http://lists.debian.org/debian-sparc/2006/10/msg00007.html

Best regards,
-- 
Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
