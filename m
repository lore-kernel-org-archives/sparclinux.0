From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:27:57 +0000
Subject: Re: [PATCH v3 0/4] sparc64: Jump to boot prom from console on panic
Message-Id: <20170223.112757.212159908536361829.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
        <20170201.145031.295104986575080480.davem@davemloft.net>
        <271b7e7c-5e2f-eab6-d097-54145b777d73@oracle.com>
In-Reply-To: <271b7e7c-5e2f-eab6-d097-54145b777d73@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 1 Feb 2017 15:20:08 -0600

> 
> On 2/1/2017 1:50 PM, David Miller wrote:
>> From: Vijay Kumar <vijay.ac.kumar@oracle.com>
>> Date: Wed,  1 Feb 2017 11:34:36 -0800
>>
>>> Currently Stop-A (L1A) does not make the kernel switch to OBP on
>>> panic.
>> This is intentional, the kernel prints a message telling the user to
>> press break (L1-A) if they want to drop out of the kernel and we force
>> the break to be allowed by setting stop_a_enabled.
> The problem is that pressing BRK after panic does not drop to OK
> prompt (when
> stop_a_enabled is set).  So the kernel message to press Stop-A to
> return to boot
> prom is  misleading in this case.

Ok, I ended up applying this patch series, thanks.
