From: RChan <rspchan@starhub.net.sg>
Date: Wed, 05 Jan 2005 00:20:22 +0000
Subject: SIGHUP or TERM to agetty/sunsu.c causes hard lockup
Message-Id: <41DB32C6.2010608@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

Summary: Running 2.6.10, agetty on ttyS1 managed by sunsu.c causes the 
machine
to lockup hard if agetty receives a TERM or HUP signal.
I have observed this ever since 2.6.8 and after sunsu.c interrupt
fixes. This doesn't happen on 2.4.27/8.

Machine is a SunFire V210
I finally found out why shutdown -r/shutdown -h would cause a
hard lockup on the machine. It happens during the SIGTERM sent
to all processes.

If I send a HUP or TERM signal to agetty on the serial port the
machine locks up hard with no Ooops on console (not surprising
since the console is on ttyS0). No messages even if the console is
running on the fb (Sun XVR-100).

If I have a login shell/bash running on the serial port I can send
a SIGHUP to bash and the port closes gracefully and agetty is
restarted.  The system killer is agetty receiving signals.

Any ideas?

Cheers
Richard
