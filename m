From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 12:23:09 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <0b7e33a6-7cf0-8c82-709e-d70c28bf2be9@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 15/06/17 22:36, Guenter Roeck wrote:

> On Thu, Jun 15, 2017 at 06:57:30PM +0100, Mark Cave-Ayland wrote:
>> On 15/06/17 16:43, Pasha Tatashin wrote:
>>
>>> I have not used qemu for SPARC, so I am not fully aware of its
>>> capability. The changes in this work touched three types of CPUs:
>>
>> The default CPU in QEMU for sun4u is the TI UltraSparc IIi, and the
>> device tree is roughly similar to that of an Ultra 5, or it least it
>> will be soon when I've finished working on my latest round of patches.
>>
>> Currently I'm booting one of John Paul Adrian Glaubitz's Debian 9 images
>> and the timestamps stay at 0 until the clock is initialised so I'd hope
>> that these patches would fix that. Do they require any PROM support at all?
>>
>>> 1. UltraSPARC IIe (Hummingbird)
>>>     - %stick is in I/O space, need at least to loads to get upper
>>>       and lower part of stick value.
>>> 2. Spitfire
>>>     - Use %tick and cpu frequency to determine that clock. This is
>>>      what you tested with TI UltraSparc IIi
>>
>> So this is the path I'd expect to be exercised under QEMU.
>>
>>> 3. All other
>>>     - use %stick register and stick-frequency values. This is what
>>>     you tested with Fujitsu Sparc64 IV (which by the way is still
>>>     sun4u, I do not think qemu supports sun4v emulation)
>>
>> Sure it does. As of the latest 2.9 release, QEMU includes niagara
>> support out of the box - see http://wiki.qemu.org/SPARC for the latest
> 
> Do you have information on how to boot the Linux kernel for -M niagara 
> (assuming that is possible) ? Directions for Solaris and HelenOS don't
> help much for the uninitiated :-(.

I just pinged Artyom (who added sun4v support) about this and his
comment was that the machine files provided in the
OpenSPARCT1_Arch.1.5.tar.bz2 are hardcoded to 256MB which isn't enough
to boot many standard kernels. As I'm currently sun4u only then I'm not
the right person to ask about this - perhaps someone from Oracle can help?

If you are interested in pursuing this further, please head over and
introduce yourself on the qemu-devel list so we can all gather in one place.


ATB,

Mark.

