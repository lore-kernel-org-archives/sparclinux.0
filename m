From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 02 Dec 2009 18:41:34 +0000
Subject: No MC sched domains
Message-Id: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


the T1 is said to be multi-core, however, I am not seeing any MC sched 
levels in dmesg as I do on x86. Why is that?

CPU0 attaching sched-domain:
 domain 0: span 0-3 level SIBLING
  groups: 0 1 2 3
  domain 1: span 0-23 level CPU
   groups: 0-3 4-7 8-11 12-15 16-19 20-23
   domain 2: span 0-23 level NODE
    groups: 0-23 (__cpu_power = 6144)
[...]

Should domain 1 perhaps be MC, domain 2 be CPU, and a domain 3 be NODE 
instead?

x86_64 dump:
[    0.839305] CPU0 attaching sched-domain:
[    0.839307]  domain 0: span 0,4 level SIBLING
[    0.839309]   groups: 0 4
[    0.839311]   domain 1: span 0-7 level MC
[    0.839313]    groups: 0,4 1,5 2,6 ...
[no domain 2]


Jan
