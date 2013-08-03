From: David Miller <davem@davemloft.net>
Date: Sat, 03 Aug 2013 00:28:38 +0000
Subject: Re: [PATCH 2/2]sparc64: Unify kvmap_itlb for generic v9 and sun_4v
Message-Id: <20130802.172838.865856003342442992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1446411375457080@web28g.yandex.ru>
In-Reply-To: <1446411375457080@web28g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 02 Aug 2013 19:24:40 +0400

> Compute virtual address before kvmap_itlb call and unify
> kvmap_itlb and kvmap_itlb_4v.
> 
> In itlb_miss.S we use the fact that context is 0. So %g6
> is already equal to TAG and we are ready for the call.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

This transformation is not correct.

The TAG TARGET register only gives you bits 63 to 22 of the virtual
address.  The TAG ACCESS gives the full range of bits 63 to 13.
