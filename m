From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 18 Jan 2007 21:21:56 +0000
Subject: Re: IRQ routing(?) problem on Enterprise 450 with Areca SATA RAID
Message-Id: <45AFE4F4.10801@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20070102140325.GB11095@wopr.homeunix.org>
In-Reply-To: <20070102140325.GB11095@wopr.homeunix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Eki napsal(a):
> On Tue, Jan 02, 2007 at 04:03:25PM +0200, Eki wrote:
> 
>>Hi!
>>
>>It seems that 2.6.17 (or -stable 2.6.17.14) is the last working
>>kernel with E450, using Areca SATA RAID controller.
>>
>>I tested a lot of newer kernel versions, 2.6.18, 2.6.19, some -rc's,
>>and the latest sparc-2.6 git tree as of 30th december, but none of them
>>will work correctly:
>>
>> [root@e450] [~] # uname -r
>> 2.6.20-rc2-davem-061230
>>
>> [root@e450] [~] # modprobe arcmsr
>> ARECA RAID ADAPTER2: FIRMWARE VERSION V1.42 2006-10-13
>> scsi2 : Areca SATA Host Adapter RAID Controller( RAID6 capable)
>> Driver Version 1.20.00.13
>> arcmsr2: abort device command of scsi id=0 lun=0
>> arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840000' poll command abort successfully
>> arcmsr2: abort device command of scsi id=0 lun=0
>> arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840240' poll command abort successfully
>> arcmsr2: abort device command of scsi id=0 lun=0
>> arcmsr2: scsi id=0 lun=0 ccb='0xfffff800fc840480' poll command abort successfully
>> scsi 2:0:0:0: scsi: Device offlined - not ready after error recovery
>> arcmsr2: abort device command of scsi id=1 lun=0
>> arcmsr2: scsi id=1 lun=0 ccb='0xfffff800fc8406c0' poll command abort successfully
>> arcmsr2: abort device command of scsi id=1 lun=0
>> arcmsr2: scsi id=1 lun=0 ccb='0xfffff800fc840900' poll command abort successfully
>>
>>I found this thread from August, which seems to describe the same
>>problem I'm experiencing:
>>
>>http://www.spinics.net/lists/sparclinux/msg00458.html
>>
>>I've done as David S. Miller suggested, and booted the kernel with
>>"ofdebug=2"
>>
>>I've attached "prtconf -lv" from a working 2.6.17.14 and non-working
>>2.6.20-rc2 kernels.
>>
>>Anybody have any idea what's going on?
>>
>>Thanks,
>>
>>Eki
> 
> 
> Hello,
> 
> Haven't seen any response on this issue yet. Doesn't anybody else have
> similar problems with PCI-X cards on E450?

I have similar problem with E1000 external  SCSI box attached to NCR PCI 
SCSI controller. With older kernel work but with newer stop working. May 
be problem is in SCSI layer not PCI-X specific.


			Dan


