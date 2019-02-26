From: David Miller <davem@davemloft.net>
Date: Tue, 26 Feb 2019 00:37:42 +0000
Subject: Re: [PATCH] sparc: use struct_size() in kzalloc()
Message-Id: <20190225.163742.2147508883498135591.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190108161356.GA23617@embeddedor>
In-Reply-To: <20190108161356.GA23617@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gustavo@embeddedor.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 8 Jan 2019 10:13:56 -0600

> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
