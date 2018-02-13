From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 13 Feb 2018 10:09:05 +0000
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
Message-Id: <87fu652oce.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
	<87zi4ev1d2.fsf@concordia.ellerman.id.au>
	<f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
In-Reply-To: <f119a273-2e86-1b7f-346f-7627ad8b51ed-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-s390 <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Johansen <john.johansen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dmitry Kasatkin <dmitry.kasatkin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 02/12/2018 04:28 AM, Michael Ellerman wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>>> reason. It looks like it's only a convenience, so remove kmemleak.h
>>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>>> that don't already #include it.
>>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>>
>>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>>> would be good to run it through the 0day bot for other $ARCHes.
>>> I have neither the horsepower nor the storage space for the other
>>> $ARCHes.
>>>
>>> [slab.h is the second most used header file after module.h; kernel.h
>>> is right there with slab.h. There could be some minor error in the
>>> counting due to some #includes having comments after them and I
>>> didn't combine all of those.]
>>>
>>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>>> header files).
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> 
>> I threw it at a random selection of configs and so far the only failures
>> I'm seeing are:
>> 
>>   lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
>>   lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>   lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>
> Both of those source files need to #include <linux/vmalloc.h>.

Yep, I added those and rebuilt. I don't see any more failures that look
related to your patch.

  http://kisskb.ellerman.id.au/kisskb/head/13399/


I haven't gone through the defconfigs I have enabled for a while, so
it's possible I have some missing but it's still a reasonable cross
section.

cheers
