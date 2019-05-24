From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 24 May 2019 18:51:33 +0000
Subject: Re: Making MAX_PHYS_ADDRESS_BITS configurable
Message-Id: <dcae8f67-9577-4f97-8a79-b82a952567b5@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <2be3335c-1870-9867-0f25-01cf798ca84b@physik.fu-berlin.de>
In-Reply-To: <2be3335c-1870-9867-0f25-01cf798ca84b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 5/24/19 6:20 PM, David Miller wrote:
>> On the other hand, arm64 currently allows the virtual address size
>> to be configurable, currently defaulting to 48 bits [2, 3]. I was
>> therefore wondering whether we could make MAX_PHYS_ADDRESS_BITS [4]
>> configurable as well to be able to support these JITs on
>> Debian/sparc64 for the foreseeable future by limiting the virtual
>> address space to 47 or 48 bits.
> 
> You can't just do this.
> 
> It is possible that all physical memory is mapped to the top of the
> mappable physical address range, therefore we really need to use the
> full maximum setting supported by the CPU.

Yes, my initial mail was incorrect. What I actually meant was reducing
the size of the va_hole in userspace so that the top-most address that
mmap() would return is not beyond 2^47.

Would it be possible to add such a workaround until the JITs have fixed
their broken code?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
