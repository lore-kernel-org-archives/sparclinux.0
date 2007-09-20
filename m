From: David Miller <davem@davemloft.net>
Date: Thu, 20 Sep 2007 17:40:31 +0000
Subject: Re: [PATCH]: Fix for several sunsab problems.
Message-Id: <20070920.104031.19785231.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070917.185701.13769540.davem@davemloft.net>
In-Reply-To: <20070917.185701.13769540.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 20 Sep 2007 12:16:22 +0300 (EEST)

> Boot hang when I just change page size from 8k to 64k remains, will try 
> to find a less intrusive change that triggers is (I seem to remember 
> seeing 64k pages working too in some conf).

I haven't tested non-8K page size support it ages, I would be
more surprised if it actually worked :-)
