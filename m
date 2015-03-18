From: David Ahern <david.ahern@oracle.com>
Date: Wed, 18 Mar 2015 19:57:59 +0000
Subject: Re: maps mismatch in /proc/kcore for sparc
Message-Id: <5509D8C7.5080504@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5509AE36.8040902@oracle.com> <20150318.154359.1325469409095627387.davem@davemloft.net>
In-Reply-To: <20150318.154359.1325469409095627387.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 3/18/15 1:43 PM, David Miller wrote:
> From: David Ahern <david.ahern@oracle.com>
> Date: Wed, 18 Mar 2015 10:56:22 -0600
>
>> I am trying to understand why the perf tool on sparc fails to convert
>> kernel symbols when /proc/kcore is used. I have instrumented perf to
>> the point I can see that it drops symbols from kallsyms because it
>> cannot find a corresponding map when the kernel maps are created based
>> on parsing /proc/kcore.
>
> I'm looking into this, I think we need to set ARCH_PROC_KCORE_TEXT in
> arch/sparc/Kconfig

Missed that config in my fumbling through the kcore code. Adding it to 
sparc/Kconfig and it works. map is added:

kcore_mapfn: dso [kernel.kallsyms]: new map from 404000 to e33d79

and kernel symbols are not dropped. One mystery solved.

Thanks,
David
