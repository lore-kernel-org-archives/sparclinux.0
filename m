From: Dallas Helquist <dallas@oldbrownjeep.net>
Date: Tue, 19 Oct 2004 03:43:06 +0000
Subject: Sun Gigabit Ethernet - Sbus?
Message-Id: <41748D4A.5070308@oldbrownjeep.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I am trying to get a Sun GigabitEthernet Sbus (GBE/S) 2.0 working under 
linux in a E 4500.  The card is listed here: 
http://sunsolve.sun.com/handbook_pub/Devices/Ethernet/ETHER_GigabitEthernet_2.html

I can't seem to find anywhere where it is supported, although the post 
below from 3/2003 states that someone with the hardware should be able 
to port the sungem driver w/o too many troubles.  Has anyone achieved this?
http://marc.theaimsgroup.com/?l=linux-sparc&m4911488627253&w=2

Other than this, the box runs great.  All the qfe (well, 4 port hme) and 
hme cards work w/o any problems, and it seems the fiber channel cards 
work as well - though I haven't really tested them.

Any help/pointers with the gigE would be appreciated!

Thanks in advance -

-dallas
