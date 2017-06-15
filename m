From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 15:43:15 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <284da256-87d7-91d2-5cc5-4b3b56207f51@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 06/15/2017 11:20 AM, Guenter Roeck wrote:
> On Thu, Jun 15, 2017 at 10:40:57AM -0400, Pavel Tatashin wrote:
>> Guenter Roeck reported a problem that was introduced by early boot
>> timestamp changes. Where: tick_get_frequency() returns 0.
>>
>> Guenter Roeck: could you please test if these patches fix the issue?
>>
> My tests pass with those patches applied, so
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> My current sparc64 tests are
> 
> sparc64_defconfig sun4u "TI UltraSparc IIi"
> sparc64_defconfig sun4v "Fujitsu Sparc64 IV"
> 
> with both SMP and non-SMP configuration variants.
> 
> Do you happen know which CPU variants supported by qemu would test
> all affected code branches ? Or, in other words, what would be
> an optimal combination of CPU / machine type to test ?

Hi Guenter,

I have not used qemu for SPARC, so I am not fully aware of its 
capability. The changes in this work touched three types of CPUs:

1. UltraSPARC IIe (Hummingbird)
	- %stick is in I/O space, need at least to loads to get upper
	  and lower part of stick value.
2. Spitfire
	- Use %tick and cpu frequency to determine that clock. This is
	 what you tested with TI UltraSparc IIi
3. All other
	- use %stick register and stick-frequency values. This is what
	you tested with Fujitsu Sparc64 IV (which by the way is still
	sun4u, I do not think qemu supports sun4v emulation)

Thank you,
Pasha
