From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 10 May 2019 07:26:29 +0000
Subject: Naming conflict in the sunhv driver
Message-Id: <1c055245-5b9c-0261-fd48-0206bdb0b8ba@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave!

I just had a closer look at the sunhv driver over the issue with
the device name mismatching in /proc/consoles and below /sys [1].

The name mismatch actually seems a regression which was introduced
with:

commit d5a2aa241aa0babf382d42d6033b30a5112e4c1e
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Feb 13 21:28:40 2006 -0800

    [SPARC64] sunhv: Bug fixes.
    
    Add udelay to polling console write loop, and increment
    the loop limit.
    
    Name the device "ttyHV" and pass that to add_preferred_console()
    when we're using hypervisor console.
    
    Kill sunhv_console_setup(), it's empty.
    
    Handle the case where we don't want to use hypervisor console.
    (ie. we have a head attached to a sun4v machine)
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

This commit change the name field in the sunhv_console struct but not
in the sunhv_reg struct. Would it be okay when I send a patch to
fix this inconsistency and match the name in sunhv_reg with the one
in sunhv_console?

Without the fix, it's not possible to determine the serial console
device from /proc/consoles. This mismatch does not exist for other
SPARC serial hardware and hence code like debian-installer's "stealtty"
works correctly on these but not on SUN4V with the sunhv driver.

Adrian

> [1] https://marc.info/?l=linux-sparc&m5522695211174&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
