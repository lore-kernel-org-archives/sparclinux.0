From: Meelis Roos <mroos@linux.ee>
Date: Mon, 30 Jul 2007 11:42:21 +0000
Subject: Re: ioctl32 warning on framebuffer
Message-Id: <Pine.SOC.4.64.0707301439480.20918@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> There have been several patches posted recently which should
> cure X on sparc64, make sure you have them all applied.  It
> could cause exactly this error.
> 
> In particular, I think you're hitting the fs/proc/inode.c bug
> fix I made which got checked into Linus's tree yesterday.

Thanks for the explanation, I appled all the patches and Xorg seems to 
run fine (it's now tempting to get it from the rack and try if it can 
actually produce a image).

-- 
Meelis Roos (mroos@linux.ee)
