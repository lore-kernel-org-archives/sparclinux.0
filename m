From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 08 Jan 2016 01:24:35 +0000
Subject: Re: [PATCH v2] sparc64: Fix numa node distance initialization
Message-Id: <568F0FD3.6050902@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1452062135-58381-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1452062135-58381-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/05/2016 11:35 PM, Nitin Gupta wrote:
> Orabug: 22495713
>
> Currently, NUMA node distance matrix is initialized only
> when a machine descriptor (MD) exists. However, sun4u
> machines (e.g. Sun Blade 2500) do not have an MD and thus
> distance values were left uninitialized. The initialization
> is now moved such that it happens on both sun4u and sun4v.
>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> Tested-by: Mikael Pettersson <mikpelinux@gmail.com>
> ---
>   arch/sparc/mm/init_64.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> Changelog v1 vs v2:
>   - Move numa distance values initialization outside
>     of numa_enabled conditional (Khalid)
>   - Add an empty line between variable declaration
>     and other code (David)
>
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3025bd5..6f21685 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1267,13 +1267,6 @@ static int __init numa_parse_mdesc(void)
>   	int i, j, err, count;
>   	u64 node;
>
> -	/* Some sane defaults for numa latency values */
> -	for (i = 0; i < MAX_NUMNODES; i++) {
> -		for (j = 0; j < MAX_NUMNODES; j++)
> -			numa_latency[i][j] = (i = j) ?
> -				LOCAL_DISTANCE : REMOTE_DISTANCE;
> -	}
> -
>   	node = mdesc_node_by_name(md, MDESC_NODE_NULL, "latency-groups");
>   	if (node = MDESC_NODE_NULL) {
>   		mdesc_release(md);
> @@ -1369,10 +1362,18 @@ static int __init numa_parse_sun4u(void)
>
>   static int __init bootmem_init_numa(void)
>   {
> +	int i, j;
>   	int err = -1;
>
>   	numadbg("bootmem_init_numa()\n");
>
> +	/* Some sane defaults for numa latency values */
> +	for (i = 0; i < MAX_NUMNODES; i++) {
> +		for (j = 0; j < MAX_NUMNODES; j++)
> +			numa_latency[i][j] = (i = j) ?
> +				LOCAL_DISTANCE : REMOTE_DISTANCE;
> +	}
> +
>   	if (numa_enabled) {
>   		if (tlb_type = hypervisor)
>   			err = numa_parse_mdesc();
>

Hi Nitin,

I don't mean to be nitpicking, just want to make sure "numa=off" 
behavior gets handled correctly. With this code change, node_distance() 
will return either LOCAL_DISTANCE or REMOTE_DISTANCE even when kernel is 
booted up with "numa=off". Would that end up not honoring "numa=off"? 
Should this loop initialize all numa_latency elements to LOCAL_DISTANCE 
if numa_enabled is not true, otherwise to LOCAL_DISTANCE and 
REMOTE_DISTANCE as appropriate? Please do let me know if it really is 
not a concern here.

Thanks,
Khalid
