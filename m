From: "C.Newport" <crn@netunix.com>
Date: Fri, 20 Aug 2004 20:56:06 +0000
Subject: Buglet making vmlinux with -j
Message-Id: <200408202156.06459.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If I build a 2.4.27 kernel with -j6 to strsss test an SMP system 
it compiles but silently finishes before linking.

Is this a bug or expected behaviour ?

