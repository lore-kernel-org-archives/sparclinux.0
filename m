From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Thu, 06 Dec 2007 17:29:57 +0000
Subject: OBP versions [was: Re: SunOS/Solaris Binary Emulation]
Message-Id: <Pine.LNX.4.64.0712061828410.27032@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Dec 6 2007 10:39, Wes Hardin wrote:
>
> manhack:/usr/gnemul/solaris/bin# cat /proc/cpuinfo
> cpu             : TI UltraSparc II  (BlackBird)
> fpu             : UltraSparc II integrated FPU
> prom            : OBP 3.31.0 2001/07/25 20:31
> type            : sun4u
> ncpus probed    : 2
> ncpus active    : 2
> D$ parity tl1   : 0
> I$ parity tl1   : 0
> Cpu0Bogo        : 900.58
> Cpu0ClkTck      : 000000001ad33148
> Cpu2Bogo        : 900.14
> Cpu2ClkTck      : 000000001ad33148
> MMU Type        : Spitfire
> State:
> CPU0:           online
> CPU2:           online

Interesting. Look at mine:

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
prom            : OBP 3.30.0 2003/11/11 10:37
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 0000000017d78400
Cpu1ClkTck      : 0000000017d78400
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online


My OBP's version number is lower, yet more current. (I already updated 
it with what is on the sun website)
Where did SUN sleep at this time?
