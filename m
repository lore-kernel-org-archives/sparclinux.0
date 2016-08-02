From: David Miller <davem@davemloft.net>
Date: Tue, 02 Aug 2016 17:47:52 +0000
Subject: Re: [PATCH 1/2] sparc: fix incorrect value returned by copy_from_user_fixup
Message-Id: <20160802.104752.527337990768683986.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1607311949210.7784@file01.intranet.prod.int.rdu2.redhat.com>
	<20160801.213312.1130341044241125265.davem@davemloft.net>
	<alpine.LRH.2.02.1608020806450.8555@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1608020806450.8555@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 2 Aug 2016 08:20:15 -0400 (EDT)

> On Mon, 1 Aug 2016, David Miller wrote:
> 
>> From: Mikulas Patocka <mpatocka@redhat.com>
>> Date: Sun, 31 Jul 2016 19:50:57 -0400 (EDT)
>> 
>> > @@ -18,9 +25,9 @@
>> >   * of the cases, just fix things up simply here.
>> >   */
>> >  
>> > -static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset)
>> > +static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset, unsigned long prefetch)
>> >  {
>> > -	unsigned long fault_addr = current_thread_info()->fault_address;
>> > +	unsigned long fault_addr = current_thread_info()->fault_address - prefetch;
>> >  	unsigned long end = start + size;
>> >  
>> >  	if (fault_addr < start || fault_addr >= end) {
>> > @@ -36,7 +43,7 @@ unsigned long copy_from_user_fixup(void
>> >  {
>> >  	unsigned long offset;
>> >  
>> > -	size = compute_size((unsigned long) from, size, &offset);
>> > +	size = compute_size((unsigned long) from, size, &offset, COPY_FROM_USER_PREFETCH);
>> >  	if (likely(size))
>> >  		memset(to + offset, 0, size);
>> >  
>> 
>> I think this might cause a problem.  Assume we are not in one of those
>> prefetching loops and are just doing a byte at a time, and therefore
>> hit the fault exactly at the beginning of the missing page.
>> 
>> You will rewind 0x100 bytes and the caller will restart the copy at
>> "faulting address  - 0x100".
>> 
>> If someone is using atomic user copies, and using the returned length
>> to determine which page in userspace needs to be faulted in, and
>> then restart the copy, then we will loop forever.
> 
> This isn't guaranteed on x86 neither.
> 
> __copy_user_intel reads and writes 64 bytes in one loop iteration (and it 
> prefetches the data for the next iteration with "movl 64(%4), %%eax". If 
> it fails, it reports the amount of remaining data at the start of the loop 
> iteration. The reported value may be 67 bytes lower than the fault 
> location.

That's very interesting, let me do some research into this, as I was
pretty sure something like futexes or similar had some requirement in
this area.

Thanks.
