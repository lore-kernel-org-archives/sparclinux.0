From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 07 Dec 2004 06:00:47 +0000
Subject: Re: mmap breakage
Message-Id: <Pine.LNX.4.61.0412070019140.10827@bobcat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-302163823-1102399247=:10827"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-302163823-1102399247=:10827
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Jakub,

On the sparclinux@vger list we have been recently discussing an issue of 
ld-linux.so.2 failing with SIGILL when executed directly with the 
executable name as an argument [0]. This problem was traced to the mmap 
call overwriting portions of ld-linux.so.2 itself. Insight provided by 
glibc people [1] helped to determine that on sparc64 the ld-linux.so.2 
is mapped at 0x08000000, leaving just 128MB for the executable. David 
Miller wrote on the subject of placing it at an alternative location [2]:

> We could put ld-linux.so.2 somewhere else, that's not too hard.  I
> would suggest putting it at that 0xfffff80000000000 address I quoted
> above since that is where the rest of the shared objects are going
> to end up anyways.

I presume that the value above is acceptable for 64-bit systems, but 
since Debian still uses (mostly) 32-bit userspace, I believe that the 
location must be below 4GB boundary. After digging a bit more through the 
code, I've found the following in include/asm-sparc64/elf.h:

/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */

#ifndef ELF_ET_DYN_BASE
#define ELF_ET_DYN_BASE         0x0000010000000000UL
#endif

This appears to be exactly the parameter I've been looking for. However, 
this is the default 64-bit value, for the 32-bit binaries it is redefined 
in arch/sparc64/kernel/binfmt_elf32.c:

#define ELF_ET_DYN_BASE         0x08000000

Since on i386 this is actually set to 0x80000000, I don't see why it 
should be different here. I have built a modified kernel (trivial patch is 
attached) and it seems to work fine. According to /proc/<pid>/maps 
ld-linux.so.2 is now mapped at 0x80000000 and I cannot reproduce the 
SIGILL using the old test case. Since you are an expert in this, could 
you please tell whether it makes sense to you? In particular, is the 
described change enough to remedy the problem, or is there something 
else we need to consider?

[0] http://marc.theaimsgroup.com/?t=110213793300001&r=1&w=2
[1] http://lists.debian.org/debian-glibc/2004/12/msg00060.html
[2] http://marc.theaimsgroup.com/?l=linux-sparc&m=110231073304789&w=2

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
--8323328-302163823-1102399247=:10827
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ldbase-2.6.8.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="ldbase-2.6.8.patch"

LS0tIGJ1aWxkLXNwYXJjNjQub3JpZy9hcmNoL3NwYXJjNjQva2VybmVsL2Jp
bmZtdF9lbGYzMi5jCTIwMDQtMDgtMTQgMDE6Mzc6NDAuMDAwMDAwMDAwIC0w
NDAwDQorKysgYnVpbGQtc3BhcmM2NC9hcmNoL3NwYXJjNjQva2VybmVsL2Jp
bmZtdF9lbGYzMi5jCTIwMDQtMTItMDYgMjA6MDk6NDcuMDAwMDAwMDAwIC0w
NTAwDQpAQCAtNzksNyArNzksNyBAQA0KIA0KICNkZWZpbmUgZWxmX2NoZWNr
X2FyY2goeCkJKCgoeCktPmVfbWFjaGluZSA9PSBFTV9TUEFSQykgfHwgKCh4
KS0+ZV9tYWNoaW5lID09IEVNX1NQQVJDMzJQTFVTKSkNCiANCi0jZGVmaW5l
IEVMRl9FVF9EWU5fQkFTRSAgICAgICAgIDB4MDgwMDAwMDANCisjZGVmaW5l
IEVMRl9FVF9EWU5fQkFTRSAgICAgICAgIDB4ODAwMDAwMDANCiANCiANCiAj
aW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5oPg0K

--8323328-302163823-1102399247=:10827--
