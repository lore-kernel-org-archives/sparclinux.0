From: David Miller <davem@davemloft.net>
Date: Fri, 18 Nov 2011 02:29:36 +0000
Subject: Re: [BUG] Bad page map in process ibv_devinfo
Message-Id: <20111117.212936.140468226440693253.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAL1RGDV_AwOOnLvWJKGqBTaptetfVN_gXNG=PcaFUXYSXrQ5AA@mail.gmail.com>
	<20111117.210316.83327515715765011.davem@davemloft.net>
	<CAL1RGDVRnBQ1aaJn-RhiWpcdW89VBa+QgH8Z8YPJOt-7Wfmbmg@mail.gmail.com>
In-Reply-To: <CAL1RGDVRnBQ1aaJn-RhiWpcdW89VBa+QgH8Z8YPJOt-7Wfmbmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roland@purestorage.com
Cc: linux@razik.name, sparclinux@vger.kernel.org, linux-rdma@vger.kernel.org

From: Roland Dreier <roland@purestorage.com>
Date: Thu, 17 Nov 2011 18:17:08 -0800

> Anyway definitely makes sense as something to check.

Another difference is remap_pfn_range() uses pte_mkspecial().
