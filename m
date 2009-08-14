From: Tejun Heo <tj@kernel.org>
Date: Fri, 14 Aug 2009 04:26:14 +0000
Subject: Re: [PATCH 2/2 2.6.31-rc5 REPOST] percpu, sparc64: fix sparse possible
Message-Id: <4A84E766.3070904@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090806115705.GB10734@elte.hu>	<4A7B01B8.8000902@kernel.org>	<4A825CD5.3060209@kernel.org> <20090812.162517.13032565.davem@davemloft.net>
In-Reply-To: <20090812.162517.13032565.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

David Miller wrote:
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 12 Aug 2009 15:10:29 +0900
> 
>> Tejun Heo wrote:
>>> Ingo Molnar wrote:
>>>> for the x86 bits:
>>>>
>>>>  Acked-by: Ingo Molnar <mingo@elte.hu>
>>>>
>>>> Once Dave acks it i suspect you can send it to Linus directly?
>> Aieeeee, no response.
> 
> These patches look fine, and I've tested them also on my
> Niagara-2 box.
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Sorry for the delay :)

Great.  Oops, last review pass revealed a bug in the following chunk.

@@ -1259,9 +1259,16 @@ ssize_t __init pcpu_embed_first_chunk(size_t static_size, size_t reserved_size,
 	}

 	/* return the leftover and copy */
-	for_each_possible_cpu(cpu) {
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *ptr = pcpue_ptr + cpu * pcpue_unit_size;

+		if (cpu_possible(cpu)) {
+			free_bootmem(__pa(ptr + pcpue_size),
+				     pcpue_unit_size - pcpue_size);
+			memcpy(ptr, __per_cpu_load, static_size);
+		} else
+			free_bootmem(__pa(ptr), pcpue_unit_size);
+
 		free_bootmem(__pa(ptr + pcpue_size),
 			     pcpue_unit_size - pcpue_size);
 		memcpy(ptr, __per_cpu_load, static_size);

The if-else block should replace the original free_bootmem()/memcpy()
not added in front of it.  Fixed.  Will reply with updated patch.

Thanks.

-- 
tejun
