From: Ben Collins <bcollins@debian.org>
Date: Tue, 15 Feb 2005 03:40:48 +0000
Subject: Re: size-differences of long(userspace) / long(kernel)
Message-Id: <20050215034048.GE6838@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

32-bit applications communicating with the kernel using standard calls
like ioctl() pass through a translation layer that converts the 32-bit
information into 64-bit counterparts, processes them, and converts them
back again before passing them back to userspace.

This is pretty common in sparc64, x86-64, ppc64, mips64, ia64, etc.

When binaries on sparc64 are compiled as 64-bit, the translation layer is
not used, and native calls take place within the kernel.

On Mon, Feb 14, 2005 at 04:56:13PM +0100, Michael Tautschnig wrote:
> Hello!
> 
> Is there any generic way in situations, where (pointers 
> to) structs are transferred from user- to kernelspace and vice versa? 
> Any struct containing a long int or a pointer will have a different 
> size in kernel space! This usually happens when doing ioctls ...
> 
> I'm not sure, whether it causes any troubles, but, e.g., ifreq contains 
> another struct (ifmap) that in turn contains long ints . Thus the size of 
> ifreq is 32 byte in userspace and 40 byte in kernelspace. If an 
> application reserves sizeof(ifreq) bytes, then lets the kernel initialize 
> the struct, which in turn copies it back to userspace - and thus might 
> overwrite 8bytes that were not reserved for that struct ... Oops :-)
> 
> Any thoughts?
> 
> Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
