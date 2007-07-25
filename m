From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 25 Jul 2007 21:46:07 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707252205350.21069@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Andries and David,

The VTOC sanity variable was introduced when the VTOC table was added to 
the disk label (sometime post Solaris 1, before Solaris 2.4) by Sun. My 
Sparc systems do not know about the VTOC in any form (too old) so this 
patch was an attempt to correct the Linux usage of the VTOC and prevent 
any random data in that part of the disk on my systems from being an 
issue (SunOS 4.1.x has a habit of not zeroing out padding data).

As pointed out by David, the Linux tools used to create Sun/Solaris like 
disk labels are mostly faulty in that they do not set the VTOC 
version/sanity variables. This results in a problem as it is not posible 
to identify the the difference between Linux+VTOC and SunOS 4.1.x+Ramdom D 
ata.

It looks like I will have to change the patch to use a kernal/module 
parameter to enable VTOC checking. David, would this be suficient in your 
view?

With regard to the id and flag values - the spare1 and spare2 values are 
currently meant to be zero so using the 16bit filing system endian 
conversion functions means that 8 partition disk label created on x86
systems should work correctly as well as those created on Sparc systems. 
It would be posible to change the code to use bytes but the coding begins 
to get very messy when we start accessing bytes swaped partition labels 
as these use spare1/2 for id/flags.

The final part of the patch - increasing the number of x86 slices 
(partitions) from 8 to 16 will correct the x86 Solaris disk label usually 
used in x86 solaris systems but again may break Linux systems that have 
been created using the incorrect value.

Again, fixing the code has the potential to break many implementations.
Looking at the header file, this may not be too painfull but a 
kernel/module parameter would ensure no issues. Maybe I could use the same 
one as the one to enable VTOC sanity checking?

Regards
 	Mark Fortescue.

On Wed, 25 Jul 2007, Andries Brouwer wrote:

> On Wed, Jul 25, 2007 at 05:47:29PM +0100, Mark Fortescue wrote:
>
>> Add in fix to prevent the VTOC table being used if it is not present
>> (it was not implemented until Solaris 2.x so SunOS 4.1.x will not have
>> valid VTOC data) and correct the Solaris x86 number of partitions (slices).
>>
>> Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>
>> ---
>
>>  	struct sun_disklabel {
>>  		unsigned char info[128];   /* Informative text string */
>> -		unsigned char spare0[14];
>> -		struct sun_info {
>> -			unsigned char spare1;
>> -			unsigned char id;
>> -			unsigned char spare2;
>> -			unsigned char flags;
>> -		} infos[8];
>> -		unsigned char spare[246];  /* Boot information etc. */
>> +		struct sun_vtoc {
>> +		    __be32 version;     /* Layout version */
>> +		    char   volume[8];   /* Volume name */
>> +		    __be16 nparts;      /* Number of partitions */
>> +		    struct sun_info {           /* Partition hdrs, sec 2 */
>> +			__be16 id;
>> +			__be16 flags;
>> +		    } infos[8];
>> +		    __be16 padding;      /* Alignment padding */
>> +		    __be32 bootinfo[3];  /* Info needed by mboot */
>> +		    __be32 sanity;       /* To verify vtoc sanity */
>
>> @@ -81,10 +92,13 @@ int sun_partition(struct parsed_partitio
>>  		if (num_sectors) {
>>  			put_partition(state, slot, st_sector, num_sectors);
>>  			state->parts[slot].flags = 0;
>> -			if (label->infos[i].id = LINUX_RAID_PARTITION)
>> -				state->parts[slot].flags |>> ADDPART_FLAG_RAID;
>> -			if (label->infos[i].id = SUN_WHOLE_DISK)
>> -				state->parts[slot].flags |>> ADDPART_FLAG_WHOLEDISK;
>> +			/* Need to validate the VTOC before we use it */
>> +			if (be32_to_cpu(label->vtoc.sanity) =
>> SUN_VTOC_SANITY) {
>> +				if (be16_to_cpu(label->vtoc.infos[i].id) =
>> LINUX_RAID_PARTITION)
>> +					state->parts[slot].flags |>> ADDPART_FLAG_RAID;
>> +				else if
>> (be16_to_cpu(label->vtoc.infos[i].id) = SUN_WHOLE_DISK)
>> +					state->parts[slot].flags |>> ADDPART_FLAG_WHOLEDISK;
>> +			}
>>  		}
>
> It seems that you say that what was a single byte earlier is a __be16 now.
> That is nice and well, but your code only works in the new case,
> that is, may break all systems that work today.
> What about testing vtoc.sanity, and if this has the right value do
> the new things, and otherwise the old things?
>
> Andries
>
