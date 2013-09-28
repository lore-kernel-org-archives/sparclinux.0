From: David Miller <davem@davemloft.net>
Date: Sat, 28 Sep 2013 19:34:12 +0000
Subject: Re: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <20130928.153412.831036331909848217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.165242.1048533011152185981.davem@redhat.com>
In-Reply-To: <20130926.165242.1048533011152185981.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Fri, 27 Sep 2013 21:07:11 -0700

> This is on a t4-1, machine becomes unusable with hundreds of
> "WARNING: CPU: 0 PID: 441 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()"

Strange, it boots perfectly fine on my T4-2.  Can you reply to
this email with the ".config" you used?

Also, did you make sure to have the PAGE_OFFSET patches applied
first?  They are a prerequisite for this series.

Thanks.
