From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <mt1@systella.fr>
Date: Wed, 10 May 2006 08:24:55 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <4461A357.5030705@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello,

Jurij Smakov a =E9crit :
> On Tue, 9 May 2006, David S. Miller wrote:
>=20
>> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
>> Date: Tue, 9 May 2006 22:27:22 +0100
>>
>>> Sadly, no. I can try to do some of the easier things, but fixing
>>> something like the esp driver without the esp&dma datasheets is
>>> beyond me I'm afraid :).
>>
>>
>> http://en.wikipedia.org/wiki/NCR_53C9x
>>
>> The DMA programming manual is really not that necessary to
>> understand the chip.
>=20
>=20
> I've poked at this issue a little bit, without diving too deep. I've=20
> looked at the changes of the esp.c in the git kernel tree. There is one=20
> fairly recent change on 2006-02-22 [0], earlier changes are at least a=20
> year old. The diff for that commit is the following:
>=20
> --- a/drivers/scsi/esp.c
> +++ b/drivers/scsi/esp.c
> @@ -2068,14 +2068,12 @@ static int esp_reset(struct scsi_cmnd *S
>  {
>      struct esp *esp =3D (struct esp *) SCptr->device->host->hostdata;
>=20
> +    spin_lock_irq(esp->ehost->host_lock);
>      (void) esp_do_resetbus(esp);
> -
>      spin_unlock_irq(esp->ehost->host_lock);
>=20
>      wait_event(esp->reset_queue, (esp->resetting_bus =3D 0));
>=20
> -    spin_lock_irq(esp->ehost->host_lock);
> -
>      return SUCCESS;
>  }
>=20
> I have not nearly enough knowledge to tell whether that is correct, but=20
> the fact that in the previous version the function is left with the lock =

> held and in the new one - without it, struck me as suspicious. I've=20
> tried reverting this change and the 2.6.16 kernel started working much=20
> more reliably for me, I haven't seen a DMA error with it yet.

	I have built a regular 2.6.16.10 and I have verified that this patch=20
was applied. Kernel was built with debian gcc-4.0.3.

Configuration :
- dual SuperSPARC-II/75 (ony one is used) ;
- 448 MB
- 4 MB VSIMM
- two 36 GB SCA/SCSI disks (Raid1)
- internal CDROM
- floppy

> Unfortunately, other people who tested it (including Martin) reported=20
> that reverting this patch (or including it, if it was not present in the =

> kernel) had little or no effect.

	I have tested without any success.

> Dave, it would be great that if you=20
> could confirm that this patch actually does what it's supposed to do,=20
> that would be a significant indication that the problem is not in esp.c.

	I'm not sure that the trouble come from esp.c but from the DMA=20
subsystem. I have played with another SS20 and a lot of configurations :
- HyperSPARC + 512 MB -> DMA error within boot process, unusable;
- HyperSPARC + 192 MB (no HIGHMEM) -> DMA error (quickly), unusable;
- HyperSPARC + 128 MB (banks 0 and 1, no HIGHMEM) -> usable, frequency=20
of DMA error is the same than with SuperSPARC-II.

	I think that the bug is between the cache and the DMA subsystem. I=20
don't understand why I obtain the same DMA error on my U1 (EPSFAS) and=20
not on my U1E (EPSHME). If I have time, I shall test with a SS5=20
(MicroSPARC-II) to see if the trouble come from cache or from DMA.

> I've recently built 2.6.16 and 2.6.17-rc3 kernels with Debian's gcc=20
> 4.0.3-2, and they boot. Modules load fine. There is some kind of issue=20
> with the network, loading sunlance on my SS20 does not work every time.

	I have never seen this trouble. Do you know if the SMP-support is=20
improved ? The last patch I have tested come from Bob Breuer and is=20
against 1.6.17-rc1...

	Regards,

	JKB

