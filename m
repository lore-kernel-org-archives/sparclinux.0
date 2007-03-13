From: Meelis Roos <mroos@linux.ee>
Date: Tue, 13 Mar 2007 08:48:22 +0000
Subject: sunrpc unaligned access
Message-Id: <Pine.SOC.4.64.0703131044400.29530@math>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tried todays git (2.6.21-rc3-g8b9909de) on Ultra 5 and got this during 
NFS server startup:

Kernel unaligned access at TPC[100b8b98] svc_udp_recvfrom+0x180/0x420 [sunrpc]

Other than that it seems to work fine.

-- 
Meelis Roos (mroos@linux.ee)
