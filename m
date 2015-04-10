From: chris hyser <chris.hyser@oracle.com>
Date: Fri, 10 Apr 2015 19:58:22 +0000
Subject: Re: [PATCH v4] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <55282B5E.3050402@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55281166.vYe5n4+08wPx4lmA%chris.hyser@oracle.com>
In-Reply-To: <55281166.vYe5n4+08wPx4lmA%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/10/2015 3:27 PM, David Miller wrote:
>> +		if (printk_ratelimit())
>> +			pr_err(PFX "VIO I/O Error %d\n", desc->status);
>
> Please use pr_err_ratelimited().

No problem.

-chrish
