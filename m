From: David Miller <davem@davemloft.net>
Date: Thu, 18 Sep 2014 17:06:46 +0000
Subject: Re: [PATCH] sparc64: vmemmap boot sizing
Message-Id: <20140918.130646.2081896665700840617.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 08:52:06 -0400

> Oh please remind me to mention percpu chunk allocator. Quickly we need
> need to enlarge VMALLOC space significantly but this is old data.

That's easy, we can enlarge it as much as we want.

You just have to move the VMEMMAP base forward, but that's trivial
too.

Do some calculations and let me know the order of how much more
space we need.
