From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 05:57:03 +0000
Subject: Re: Fix for break handling in sunsab.c for 2.6
Message-Id: <20041208215703.3ce64fe4.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 21 Nov 2004 13:43:05 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> Due to some bugs in break handling in the sunsab.c serial driver, sending 
> a break over serial console (equivalent of Stop-A sent from keyboard) does 
> not dump user to the PROM command line. AFAICT, in the 2.4 -> 2.6 
> transition the checking for break has been moved from check_status() to 
> receive_chars(). However, in the current version of the driver the BRK 
> interrupt never reaches receive_chars(). Even if it would, for the break 
> to take effect a non-zero count of characters must be present in the
> buffer at the same time, which never happens. The patch below corrects the 
> problem (I have tried to make it as unintrusive as possible).

Patch applied, thanks a lot Jurij.
