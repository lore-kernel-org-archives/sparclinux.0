From: David Miller <davem@davemloft.net>
Date: Sat, 26 May 2007 22:47:45 +0000
Subject: Re: Linux always starts with 9600 8N1
Message-Id: <20070526.154745.30164056.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705261649590.7344@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0705261649590.7344@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 26 May 2007 16:57:53 +0200 (MEST)

> I have set the OBP to run at 115200, also set agetty on ttyS0 to do the 
> same, and also added console=ttyS0,115200 to silo.conf (and also tried 
> console=ttyS0,115200n8). But! Linux still gives me 9600 8N1. The ominous 
> double screen blanking (why is that done anyway?) already takes place 
> with 9600. I smell a bug. What do you think?

The code in drivers/serial/suncore.c:sunserial_console_termios()
should be parsing your OBP settings, add some tracing and see why it
isn't working.

Please track the bug down for us, thanks :-)
