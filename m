From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Sun, 20 Feb 2005 18:48:55 +0000
Subject: Who restores %g6 for trap/irq handlers?
Message-Id: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Qemu's Sparc32 system emulator is getting to the point where the first user 
space application almost executes. But there is some strangeness with 
kernel's use of %g6, it's used for example in do_sparc_fault, but nothing is 
restoring it before that, so there is a kernel zero page access as a result. 
In  Qemu this means that the emulator halts. If I patch the kernel so that 
%g6 is restored in trap/irq handlers, the execution goes on (for example, 
page faults bring in user pages) until the next unpatched use of %g6 
happens.

How can this possibly work in a real hardware? The same %g6 system is used 
in 2.4. series, I'm currently using 2.6.11-rc4.

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

