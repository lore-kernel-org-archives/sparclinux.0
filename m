From: Bill Irwin <bill.irwin@oracle.com>
Date: Tue, 13 Mar 2007 18:18:12 +0000
Subject: Re: libhugetlbfs and sparc64 support
Message-Id: <20070313181812.GU18774@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070312183920.GD29949@us.ibm.com>
In-Reply-To: <20070312183920.GD29949@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 12, 2007 at 10:58:04PM -0700, David Miller wrote:
> This patch below seems to improve the situation for me
> on my SunBlade1500, let me know if you can get farther
> on your Ultra60.
> This points out a big pet-peeve I have with all of
> these hugetlb page table interfaces, every single
> platform has the HPAGE_MASK the address parameter,
> and missing that is how I keep getting burnt with
> hugetlb bugs on sparc64.
> I really think the callers should be doing this.

Now you're fixing my hugetlb bugs, too. Thank you so much.

I'll get my sparc64 hardware situation fixed up in a bit.


-- wli
