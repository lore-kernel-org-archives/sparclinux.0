From: David Miller <davem@davemloft.net>
Date: Mon, 30 Nov 2009 01:07:17 +0000
Subject: Re: setsockopt number collisions
Message-Id: <20091129.170717.138981284.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.00.0911292034010.5701@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.00.0911292034010.5701@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Sun, 29 Nov 2009 20:34:56 +0100 (CET)

> I notice that SO_PEERCRED (sparc-only definition of it, 
> arch/sparc/include/asm/socket.h) collides with IPT_SO_BASE_CTL. How 
> would this be resolved?

These don't live at different socket option levels?

If not, ho hum... this ought ot be fun to fix.
