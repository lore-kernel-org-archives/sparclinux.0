From: Steven Dake <sdake@redhat.com>
Date: Thu, 02 Jun 2011 21:53:58 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <4DE80676.6070200@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/02/2011 02:27 PM, David Miller wrote:
> From: Steven Dake <sdake@redhat.com>
> Date: Wed, 01 Jun 2011 02:37:04 -0700
> 
>> Thanks for the response.  For those searching for this problem in the
>> future, We tried 16384, and then decided to have a look at the kernel
>> source tree and came up with some speculation that the hugetlb settings
>> would result in EINVAL via prepare_hugetlb.  The minimum page we could
>> execute this operation on was 4MB.  I notice on some other arches this
>> is not required.
> 
> Requiring 4MB is not kosher, it shouldn't be asking you to do that
> much.
> 
> Where is this prepare_hugetlb() function in the kernel?  I cannot
> find it.
> 
> Also, please prepare a test case for me, I want to fix this.
> 
> Thanks.


Dave,

Sorry for the noise.  We did not require 4MB regions, as I had
originally stated.  Unfortunately I just got access to hardware today to
test (was relying on community hardware testers previously).  I have
prepared a patch which fixes the problem in our software.  x86_64
behaves differently (works) then sparc64.

In summary we were doing the following:

1.
creating a nonwrapping mmap as follows:
        addr_orig = mmap (NULL, bytes, PROT_NONE,
                MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

        if (addr_orig = MAP_FAILED) {
                goto error_close_unlink;
        }

        addr = mmap (addr_orig, bytes, PROT_READ | PROT_WRITE,
                MAP_FIXED | MAP_SHARED, fd, 0);

^^ clearly dubious

2.
further creations of circular memory maps caused all sorts of problems
on sparc but not on x86_64.

This resulted in later circular memory maps we wanted to create having
to be 4MB in size to work properly.  I can't explain why.

I changed the mmap operation in 1 to do the following:
        addr = mmap (NULL, bytes, PROT_READ | PROT_WRITE,
                MAP_SHARED, fd, 0);

This allows our software to function properly.

I've cc'ed Angus who is working on a new implementation of this ring
buffer in a different project (www.libqb.org) who found the 4MB sizes
resulted in the software working.  He is investigating introducing the
change I stated into his code to see if this also works on sparc.

He can follow up with you if he runs into further problems.

Regards
-steve
