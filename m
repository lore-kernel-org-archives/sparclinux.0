From: Bob Breuer <breuerr@mc.net>
Date: Thu, 11 Nov 2004 02:46:44 +0000
Subject: hme broken on 2.6 hypersparc
Message-Id: <4192D294.8090305@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With the previous hypersparc fixes on 2.6.9, I am getting errors
with the hme driver.  It reports EOP not set in transmit descriptor.

By chance, I reverted the fix to srmmu.c, and now it works.

However, I had specifically tested that srmmu change in 2.4.27
and everything I tested there, including hme, is working.

Any ideas on where the real problem may be?

Bob
