From: Pasi Pirhonen <upi@iki.fi>
Date: Sat, 25 Feb 2006 19:16:05 +0000
Subject: Re: [PATCH]: SILO Niagara/SUN4V support
Message-Id: <20060225191605.GA8936@core.upi.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20060220.231515.26597106.davem@davemloft.net>
In-Reply-To: <20060220.231515.26597106.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Tue, Feb 21, 2006 at 11:04:46AM -0500, Ben Collins wrote:
> On Mon, 2006-02-20 at 23:15 -0800, David S. Miller wrote:
> > This patch against silo-1.4.10 makes SILO work on Niagara/SUN4V:
> 
> In order for me to test this patch completely, I'll need you to send me
> that sun4v system for a few weeks (stress testing and all) :)
> 
> I'll give it a go on my e3k tonight. It can usually expose bugs if they
> exist. While I'm at it, I'll do a build with the niagara patches to see
> if it causes any regressions as well.
> 

If it's worth anything, i did cook up a silo SRPM for myself with this
Niagara/SUN4V and '[PATCH]: Fix SILO initrd calculations' patch.

Booted just fine on 

# cat /proc/cpuinfo
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
promlib         : Version 3 Revision 31
prom            : 3.31.0
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu1Bogo        : 876.54
Cpu1ClkTck      : 000000001a3af0b8
Cpu2Bogo        : 876.54
Cpu2ClkTck      : 000000001a3af0b8
MMU Type        : Spitfire
State:
CPU1:           online
CPU2:           online

(Netra T 1405).

# silo -V
SILO version 1.4.10



-- 
Pasi Pirhonen - upi@iki.fi - http://iki.fi/upi/
