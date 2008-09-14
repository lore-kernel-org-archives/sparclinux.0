From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 00:52:12 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914005212.GA29200@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 05:02:38PM -0700, David Miller wrote:
> I wonder if interrupts are getting through.
> 
> Can you watch /proc/interrupts when you try to use the card in the
> sparc box?

I don't have it plugged into the bad combination right now (need to get
more cables...), and I'm not there to change the wiring again, but I think
I have one data point:

* when I generate traffic over the working ttyS2 link, IRQ 19 appears in
  /proc/interrupts normally
* when I generate traffic over the broken as well as disconnected ttyS0
  link, IRQ 15 described as "su(serial), su(serial)" gets activated on CPU1
* when I generate traffic over the broken as well as disconnected ttyS1
  link, IRQ 15 described as "su(serial), su(serial)" gets activated on CPU0

That sounds to me like sunsu has developed an unhealthy attachment to
the ttyS[01] devices :) despite the fact it's 8250 which is supposed to
be handling them - there are no physical serial ports used by sunsu on
this v240, only the ALOM serial port.

For the record I then also noticed this:

% sudo ls -l /proc/tty/driver/
total 0
-r--r--r-- 1 root root 0 2008-09-14 02:16 serial
-r--r--r-- 1 root root 0 2008-09-14 02:16 sunsu

% sudo cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16C950/954 port:7FE01000930 irq:19 tx:290 rx:2875 fe:243 brk:12 RTS|CTS|DTR|DSR|CD
1: uart:16C950/954 port:7FE01000938 irq:19 tx:36 rx:33 RTS|DTR
2: uart:16550A port:7FE010009A0 irq:20 tx:0 rx:0
3: uart:16550A port:7FE010009A8 irq:20 tx:0 rx:0

% sudo cat /proc/tty/driver/sunsu 
serinfo:1.0 driver revision:                      
0: uart:16550A mmio:0x7FE010003F8 irq:15 tx:380 rx:0 RTS|CTS|DTR|DSR|CD
1: uart:16550A mmio:0x7FE010002E8 irq:15 tx:72 rx:0 RTS|DTR

That definitely sounds suspicious.

-- 
     2. That which causes joy or happiness.
