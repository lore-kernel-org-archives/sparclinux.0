From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 05 Mar 2007 01:50:45 +0000
Subject: [6/6] 2.6.21-rc2: known regressions
Message-Id: <20070305015045.GK3441@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, "David S. Miller" <davem@sunset.davemloft.net>, sparclinux@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oneukum@suse.de>, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, Craig Schlenter <craig@codefountain.com>, Paul Rolland <rol@as2917.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, David Brownell <david-b@pacbell.net>, a.zummo@towertech.it, rtc-linux@googlegroups.com

This email lists some known regressions in 2.6.21-rc2 compared to 2.6.20
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : sparc64 compile error due to GENERIC_ISA_DMA removal
References : http://bugzilla.kernel.org/show_bug.cgi?id=8097
Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
Caused-By  : David S. Miller <davem@sunset.davemloft.net>
             commit 1b51d3a08b6c80a1e47d4c579c41abbe56cd3c44
Status     : unknown


Subject    : mmc reader no longer works
References : http://lkml.org/lkml/2007/2/27/91
Submitter  : Pavel Machek <pavel@ucw.cz>
Caused-By  : Oliver Neukum <oneukum@suse.de>
Status     : problem is being debugged


Subject    : usb-serial broken
             (ftdi serial device shows up as ttyUSB140 instead of ttyUSB0)
Submitter  : Craig Schlenter <craig@codefountain.com>
Caused-By  : Oliver Neukum <oneukum@suse.de>
             commit 34ef50e5b1f96c2d8c0f3d28b7d407743806256c
Handled-By : Oliver Neukum <oneukum@suse.de>
Status     : patch available


Subject    : Oops in rtc_cmos
References : http://lkml.org/lkml/2007/3/4/112
             http://lkml.org/lkml/2007/2/18/172
Submitter  : Paul Rolland <rol@as2917.net>
             Rafael J. Wysocki <rjw@sisk.pl>
Caused-By  : David Brownell <david-b@pacbell.net>
             commit 7be2c7c96aff2871240d61fef508c41176c688b5
Patch      : http://lkml.org/lkml/2007/2/23/184
Status     : patch available

