From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 04 Jan 2016 09:29:41 +0000
Subject: Re: [BISECTED] "sparc64: Fix numa distance values" breakage
Message-Id: <568A38B5.6040403@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <22148.1009.8278.45539@gargle.gargle.HOWL>
In-Reply-To: <22148.1009.8278.45539@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 1/4/16 1:13 PM, Alexandre Chartre wrote:
> 
> A Sun Blade 2500 is sun4u so there's no MD; the MD is only available on sun4v. 
> 
> alex.


I see. I'm currently initializing numa node distance matrix only in
case where MD exists which is wrong.

Mikael: Can you please try patch below which moves initialization
earlier so the initialization happens for both sun4u and sun4v?

Thanks,
Nitin



diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3025bd5..ff63db5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1267,13 +1267,6 @@ static int __init numa_parse_mdesc(void)
 	int i, j, err, count;
 	u64 node;
 
-	/* Some sane defaults for numa latency values */
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		for (j = 0; j < MAX_NUMNODES; j++)
-			numa_latency[i][j] = (i = j) ?
-				LOCAL_DISTANCE : REMOTE_DISTANCE;
-	}
-
 	node = mdesc_node_by_name(md, MDESC_NODE_NULL, "latency-groups");
 	if (node = MDESC_NODE_NULL) {
 		mdesc_release(md);
@@ -1374,6 +1367,14 @@ static int __init bootmem_init_numa(void)
 	numadbg("bootmem_init_numa()\n");
 
 	if (numa_enabled) {
+		int i, j;
+		/* Some sane defaults for numa latency values */
+		for (i = 0; i < MAX_NUMNODES; i++) {
+			for (j = 0; j < MAX_NUMNODES; j++)
+				numa_latency[i][j] = (i = j) ?
+					LOCAL_DISTANCE : REMOTE_DISTANCE;
+		}
+
 		if (tlb_type = hypervisor)
 			err = numa_parse_mdesc();
 		else


> 
>> On Jan 4, 2016, at 06:57, Nitin Gupta <nitin.m.gupta@oracle.com> wrote:
>>
>> Mike,
>>
>> I believe this is due to the firmware exporting wrong/incomplete
>> information about memory latency groups in the machine descriptor (MD).
>> Before this patch, this information was not used at all and kernel
>> always used default values for numa node distance values. With incorrect
>> values, scheduler can have a skewed view of the machine causing this
>> non optimal usage. My testing on T7, T5, T4 with recent firmwares never
>> showed such issues.
>>
>> Can you please provide output of 'numactl --hardware' on your machine?
>> Ideally, I would also require dump of the MD but I don't have a script
>> handy for this which I can share externally.
>>
>> Dave: would you have a script to dump MD which you can share?
>>
>> Thanks,
>> Nitin
>>
>>>>
>>>> From: Mikael Pettersson <mikpelinux@gmail.com>
>>>> Subject: [BISECTED] "sparc64: Fix numa distance values" breakage (was: 4.4-rc kernels only use one of two CPUs on Sun Blade 2500)
>>>> Date: December 30, 2015 at 9:18:57 AM MST
>>>> To: Mikael Pettersson <mikpelinux@gmail.com>
>>>> Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>
>>>>
>>>> Mikael Pettersson writes:
>>>>> Something is causing the 4.4-rc kernels to only use half the CPU
>>>>> capacity of my Sun Blade 2500 (dual USIIIi).  The kernel does detect
>>>>> both CPUs, but it doesn't seem to want to schedule processes on
>>>>> both of them.  During CPU-intensive jobs like GCC bootstraps, 'top'
>>>>> indicates the machine is 50% idle and aggregate CPU usage is 100%
>>>>> (should be 200%).  This is completely deterministic.
>>>>>
>>>>> Going back to 4.3.0 resolves the problems.
>>>>
>>>> A git bisect identified the commit below as the culprit.
>>>> I've confirmed that reverting it from 4.4-rc7 solves the problem.
>>>>
>>>> commit 52708d690b8be132ba9d294464625dbbdb9fa5df
>>>> Author: Nitin Gupta <nitin.m.gupta@oracle.com>
>>>> Date:   Mon Nov 2 16:30:24 2015 -0500
>>>>
>>>>    sparc64: Fix numa distance values
>>>>
>>>>    Orabug: 21896119
>>>>
>>>>    Use machine descriptor (MD) to get node latency
>>>>    values instead of just using default values.
>>>>
>>>>    Testing:
>>>>    On an T5-8 system with:
>>>>     - total nodes = 8
>>>>     - self latencies = 0x26d18
>>>>     - latency to other nodes = 0x3a598
>>>>       => latency ratio = ~1.5
>>>>
>>>>    output of numactl --hardware
>>>>
>>>>     - before fix:
>>>>
>>>>    node distances:
>>>>    node   0   1   2   3   4   5   6   7
>>>>      0:  10  20  20  20  20  20  20  20
>>>>      1:  20  10  20  20  20  20  20  20
>>>>      2:  20  20  10  20  20  20  20  20
>>>>      3:  20  20  20  10  20  20  20  20
>>>>      4:  20  20  20  20  10  20  20  20
>>>>      5:  20  20  20  20  20  10  20  20
>>>>      6:  20  20  20  20  20  20  10  20
>>>>      7:  20  20  20  20  20  20  20  10
>>>>
>>>>     - after fix:
>>>>
>>>>    node distances:
>>>>    node   0   1   2   3   4   5   6   7
>>>>      0:  10  15  15  15  15  15  15  15
>>>>      1:  15  10  15  15  15  15  15  15
>>>>      2:  15  15  10  15  15  15  15  15
>>>>      3:  15  15  15  10  15  15  15  15
>>>>      4:  15  15  15  15  10  15  15  15
>>>>      5:  15  15  15  15  15  10  15  15
>>>>      6:  15  15  15  15  15  15  10  15
>>>>      7:  15  15  15  15  15  15  15  10
>>>>
>>>>    Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
>>>>    Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>>>>    Reviewed-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
>>>>    Signed-off-by: David S. Miller <davem@davemloft.net>
>>>> --
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
