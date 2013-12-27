From: John David Anglin <dave.anglin@bell.net>
Date: Fri, 27 Dec 2013 19:47:32 +0000
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <20131227180018.GC4945@linux.intel.com> <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl> <20131227193330.GE4945@linux.intel.com>
In-Reply-To: <20131227193330.GE4945@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org

On 27-Dec-13, at 2:33 PM, Matthew Wilcox wrote:

> Have you considered measuring SHMLBA on different CPU models and
> reducing it at boot time?  I know that 4MB is the architectural  
> guarantee
> (actually, I seem to remember that 16MB was the architectural  
> guarantee,
> but jsm found some CPU architects who said it would enver exceed 4MB).
> I bet some CPUs have considerably lower cache coherency limits.


It's worth looking at.  The value is supposed to be returned by the  
PDC_CACHE PDC
call but I know my rp3440 returns a value of 0 indicating that the  
aliasing boundary
is unknown and may be greater than 16MB.

Dave
--
John David Anglin	dave.anglin@bell.net



