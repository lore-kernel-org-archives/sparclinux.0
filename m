From: David Miller <davem@davemloft.net>
Date: Sun, 10 Jan 2010 21:11:58 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <20100110.131158.242584083.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 8 Jan 2010 23:59:04 +0100 (CET)

> libc6   2.10.2-4

Perfect, now you just have to audit what changed between the -2 and
the -4 package to find the bug :-)
