From: Marcel van Nies <morcles@gmail.com>
Date: Sat, 05 Mar 2011 14:49:08 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTinv1xMxCTFESxOnemC9bhTi0ciVU6S+VtThSdE6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Sam,

> The patchset will likely not see testing on:
> -  Javastation (the pcic changes)
> - sun4m with multiple CPUs
> - sun4c
>
> I have checked the nearby ebay's for relevant boxes - no luck.
> On the other hand there is also a limit for the size of
> my SUN museum :-)

I've got a small "SUN museum" ...
sun4c: SPARCstation IPX
sun4m: SPARCstation5 (microSPARC II)
sun4m: SPARCstation20 (two-way superSPARC II)
sun4m: SPARCstation20 (four-way hyperSPARC Colorado-3)

Never got the IPX running on 2.6, but the others are spinning just
fine on some 2.6.1x UP (x=3Dlow).
I'm looking forward to give your patchset a try.

Best,
M


On Sat, Mar 5, 2011 at 2:32 PM,  <crn@netunix.com> wrote:
>
>
> On Sat, 5 Mar 2011, Kjetil Oftedal wrote:
>>
>> Hi,
>>
>> With regards to testing on sun4d, I have run into problems with the
>> existing kernel, during the process of getting a test system up and
>> running. The system is unable to mount partitions correctly,
>> (both ext2 on a hdd, and iso8859 on a cdrom), however dd, running from an
>> initrd filesystem is able to read the ext2 blocks correctly. So I have
>> started investigating this instead.
>>
>> Is there anyone aware of any alignment requirements in the sun4d on DMA
>> transfers and such ? Or have the datasheet for the FAS2x6 (236) scsi
>> controllers ?
>
> First check that you can see the drive correctly from the OBP
> ok> probe-scsi-all
>
> If that is OK try booting with no SMP, I forget the correct incantation
> but something like "max-cpus=3D1" sounds familiar.
>
> You could also try booting with a 2.2.x kernel, if that does not work
> something is SERIOUSLY wrong. 2.2.x does not support SMP and has
> always booted OK for me.
>
> Do you have Solaris, it should boot and run 2.6, 7, or 8 (last supported).
> If this fails you certainly have hardware issues.
>
> Sorry to be vague, there has been no properly working Sun4d kernel
> since 2.2.x so expect to find bitrot in all sorts of obscure places.
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
