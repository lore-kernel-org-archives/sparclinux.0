From: Jan Engelhardt <jengelh@medozas.de>
Date: Sun, 29 Nov 2009 19:34:56 +0000
Subject: setsockopt number collisions
Message-Id: <alpine.LSU.2.00.0911292034010.5701@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I notice that SO_PEERCRED (sparc-only definition of it, 
arch/sparc/include/asm/socket.h) collides with IPT_SO_BASE_CTL. How 
would this be resolved?
