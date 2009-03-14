From: Brian Thompson <brian@eng.wayne.edu>
Date: Sat, 14 Mar 2009 00:01:10 +0000
Subject: Re: dmfe/tulip kernel module poll
Message-Id: <49BAF3C6.4050505@eng.wayne.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090126094911.GA2936@orion.carnet.hr>
In-Reply-To: <20090126094911.GA2936@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



David Miller wrote:
> From: Brian Thompson <brian@eng.wayne.edu>
> Date: Fri, 13 Mar 2009 19:25:48 -0400
>
>   
>> David Miller wrote:
>>     
>>> From: Josip Rodin <joy@entuzijast.net>
>>> Date: Mon, 26 Jan 2009 10:49:11 +0100
>>>
>>>   
>>>       
>>>> I'm just Cc:'ing this to the sparc kernel mailing list...
>>>>
>>>> On Sun, Jan 25, 2009 at 08:21:56PM -0500, Brian Thompson wrote:
>>>>     
>>>>         
>>>>> I'd like to get some feedback as to whether anyone is actually using
>>>>> the dmfe Davicom kernel module on sparc for 10/100 ethernet.
>>>>>
>>>>> To the best of my knowledge, Sun never manufactured any
>>>>> expansion cards that utilize the Davicom chip and the UltraAX-i2
>>>>> motherboard (Netra X1 and Sunfire V100) is the only Sun
>>>>> motherboard that uses the chip. That particular motherboard
>>>>> uses the tulip kernel module though, not the dmfe kernel module.
>>>>>
>>>>> Since the PCI ID of the UltraAX-i2's onboard ethernet
>>>>> (1282:9102 - Davicom 9102) matches up with both the dmfe
>>>>> module and the tulip module, both modules attempt to load and
>>>>> end up causing the network interface to malfunction.
>>>>>
>>>>> My question is - is anyone actually using the dmfe kernel module
>>>>> on sparc and/or would it be ok to set the default to not build the
>>>>> dmfe kernel module on sparc?
>>>>>
>>>>> I presume that the only scenario where anyone would actually be
>>>>> using the dmfe kernel module on sparc would be if they've installed
>>>>> a PCI NIC originally intended for x86 machines into their sparc
>>>>> machine.
>>>>>       
>>>>>           
>>> Better would be to simply remove the conflicting device IDs
>>> from the dmfe driver.
>>>
>>>   
>>>       
>> Something like the following in dmfe.c? I can test it if it makes sense to do so.
>>     
>
> I mean unconditionally, if all of the IDs are covered by tulip we
> should delete the dmfe driver.
>
>   

The dmfe driver covers a total of four PCI IDs, two of which are also
covered by tulip and the other two unique to dmfe.

If I understand the issue correctly though, there are situations outside
of sparc (DEC Alpha?) where dmfe is the preferred/proper driver
for one or both of the IDs that overlap, but I can't say first hand.


