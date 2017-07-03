From: Steven Sistare <steven.sistare@oracle.com>
Date: Mon, 03 Jul 2017 13:34:48 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <72a30eef-7888-563c-bfab-5304d8a887b6@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 7/3/2017 5:50 AM, David Miller wrote:
> From: Jane Chu <jane.chu@oracle.com>
> Date: Wed, 28 Jun 2017 15:02:26 -0600
> 
>>   static void hypervisor_xcall_deliver(struct trap_per_cpu *tb, int cnt)
>>   {
>> -	int retries, this_cpu, prev_sent, i, saw_cpu_error;
>> +	int retries, this_cpu, prev_sent, i, rem;
>> +	uint16_t first_cpu = 0xffff;
>> +	unsigned long xc_rcvd = 0;
>> +	int usec_wait = cnt * 2;
>>   	unsigned long status;
>> +	int ecpuerror_id = 0;
>> +	int enocpu_id = 0;
>>   	u16 *cpu_list;
>> +	uint16_t cpu;
> 
> As you can see at the variable declarations around the ones you are
> adding, "u16" is the appropriate type to use.  "uint16_t" is not.
> 
> So my concern about this patch is that in my mind, getting into a
> state where a cpu is looping and doing nothing but handling mondos
> is a bug.
> 
> That cpu is making no progress in it's execution stream, and that's
> problematic.
> 
> I'd rather we attack the issue that gets into this situation in the
> first place.
> 
> It's because we don't optimize large amounts of page TLB flushes
> properly.
> 
> Firstly, we don't have a way to pass the array of pages to flush.
> That would cut down the mondos by orders of magnitude.
> 
> We also could have a cutoff where we do a full MM flush instead
> of flushing individual pages.
> 
> I bet if you implemented these two things, it would not only
> make the mondo timeouts go away, it with make cpus actually
> make forward progress in their instruction stream rather than
> looping like crazy processing mondos.
> 
> Thanks.

There is room for improvement in the TLB flush algorithms, and it is
on our longer term list of things to do, as it will generally improve
performance of demap operations.  However, on another operating
system for sparc, we have a large set of algorithms to use
large pages extensively, batch translation shootdowns, transition
to demap-context and demap-all, and use hardware MMU-group demap
features, and it is still not enough to prevent mondo timeout panic
under stressful conditions on large systems using the "sender counts"
method of judging forward progress.  The "receiver counts" method
has proven to be a robust way of riding out mondo storms into calmer
waters without panicking the system, and greatly reduced the number
of bug reports from users due to mondo timeouts.  This is a valuable
feature that users appreciate.

(I removed linux-kernel from the CC list to reduce their traffic,
since this is arch/sparc code).

- Steve
