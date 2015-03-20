From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 20:19:41 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150320.161941.18622997855089870.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <550C6151.8070803@oracle.com>
	<20150320.154700.1250039074828760104.davem@davemloft.net>
	<550C7AE1.1000808@oracle.com>
In-Reply-To: <550C7AE1.1000808@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 13:54:09 -0600

> Interesting. With -j <64 and talking softly it completes. But -j 128
> and higher always ends in a panic.

Please share more details of your configuration.
