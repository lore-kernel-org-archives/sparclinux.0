From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 22 Mar 2016 17:49:15 +0000
Subject: Re: [PATCH 1/1] [RFC]sparc64: enable cpu hotplug feature
Message-Id: <56F182CB.5010403@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>>   	return ret;
>>   }
>>
>
> You've made this significantly harder to review and audit by moving the code
> around so much.
>
> Just add the new calls:
>
> 	smp_fill_in_sib_core_maps();
> 	cpu_map_rebuild();
>
> in the existing basic block containing the smp_synchronize_one_tick() call.
>
> Then it's obvious to reviewers what your change is actually doing.

  Sure, I'll fix this and resend.

>>
>> +	set_cpu_online(cpu, false);
>> +
>>   	/* Make sure no interrupts point to this cpu.  */
>>   	fixup_irqs();
>
> This looks like a bug fix, to make sure fixup_irqs() does the right
> thing, right?
>
> All the little bug fixes like this should be split out into separate
> patches.

  I really did not think it was necessary, but I'll split it up as you
said.

Thanks.
