From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 14 Jun 2017 23:24:10 +0000
Subject: Re: Spontaneous reboots seem to have been fixed
Message-Id: <73646c6e-7b0e-61dd-4847-62ab30f55d31@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 06/08/2017 07:05 AM, Meelis Roos wrote:
>> For a long time I have had a problem on some of my sparc64 kernel 
>> machines during kernel module linking (creating .mod.o and/or .ko) with 
>> make -j4 but usually not with plain make.
>>  

I would try running similar workload on test machines I have with
mainline and see if I hit something similar. Otherwise it could be a
h/w issue which manifests under some load.

>> Usually this resulted in spontaneous reboot (on V210 and V240 and 
>> E420R), sometimes causing hang on E420R. I was trying to bisect kernel 
>> configurations to find it but that was hard. THP was always on.
>>
>> However, as of commit 544f8f935863c5a9ca3e34306ea3316095e7b7bf (sparc64: 
>> Fix hugepage page table free) this seems to have been fixed - all three 
>> machines behave well for days of compilation.
>>

This commit is unlikely to have fixed anything for you unless you were
using 64K pages.

>> Is it probable that this was the culprit, or did I just stumble on 
>> something else that prevents the bug from happening?
> 

I'm not sure how that change would affect the issue you are hitting.

> Unfortunately that was false positive report - the probem is still 
> present and just showed up in 4.11-rc8 and 4.11.0 on V210 and V240.
> 

Maybe try h/w memory check before anything else.

Nitin
