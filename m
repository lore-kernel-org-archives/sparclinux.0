From: David Miller <davem@davemloft.net>
Date: Tue, 24 Mar 2015 16:05:22 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150324.120522.577453784216935829.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>
	<20150323.122530.812870422534676208.davem@davemloft.net>
	<20150324145753.GC10685@zareason>
In-Reply-To: <20150324145753.GC10685@zareason>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bpicco@meloft.net
Cc: david.ahern@oracle.com, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 24 Mar 2015 10:57:53 -0400

> Seems solid with 2.6.39 on M7-4. Jalap?no is happy with current sparc.git.

Thanks for all the testing, it's been integrated into the -stable
queues as well.
