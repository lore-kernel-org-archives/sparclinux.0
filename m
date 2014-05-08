From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2014 20:39:35 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140508.163935.911472810316070178.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 8 May 2014 23:32:51 +0300 (EEST)

> Each machine compiles and boots its own kernel (self-hosting for test 
> coverage purposes), patch is still applied on all of them, vmlinuz is 
> later than the patch, the latest kernel was booted up as vwrified with 
> last -10.
> 
> Verified it on V100 - checked patch is still applied, reran make (it did 
> not touch vmlinux because it as up to date), reinstalled kernel and 
> modules, booted it up and tested with git.
> 
> Unfortunately it still hangs :(
> 
> In addition to these four computers, I also tested E220R in the morning 
> with fresh git + the patch and it also failed git clone test.

Thanks a lot for double checking.
