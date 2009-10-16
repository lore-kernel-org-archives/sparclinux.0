From: hyl <heyongli@gmail.com>
Date: Fri, 16 Oct 2009 06:20:00 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <505766fa0910152320k4ca7393bl91df43d9fae63f7d@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
In-Reply-To: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

1. cat  /proc/interrupts (interval 2s-5s)

root@sun_netraT5220_turgo-1_ldom-3:/root> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
  0:      10803      10834      10832      10832      10831      10831
     10860      10830     <NULL>  timer
 17:         34          0          0          0          0          0
         0          0      sun4v  hvcons
 18:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 19:      27547          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 20:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 21:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 22:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 23:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 24:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 25:         31          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 26:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 27:          7          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 28:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 29:          6          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 30:          0          0          0          0          0          0
         0          0     vsun4v  vdiska TX
 31:         10          0          0          0          0          0
         0          0     vsun4v  vdiska RX
 32:          0          0          0          0          0          0
         0          0     vsun4v  DS TX
 33:         10          0          0          0          0          0
         0          0     vsun4v  DS RX
root@sun_netraT5220_turgo-1_ldom-3:/root> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
  0:      13930      13961      13959      13959      13958      13958
     13987      13957     <NULL>  timer
 17:         37          0          0          0          0          0
         0          0      sun4v  hvcons
 18:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 19:      27558          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 20:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 21:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 22:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 23:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 24:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 25:         34          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 26:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 27:          7          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 28:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 29:          6          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 30:          0          0          0          0          0          0
         0          0     vsun4v  vdiska TX
 31:         10          0          0          0          0          0
         0          0     vsun4v  vdiska RX
 32:          0          0          0          0          0          0
         0          0     vsun4v  DS TX
 33:         10          0          0          0          0          0
         0          0     vsun4v  DS RX
root@sun_netraT5220_turgo-1_ldom-3:/root> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
  0:      16314      16345      16343      16343      16342      16342
     16371      16341     <NULL>  timer
 17:         40          0          0          0          0          0
         0          0      sun4v  hvcons
 18:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 19:      27576          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 20:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 21:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 22:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 23:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 24:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 25:         40          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 26:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 27:          7          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 28:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 29:          6          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 30:          0          0          0          0          0          0
         0          0     vsun4v  vdiska TX
 31:         10          0          0          0          0          0
         0          0     vsun4v  vdiska RX
 32:          0          0          0          0          0          0
         0          0     vsun4v  DS TX
 33:         10          0          0          0          0          0
         0          0     vsun4v  DS RX
root@sun_netraT5220_turgo-1_ldom-3:/root> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
  0:      17078      17109      17107      17107      17106      17106
     17135      17105     <NULL>  timer
 17:         43          0          0          0          0          0
         0          0      sun4v  hvcons
 18:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 19:      27582          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 20:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 21:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 22:          0          0          0          0          0          0
         0          0     vsun4v  eth0 TX
 23:          7          0          0          0          0          0
         0          0     vsun4v  eth0 RX
 24:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 25:         40          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 26:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 27:          7          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 28:          0          0          0          0          0          0
         0          0     vsun4v  eth1 TX
 29:          6          0          0          0          0          0
         0          0     vsun4v  eth1 RX
 30:          0          0          0          0          0          0
         0          0     vsun4v  vdiska TX
 31:         10          0          0          0          0          0
         0          0     vsun4v  vdiska RX
 32:          0          0          0          0          0          0
         0          0     vsun4v  DS TX
 33:         10          0          0          0          0          0
         0          0     vsun4v  DS RX
root@sun_netraT5220_turgo-1_ldom-3:/root>


2. where is sc>?  i run uname -a in sunos
uname -a
SunOS sun_netraT5220_turgo-1 5.10 Generic_127111-05 sun4v sparc SUNW,Netra-T5220

F.Y.I, sorry for delay.

Yongli He
2009/10/15 David Miller <davem@davemloft.net>:
>
> [ Please retain CC: in all replies, thanks. ]
>
> Hey, I want to investigate this further because something about
> these traces still perplexes me.
>
> Could you get me some information?
>
> 1) Setup the failing case (but with one of the fixes in the kernel
>   so you can run commands), and grab the contens of /proc/interrupts
>   and post that output here.
>
> 2) What firmware and hypervisor are you running on this machine?
>   (you can get this via 'showhost' at the "sc>" prompt)
>
>   I'm running Sun System Firmware 7.1.7.h on my machine.
>
> The reason I ask #2 is that there is a hypervisor bug with LDC
> connections wherein the interrupt can be sent twice erroneously
> and this can cause loops in the per-cpu interrupt INO list.
>
> There is a partial workaround already in the tree:
>
> commit 5a606b72a4309a656cd1a19ad137dc5557c4b8ea
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Mon Jul 9 22:40:36 2007 -0700
>
>    [SPARC64]: Do not ACK an INO if it is disabled or inprogress.
>
>    This is also a partial workaround for a bug in the LDOM firmware which
>    double-transmits RX inos during high load.  Without this, such an
>    event causes the kernel to loop forever in the interrupt call chain
>    ACK'ing but never actually running the IRQ handler (and thus clearing
>    the interrupt condition in the device).
>
>    There is still a bad potential effect when double INOs occur,
>    not covered by this changeset.  Namely, if the INO is already on
>    the per-cpu INO vector list, we still blindly re-insert it and
>    thus we can end up losing interrupts already linked in after
>    it.
>
>    We could deal with that by traversing the list before insertion,
>    but that's too expensive for this edge case.
>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
> But, as stated, it cannot deal with all possibilities that result
> from this firmware bug.  Best is to have the most uptodate firmware
> with the fix.
>
