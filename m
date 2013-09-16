From: David Miller <davem@davemloft.net>
Date: Mon, 16 Sep 2013 15:36:24 +0000
Subject: Re: [PATCH 0/4] sparc64 page table
Message-Id: <20130916.113624.1681343033992975403.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Every distribution is going to turn on the most capable configuration.

So having a choice between 3-level and 4-level page tables isn't going
to buy anything.

I'd rather find a solution that allows us to stay at 3-level page
tables and avoid all of the extra cost, as any change here is going to
make every single TLB miss more expensive.
