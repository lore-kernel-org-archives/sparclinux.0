From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 01 Mar 2017 14:51:02 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
In-Reply-To: <87h93dhmir.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org

On 2017-02-28 19:24, Andi Kleen wrote:
> Pavel Tatashin <pasha.tatashin@oracle.com> writes:
>>
>> While investigating how to improve initialization time of dentry_hashtable
>> which is 8G long on M6 ldom with 7T of main memory, I noticed that memset()
>
> I don't think a 8G dentry (or other kernel) hash table makes much
> sense. I would rather fix the hash table sizing algorithm to have some
> reasonable upper limit than to optimize the zeroing.
>
> I believe there are already boot options for it, but it would be better
> if it worked out of the box.
>
> -Andi


Hi Andi,

I agree that there should be some smarter cap for maximum hash table 
sizes, and as you said it is already possible to set the limits via 
parameters. I still think, however, this HASH_ZERO patch makes sense for 
the following reasons:

- Even if the default maximum size is reduced the size of these tables 
should still be tunable, as it really depends on the way machine is 
used, and in it is possible that for some use patterns large hash tables 
are necessary.

- Most of them are initialized before smp_init() call. The time from 
bootloader to smp_init() should be minimized as parallelization is not 
available yet. For example, LDOM domain on which I tested this patch 
with few more optimization takes 8.5 seconds to get from grub to 
smp_init() (760CPUs and 7T of memory), out of these 8.5 seconds 3.1s 
(vs. 11.8s before this patch) are spent initializing these hash tables. 
So, even 3.1s is still significant, and should be improved further by 
changing the default maximums, but that should be a different patch.

Thank you,
Pasha


> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

