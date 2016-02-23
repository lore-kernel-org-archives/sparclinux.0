From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 23 Feb 2016 20:29:01 +0000
Subject: Re: Invalid sk_policy[] access
Message-Id: <20160223202901.GC4941@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160222010201.GB23053@oracle.com>
 <20160223121244.GI28756@oracle.com>
 <alpine.LRH.2.20.1602232132190.30129@math.ut.ee>
 <20160223.152045.440181358695767083.davem@davemloft.net>
In-Reply-To: <20160223.152045.440181358695767083.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org

On (02/23/16 15:20), David Miller wrote:
> Indeed, the kernel is 64-bit in both cases.
> And the userland bit-arity has no relevance whatsoever for this bug.

hang on; The sizeof (and offsetof) values I listed were obtained either
from /usr/bin/crash (on the T5) or from simple printk's of the structures
in the case of the v440. And they *are* different, and the numbers
match the values dumped on the console on pnaic. So isnt there actually
a problem here?

--Sowmini

