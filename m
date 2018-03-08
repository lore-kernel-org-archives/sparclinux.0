From: Meelis Roos <mroos@linux.ee>
Date: Thu, 08 Mar 2018 08:31:10 +0000
Subject: qla2xxx fails firmware init on sparc64
Message-Id: <alpine.LRH.2.21.1803081021400.23373@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried a newer kernel (vmlinuz-4.16.0-rc3-00203-g8da5db7) on my Sun 
E280R with onboard QLA2200 and it did not work. I fixed some lower 
hanging fruits (error handler assuming qla2400 and up, double dma free 
in error path, and a copypaste typo in freeing some data that I did not 
hit - will submit them separately). After that I can observe firmware 
being loaded and verified but qla2x00_init_firmware fails.

detailed debug trace with qla2xxx.ql2xextended_error_logging=0x7fffffff 
is available at http://kodu.ut.ee/~mroos/qla2200-sparc64-trace.txt

How can I debug it further?

-- 
Meelis Roos (mroos@linux.ee)
