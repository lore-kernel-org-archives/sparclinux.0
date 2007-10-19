From: =?UTF-8?B?QkVSVFJBTkQgSm/Dq2w=?= <joel.bertrand@systella.fr>
Date: Fri, 19 Oct 2007 16:03:00 +0000
Subject: Re: [BUG] Raid5 trouble
Message-Id: <4718D534.4030503@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <47161CE3.80909@systella.fr>	 <e9c3a7c20710170758p4046ca44labe370e94bca6e93@mail.gmail.com>	 <e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>	 <47181CB2.1060602@tmr.com>  <471864F8.9010209@systella.fr> <1192809103.30976.11.camel@dwillia2-linux.ch.intel.com>
In-Reply-To: <1192809103.30976.11.camel@dwillia2-linux.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org

Dan Williams wrote:
> On Fri, 2007-10-19 at 01:04 -0700, BERTRAND Joël wrote:
>>         I never see any oops with this patch. But I cannot create a
>> RAID1 array
>> with a local RAID5 volume and a foreign RAID5 array exported by iSCSI.
>> iSCSI seems to works fine, but RAID1 creation randomly aborts due to a
>> unknown SCSI task on target side.
> 
> For now I am going to forward this patch to Neil for inclusion in
> -stable and 2.6.24-rc.  I will add a "Tested-by: Joël Bertrand
> <joel.bertrand@systella.fr>" unless you have an objection.

	No objection.

>>         I run for 12 hours some dd's (read and write in nullio)
>> between initiator and target without any disconnection. Thus iSCSI code seems
>> to be robust. Both initiator and target are alone on a single gigabit
>> ethernet link (without any switch). I'm investigating...
> 
> Can you reproduce on 2.6.22?

	I cannot downgrade these servers on 2.6.22 due to a bug in FUTEX code.

> Also, I do not think this is the cause of your failure, but you have
> CONFIG_DMA_ENGINE=y in your config.  Setting this to 'n' will compile
> out the unneeded checks for offload engines in async_memcpy and
> async_xor.

	I will try...

	Regards,

	JKB
