From: jbelshaw@tiscali.nl
Date: Mon, 12 Jan 2004 15:36:11 +0000
Subject: Betr: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <3FFB0C8D00008F60@ocpmta7.freegates.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have tried 2.6.1 on an ultra 1 and e5000 and I have no problems with the
serial console. Other problems of course...

Looking at your dmesg I see that you have a mouse entry which at first glance
looks a bit odd to me.

>Console: switching to colour frame buffer device 144x56
>mice: PS/2 mouse device common for all mice
>input: Sun Mouse on zs/serio1

Perhaps that is a problem ?
otherwise you can try eliminating the framebuffer console from the
config completely so there is only a serial console.

Regards,
John



