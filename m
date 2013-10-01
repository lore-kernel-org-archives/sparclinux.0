From: David Miller <davem@davemloft.net>
Date: Tue, 01 Oct 2013 20:11:42 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131001.161142.2299039781779642504.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Mon, 30 Sep 2013 17:42:02 -0700

> On 09/30/2013 04:51 PM, David Miller wrote:
>> From: Gurudas Pai <gurudas.pai@oracle.com>
>> Date: Mon, 30 Sep 2013 16:47:48 -0700
>>
>>> Allocate 10 hugepages, and run a test using tool 'fio' with following
>>> jobfile.
>>> Fio just hangs. Basically issue is with O_DIRECT and hugepages. If you
>>> comment
>>> out "direct=1" from jobfile test works fine.
>> This worked before my changes right?
> No, Just now tried with old kernel, it hangs as well.

I can reproduce this so I'll have a look, thanks.
