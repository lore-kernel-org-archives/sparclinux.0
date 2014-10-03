From: David Miller <davem@davemloft.net>
Date: Fri, 03 Oct 2014 22:53:39 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141003.155339.362104635985585317.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 2 Oct 2014 10:24:35 -0400

> This is where we seem to go bad on T4-2. We go equally bad very quickly on
> T5-8 with all patches applied and !THP.
> 
> T4-2 is configured for THP "madvise". At this commit:
> 59a35b1 sparc64: Use kernel page tables for vmemmap.
> we seem to fall apart on T4-2 with the program below.
> 
> ./thp4-loop -a 1024 8192
> 
> This all needs to be reverified.

Excellent report, I'll try to reproduce and look into that
vmemmap commit for problems.

Thanks!
