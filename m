From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 05 Jan 2016 21:02:25 +0000
Subject: Re: [PATCH] sparc64: Fix numa node distance initialization
Message-Id: <568C2F61.3060107@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1451986811-197131-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1451986811-197131-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/05/2016 02:40 AM, Nitin Gupta wrote:
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
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3025bd5..ff63db5 100644
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
> @@ -1374,6 +1367,14 @@ static int __init bootmem_init_numa(void)
>   	numadbg("bootmem_init_numa()\n");
>
>   	if (numa_enabled) {
> +		int i, j;
> +		/* Some sane defaults for numa latency values */
> +		for (i = 0; i < MAX_NUMNODES; i++) {
> +			for (j = 0; j < MAX_NUMNODES; j++)
> +				numa_latency[i][j] = (i = j) ?
> +					LOCAL_DISTANCE : REMOTE_DISTANCE;
> +		}
> +
>   		if (tlb_type = hypervisor)
>   			err = numa_parse_mdesc();
>   		else
>

If one were to boot up with "numa=off" kernel option, numa_latency array 
wouldn't be initialized by this code which will cause node_distance() to 
return 0 for any two nodes. Would it make more sense to do this 
initialization outside of "if (numa_enabled)" or is a value of 0, 
instead of LOCAL_DISTANCE when numa is not enabled, for node_distance() 
not a problem?

--
Khalid
