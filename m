From: =?UTF-8?B?QkVSVFJBTkQgSm/Dq2w=?= <joel.bertrand@systella.fr>
Date: Fri, 19 Oct 2007 21:04:15 +0000
Subject: Re: [BUG] Raid1/5 over iSCSI trouble
Message-Id: <47191BCF.2000908@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <47161CE3.80909@systella.fr>	
	<e9c3a7c20710170758p4046ca44labe370e94bca6e93@mail.gmail.com>	
	<e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>	
	<47181CB2.1060602@tmr.com> <471864F8.9010209@systella.fr>
	<1192809103.30976.11.camel@dwillia2-linux.ch.intel.com>
	<4718DE66.8000905@tmr.com> <471916B5.6080709@systella.fr>
	<47191855.4020402@systella.fr>
In-Reply-To: <47191855.4020402@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, iscsitarget-devel@lists.sourceforge.net

BERTRAND Joël wrote:
> BERTRAND Joël wrote:
>> Bill Davidsen wrote:
>>> Dan Williams wrote:
>>>> On Fri, 2007-10-19 at 01:04 -0700, BERTRAND Joël wrote:
>>>>  
>>>>>         I run for 12 hours some dd's (read and write in nullio)
>>>>> between
>>>>> initiator and target without any disconnection. Thus iSCSI code seems
>>>>> to
>>>>> be robust. Both initiator and target are alone on a single gigabit
>>>>> ethernet link (without any switch). I'm investigating...
>>>>>     
>>>>
>>>> Can you reproduce on 2.6.22?
>>>>
>>>> Also, I do not think this is the cause of your failure, but you have
>>>> CONFIG_DMA_ENGINE=y in your config.  Setting this to 'n' will compile
>>>> out the unneeded checks for offload engines in async_memcpy and
>>>> async_xor.
>>>
>>> Given that offload engines are far less tested code, I think this is 
>>> a very good thing to try!
>>
>>     I'm trying wihtout CONFIG_DMA_ENGINE=y. istd1 only uses 40% of one 
>> CPU when I rebuild my raid1 array. 1% of this array was now 
>> resynchronized without any hang.
>>
>> Root gershwin:[/usr/scripts] > cat /proc/mdstat
>> Personalities : [raid1] [raid6] [raid5] [raid4]
>> md7 : active raid1 sdi1[2] md_d0p1[0]
>>       1464725632 blocks [2/1] [U_]
>>       [>....................]  recovery =  1.0% (15705536/1464725632) 
>> finish03.9min speed!875K/sec
> 
>     Same result...
> 
> connection2:0: iscsi: detected conn error (1011)
> 
>          session2: iscsi: session recovery timed out after 120 secs
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 4:0:0:0: scsi: Device offlined - not ready after error recovery

	Sorry for this last mail. I have found another mistake, but I don't 
know if this bug comes from iscsi-target or raid5 itself. iSCSI target 
is disconnected because istd1 and md_d0_raid5 kernel threads use 100% of 
CPU each !

Tasks: 235 total,   6 running, 227 sleeping,   0 stopped,   2 zombie
Cpu(s):  0.1%us, 12.5%sy,  0.0%ni, 87.4%id,  0.0%wa,  0.0%hi,  0.0%si, 
0.0%st
Mem:   4139032k total,   218424k used,  3920608k free,    10136k buffers
Swap:  7815536k total,        0k used,  7815536k free,    64808k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND 

  5824 root      15  -5     0    0    0 R  100  0.0  10:34.25 istd1 

  5599 root      15  -5     0    0    0 R  100  0.0   7:25.43 
md_d0_raid5

	Regards,

	JKB
