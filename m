From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 09 Feb 2005 06:15:29 +0000
Subject: Re: Hang in SIOCGIFCONF ioctl handler
Message-Id: <20050208221529.5e3b05db.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502071259370.2050@bobcat>
In-Reply-To: <Pine.LNX.4.61.0502071259370.2050@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 9 Feb 2005 07:04:22 +0100
"Jurzitza, Dieter" <DJurzitza@harmanbecker.com> wrote:

> seing the communication between Jurij and Dave I took a glance into the 2.4.29 - tree and found the identical code segment as discussed below. This tells me that 2.4.X is supposed to suffer from the same issues as you tracked down for 2.6.X, isn't it? However, what I did not find is include/asm-sparc64/compat.h; this made me wonder whether I should expect a basic difference here, but maybe I simply misunderstood.

It's in arch/sparc64/kernel/ioctl32.c and arch/sparc64/kernel/sys_sparc32.c
and I've already fixed it in my local tree which will push over to Marcelo
soon.
