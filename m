From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:28:25 +0000
Subject: RFC: remove CONFIG_SUN4 support?
Message-Id: <20080605182755.GM1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While doing some easy cleanups on the sparc code I noticed that the 
CONFIG_SUN4 code seems to be worse than the rest - there were some
"I don't know how it should work, but the current code definitely cannot
work." places.

And while I have seen people running Linux on machines like a
SPARCstation 5 a few years ago I don't recall having seen sun4
machines, even less ones running Linux.

Are there reports of the code code being anywhere near at being working 
or could I remove it?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

