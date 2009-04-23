From: David Miller <davem@davemloft.net>
Date: Thu, 23 Apr 2009 14:09:43 +0000
Subject: debian unusable on niagara
Message-Id: <20090423.070943.158757350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I really didn't expect this, and then I saw other users complaining
too.

1) Please remove the PROM console driver from the kernel config, it
   does nothing but get in the way.  This will fix the "console slow
   on bootup" problem everyone reports on niagara boxes.

   Putting "console=ttyHV0" on the kernel command line works as a
   workaround but it still clears the screen once using the PROM
   console and even that takes nearly a minute (!).

2) Please fix the GETTY setup so that it properly uses ttyS0 on
   Niagara.  Otherwise people have no console and can't use their
   machine at all after installation.

   Ubuntu does this by making sure there is an /etc/event.d/ttyS0
   file with a line saying "exec /sbin/getty -L ttyS0 9600 vt102"
   or similar.

Between the ultra45 unbootable problem and these, I'm really losing
faith... :-/
