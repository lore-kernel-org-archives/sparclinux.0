From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Date: Sat, 15 May 2004 16:20:16 +0000
Subject: [LONG] Problem with Sun Enterprise 450 and kernel 2.6.X
Message-Id: <Pine.LNX.4.58L.0405151812370.18060@alpha.zarz.agh.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, 
I try to build and run kernel 2.6.6 on my machine:
[/proc/cpuinfo]
cpu		: TI UltraSparc II  (BlackBird)
fpu		: UltraSparc II integrated FPU
promlib		: Version 3 Revision 12
prom		: 3.12.3
type		: sun4u
ncpus probed	: 4
ncpus active	: 4
Cpu0Bogo	: 591.46
Cpu0ClkTck	: 0000000011a49a00
Cpu1Bogo	: 591.46
Cpu1ClkTck	: 0000000011a49a00
Cpu2Bogo	: 591.46
Cpu2ClkTck	: 0000000011a49a00
Cpu3Bogo	: 591.46
Cpu3ClkTck	: 0000000011a49a00
MMU Type	: Spitfire
State:
CPU0:		online
CPU1:		online
CPU2:		online
CPU3:		online

On 2.4.20 all works OK. but when I try to switch to 2.6.6
I got total freez,
From SILO I got answer:
Remapping kernel ...
Booting Linux ....

and ... nothing more.
I try to wait 20 min for start, but nothing.

Can any one help me with this problem?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
