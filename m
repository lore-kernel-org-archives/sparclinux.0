From: Meelis Roos <mroos@linux.ee>
Date: Tue, 15 Feb 2005 10:33:15 +0000
Subject: framebuffer blanking
Message-Id: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have cg3 and cg6 framebuffers in my SS5. Current snapshot kernel makes 
both work well for fb console (haven't tried X). There is only one 
strange thing left - console blanking.

Both cg3 and cg6 behave the same: when it's blanking time, cursor is 
turned off but all the text stays. When I press a key to unblank, the 
cursor appears again and start flashing like usual.

-- 
Meelis Roos (mroos@linux.ee)
