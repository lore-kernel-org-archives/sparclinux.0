From: Meelis Roos <mroos@linux.ee>
Date: Wed, 15 Aug 2018 18:39:49 +0000
Subject: apparmor unaligned accesses on sparc64 in 4.18+git
Message-Id: <alpine.LRH.2.21.1808152136370.4724@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-security-module@vger.kernel.org

Just tried 4.18.0-02978-g1eb46908b35d on a sparc64 box with Debian Ports 
sparc64 unstable (apparmor packages recommended by linux-image package) 
and got the following on bootup:

[   46.315721] Kernel unaligned access at TPC[6b8b98] aa_dfa_unpack+0x38/0x620
[   46.412375] Kernel unaligned access at TPC[6b8ba8] aa_dfa_unpack+0x48/0x620
[   46.412392] Kernel unaligned access at TPC[6b8c28] aa_dfa_unpack+0xc8/0x620
[   46.698283] Kernel unaligned access at TPC[6b8ce8] aa_dfa_unpack+0x188/0x620
[   46.789536] Kernel unaligned access at TPC[6b8cfc] aa_dfa_unpack+0x19c/0x620

-- 
Meelis Roos (mroos@linux.ee)
