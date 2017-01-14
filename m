From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 14 Jan 2017 19:52:22 +0000
Subject: Re: [PATCH] sparc: Don't leak context bits into thread->fault_address
Message-Id: <alpine.LRH.2.02.1701141451300.3387@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160727.175351.219584019615190125.davem@davemloft.net>
In-Reply-To: <20160727.175351.219584019615190125.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 31 Jul 2016, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
>
> > I've seen a message "BUG: non-zero nr_ptes on freeing mm: 1" twice on 
> > sparc64, once on 4.4.13 and once on 4.4.16. I don't know how to reproduce 
> > it. Do you have an idea what could be causing this bug?
> 
> People have been reporting this off and on for years, and sorry we don't
> know what's causing it yet.

I think it's caused by transparent hugepages. These errors (as well as 
other memory management related crashes) went away when I disabled thp.

Mikulas
