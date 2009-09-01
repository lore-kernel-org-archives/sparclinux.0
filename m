From: Meelis Roos <mroos@linux.ee>
Date: Tue, 01 Sep 2009 11:48:18 +0000
Subject: Re: boot panic after oops from sysfs_new_dirent
Message-Id: <Pine.SOC.4.64.0909011437270.20321@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0908311646150.20934@math.ut.ee>
 <20090831.142215.111904849.davem@davemloft.net> <Pine.SOC.4.64.0909011003460.10184@math.ut.ee>
 <4A9CC9E9.2070609@kernel.org> <4A9CCD92.4090909@kernel.org>
 <Pine.SOC.4.64.0909011032350.10835@math.ut.ee> <4A9CD41C.8060604@kernel.org>
In-Reply-To: <4A9CD41C.8060604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> Aha...  Does the following patch fix the problem?

Yes, yesterdays 2.6.31-rc8-git plus this patch seems to work fine, no 
warnings/oopses/panics. It is happily churning on debian unstable 
upgrade now.

-- 
Meelis Roos (mroos@linux.ee)
