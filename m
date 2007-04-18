From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 18 Apr 2007 18:55:35 +0000
Subject: Prom Watchdog Reset
Message-Id: <Pine.LNX.4.61.0704181949500.12028@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On my sun4c OPUSstation (Sparc 1 clone) I regularly get tripped back 
to the Prom during boot:

...
ok boot vmlinuz -p
Booting from: sd(0,0,0)vmlinuz -p
root on sd0a fstype 4.2
Size: 2675008+0+142756 bytes
Booting Linux...
Watchdog reset
Window Underflow
ok

The boot prom is Revision 1.0. Is there a way of doing a full Prom reset 
as part of the boot sequence to try and remove this issue.

If I redo the boot or do a powerup reset boot, there is no issue at this 
point.

Regards
 	Mark Fortescue.

