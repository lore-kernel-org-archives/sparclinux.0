From: "C.Newport" <crn@netunix.com>
Date: Thu, 19 Aug 2004 22:22:43 +0000
Subject: Sun4d SMP - retests - patch was not required
Message-Id: <200408192322.43126.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have done some more tests and found a surprise.
booting with -p causes the lockup at 
ioremap: done with statics switching to malloc.

This happens reliably, every time. Is this a clue ?.
 
Booting without -p boots reliably, which led me to suspect 
that my earlier tests may have been misleading.
Sure enough - reverting to the SMP kernel without the Pasi
spin_lock_bh patch does the same so it seems we probably 
do not need this.

More test results :-
Run top from serial console - OK

telnet in and tar -tf a kernel tarball - this sometimes completes
but always screws the keyboard input of the serial console.
If it does not complete it hangs, Load average goes to 1.0.

Another telnet - can kill the top session but serial kbd input is
still broken - kill the serial console root shell and all is well again.
Cannot kill the hung tar process.

Could this mean that interrupts might be getting
misrouted to the wrong CPU or process ?.

