From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 21 Apr 2007 15:48:01 +0000
Subject: Re: Soft Lockup on sun4c
Message-Id: <Pine.LNX.4.61.0704211747030.9989@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Apr 20 2007 13:22, Mark Fortescue wrote:
> Hi,
>
> Can any one advise me on what boot options I can set to identify what is going
> on during boot on my sun4c.
>
> The crash requires a power up reset (L1-A does not work).

For this one: Make sure that /proc/sys/kernel/stop-a is enabled.


Jan
-- 
