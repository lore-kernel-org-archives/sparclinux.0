From: Meelis Roos <mroos@linux.ee>
Date: Tue, 14 Sep 2004 09:50:28 +0000
Subject: Legacy PC IO reservations on sparc64?
Message-Id: <Pine.GSO.4.44.0409141248500.8479-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From /prco/iomem on a Sun Ultra 5, running 2.6.9-rc2:

  1ff000a0000-1ff000bffff : Video RAM area
  1ff000c0000-1ff000c7fff : Video ROM
  1ff000f0000-1ff000fffff : System ROM

Why are these here on sparc64?

-- 
Meelis Roos (mroos@linux.ee)

