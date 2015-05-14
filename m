From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 14 May 2015 13:47:22 +0000
Subject: Re: [PATCH Resend] sparc64: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <5554A76A.6090408@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430173189-12135-1-git-send-email-khalid.aziz@oracle.com> <20150513.234517.834150584495147194.davem@davemloft.net>
In-Reply-To: <20150513.234517.834150584495147194.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: bob.picco@oracle.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, sam@ravnborg.org, rickard_strandqvist@spectrumdigital.se, allen.pais@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/13/2015 09:45 PM, David Miller wrote:
>
> Ok you've computed what cacheability bits to use in page_cache4v_flag.
>.......
> Although in another function, we seem to compute it here yet again.
>
> Perhaps early on put this into a "static unsigned long
> page_cache4v_flag" and just use that everywhere.
>
> If you do it early enough in paging_init() you should be fine.

Makes perfect sense. Thanks! I will send out a v2 patch.

--
Khalid

