From: Adam Hunt <kinema@gmail.com>
Date: Sat, 14 Aug 2004 09:24:44 +0000
Subject: printk()s, sun4d and SMP
Message-Id: <b476569a04081402241c702af4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While reading though the archive I ran across a thread from December
'99 that says if the prink()s in calibrate_delay() were removed it was
possible to get sun4d machines like the SparcServers and SparcCenters
to boot in SMP mode.  I realize that we are talking about the 2.2 days
but is this hack possible with 2.4 or 2.6?

--adam
