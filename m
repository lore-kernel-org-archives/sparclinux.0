From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Mon, 16 Sep 2019 12:55:01 +0000
Subject: Re: [PATCH v4] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-Id: <c3a90839-703e-718a-a489-9905e52bbc46@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1568535656-158979-1-git-send-email-linyunsheng@huawei.com>
 <20190916084328.GC10231@dhcp22.suse.cz>
 <8df06e27-ad21-bf14-dbd6-cc8f5a274ec2@huawei.com>
 <20190916122359.GG10231@dhcp22.suse.cz>
In-Reply-To: <20190916122359.GG10231@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On 2019/9/16 20:23, Michal Hocko wrote:
> On Mon 16-09-19 20:07:22, Yunsheng Lin wrote:
> [...]
>>>> @@ -861,9 +861,12 @@ void numa_remove_cpu(int cpu)
>>>>   */
>>>>  const struct cpumask *cpumask_of_node(int node)
>>>>  {
>>>> -	if (node >= nr_node_ids) {
>>>> +	if (node = NUMA_NO_NODE)
>>>> +		return cpu_online_mask;
>>>> +
>>>> +	if ((unsigned int)node >= nr_node_ids) {
>>>>  		printk(KERN_WARNING
>>>> -			"cpumask_of_node(%d): node > nr_node_ids(%u)\n",
>>>> +			"cpumask_of_node(%d): node >= nr_node_ids(%u)\n",
>>>>  			node, nr_node_ids);
>>>>  		dump_stack();
>>>>  		return cpu_none_mask;
>>>
>>> Why do we need this?
>>
>> As the commit log says, the above cpumask_of_node() is for debugging,
>> it should catch other "node < 0" cases except NUMA_NO_NODE.
> 
> OK, I would just make it a separate patch.

Ok, thanks.

> 
