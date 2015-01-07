From: Meelis Roos <mroos@linux.ee>
Date: Wed, 07 Jan 2015 22:55:08 +0000
Subject: Adding support for Fujitsu SPARC64 machines?
Message-Id: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am playing with the idea of adding support for SPARC64 V and VI CPUs 
for sparclinux (actually maybe supervising a master student doing it).

Before we take it on, I would like to understand what needs to be done, 
what are the hard points and what are the risks. Below is my current 
understanding - please correct me where I am wrong. Also, if someone 
else might have some knowledge or docs that could help, please do tell.

* CPU support - 
http://www.fujitsu.com/global/products/computing/servers/unix/sparc-enterprise/downloads/documents/ 
has a bunch of developer docs for newer SPARC64 CPUs. Seems to be 
detailed enough for just the CPU.

* Machine support - I have PrimePower 250, 450, 650 and Sparc Enterprise 
M4000 available. Of them, 450 and M4000 have XSCF with full remote 
management with power and reset control, PP650 does not have it, and I 
do not know about PP250. M4000 is more complex so maybe PPP450 would 
be the best for start?

* PCI I/O - Solaris tells there is pcicmu0 at root: SAFARI 0x8 0x4000 
and px1 at root: SAFARI 0x1 0x700000 in the M4000. Am I correct if I
think support for this bridge needs to be implemented? There are some 
references to Safari in linux/arch/sparc/kernel code but Illumos seems 
to have more complex code.

(prtconf -pv sent to DaveM for prtconfs repo)

* Are there any other devices that need support? Console device at the 
least, maybe something else? Storage and network seem to be normal 
PCI.

* Is there any hypervisor protocol for talking to scf firmware from 
domains? scf management protocol is probably not too important for start 
since it should not be needed for boot/runtime support.

* Are there any devices know to have no documentation that would keep us 
from doing it?

* OpenBSD guys had a problem with some specific invalid hardware access 
causing fault in xscf firmware that needed to be cleared by service 
engineer, assuming there is a service contract. My Fujitsus are in my 
museum so there is no service contract. Has anyone heard if the current 
firmwares are more reliable? I'm running the latest on M4000 and 
whatever came with the PrimePowers.

*

-- 
Meelis Roos (mroos@linux.ee)
