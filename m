From: Meelis Roos <mroos@linux.ee>
Date: Mon, 26 Nov 2007 12:36:35 +0000
Subject: 2.6.24-rc3-g2ffbb837 fine on U5
Message-Id: <Pine.SOC.4.64.0711261432300.18000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tested a new git snapshot on my trusty U5 over a long time and it just 
works fine. There's the "sysctl table check failed: 
/kernel/scons-poweroff ..." call trace that has its fix already posted 
and other than that it's fine.

There are some new lines pronted early during bootup, what are these? 
Memory map for debugging?
[0000000200000000-fffff80000800000] page_structs&2144 node=0 entry=0/0
[0000000200000000-fffff80000c00000] page_structs&2144 node=0 entry=1/0
[0000000200000000-fffff80001000000] page_structs&2144 node=0 entry=2/0
[0000000200000000-fffff80001400000] page_structs&2144 node=0 entry=3/0

Compiler used was Debian unstable's 4.2.2-4. DaveM, does it contain your 
compiler bugfix, or what name/PR# does it have (I can grep the 
changelogs myself)?

-- 
Meelis Roos (mroos@linux.ee)
