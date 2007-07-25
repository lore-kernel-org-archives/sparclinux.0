From: Andries Brouwer <Andries.Brouwer@cwi.nl>
Date: Wed, 25 Jul 2007 20:36:46 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725203646.GA13891@apps.cwi.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jul 25, 2007 at 05:47:29PM +0100, Mark Fortescue wrote:

> Add in fix to prevent the VTOC table being used if it is not present
> (it was not implemented until Solaris 2.x so SunOS 4.1.x will not have
> valid VTOC data) and correct the Solaris x86 number of partitions (slices).
> 
> Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> ---

>  	struct sun_disklabel {
>  		unsigned char info[128];   /* Informative text string */
> -		unsigned char spare0[14];
> -		struct sun_info {
> -			unsigned char spare1;
> -			unsigned char id;
> -			unsigned char spare2;
> -			unsigned char flags;
> -		} infos[8];
> -		unsigned char spare[246];  /* Boot information etc. */
> +		struct sun_vtoc {
> +		    __be32 version;     /* Layout version */
> +		    char   volume[8];   /* Volume name */
> +		    __be16 nparts;      /* Number of partitions */
> +		    struct sun_info {           /* Partition hdrs, sec 2 */
> +			__be16 id;
> +			__be16 flags;
> +		    } infos[8];
> +		    __be16 padding;      /* Alignment padding */
> +		    __be32 bootinfo[3];  /* Info needed by mboot */
> +		    __be32 sanity;       /* To verify vtoc sanity */

> @@ -81,10 +92,13 @@ int sun_partition(struct parsed_partitio
>  		if (num_sectors) {
>  			put_partition(state, slot, st_sector, num_sectors);
>  			state->parts[slot].flags = 0;
> -			if (label->infos[i].id = LINUX_RAID_PARTITION)
> -				state->parts[slot].flags |= 
> ADDPART_FLAG_RAID;
> -			if (label->infos[i].id = SUN_WHOLE_DISK)
> -				state->parts[slot].flags |= 
> ADDPART_FLAG_WHOLEDISK;
> +			/* Need to validate the VTOC before we use it */
> +			if (be32_to_cpu(label->vtoc.sanity) = 
> SUN_VTOC_SANITY) {
> +				if (be16_to_cpu(label->vtoc.infos[i].id) = 
> LINUX_RAID_PARTITION)
> +					state->parts[slot].flags |= 
> ADDPART_FLAG_RAID;
> +				else if 
> (be16_to_cpu(label->vtoc.infos[i].id) = SUN_WHOLE_DISK)
> +					state->parts[slot].flags |= 
> ADDPART_FLAG_WHOLEDISK;
> +			}
>  		}

It seems that you say that what was a single byte earlier is a __be16 now.
That is nice and well, but your code only works in the new case,
that is, may break all systems that work today.
What about testing vtoc.sanity, and if this has the right value do
the new things, and otherwise the old things?

Andries
