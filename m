From: John David Anglin <dave.anglin@bell.net>
Date: Fri, 27 Dec 2013 20:14:39 +0000
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <BLU0-SMTP67B57AF06A5AC44236538A97CD0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <20131227180018.GC4945@linux.intel.com> <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl> <20131227193330.GE4945@linux.intel.com> <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
In-Reply-To: <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John David Anglin <dave.anglin@bell.net>
Cc: Matthew Wilcox <willy@linux.intel.com>, linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org

On 27-Dec-13, at 2:47 PM, John David Anglin wrote:

> It's worth looking at.  The value is supposed to be returned by the  
> PDC_CACHE PDC
> call but I know my rp3440 returns a value of 0 indicating that the  
> aliasing boundary
> is unknown and may be greater than 16MB.

c3750 data cache has an aliasing boundary of 4 MB, so I think we are  
stuck with large
SHMLBA.

Dave
--
John David Anglin	dave.anglin@bell.net



