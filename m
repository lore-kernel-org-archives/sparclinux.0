From: David Ahern <david.ahern@oracle.com>
Date: Thu, 23 Apr 2015 00:29:12 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <55383CD8.6050102@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090601010900080404090604"
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601010900080404090604
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/15 5:25 PM, David Miller wrote:
> From: David Ahern <david.ahern@oracle.com>
> Date: Wed, 22 Apr 2015 17:19:23 -0600
>
>> Only thing left in my queue is optimized versions of the ffs / fls
>> families, but that patch is v9b specific, not M7.
>
> Something faster than the popc thing in arch/sparc/lib/ffs.S?

hmmm... i saw that, but wasn't clear 1) how it got inserted and 2) the 
overhead of a function call versus inline. Anyways, what I have is the 
same 3 instructions as an inline. But really the __ffs was just along 
for the ride; the focus was on __fls.

>
> Are you thinking of using "lzcnt"?  I wasn't impressed with the
> performance of that instruction last time I played around with it.

A comparison of what I hacked together is attached (columns too wide for 
inline). Data is from a T4-2. It shows lzcnt to be better for __fls, fls 
and fl64.


>
>> I'd like to put some attention on precise mode for perf counters; it
>> just has not bubbled to the top.
>
> That plus the backtrace deadlock thing we're discussing in another
> thread, that bug is irritating because your pagefault_disable() change
> should "just work".
>

oh, yes. forgot about that one. I spent too many hours trying to figure 
out why processes get killed with a sigbus. I added an option to perf 
tool to skip userspace chains until I can get back to it.



--------------090601010900080404090604
Content-Type: text/plain; charset=UTF-8;
 name="fls-cmp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fls-cmp.txt"

- "slow" means version from asm-generic.
- Times are in nsec.
- 'bit' column shown to ensure correct answer between current and lzcnt
- average of 10 back-to-back calls


                 |        __fls        |         fls         |      fls64
            word |  lzcnt       slow   |  lzcnt       slow   |  lzcnt     slow
                 | bit   dt   bit   dt | bit   dt   bit   dt | bit   dt   bit   dt
               0 |   0   15     0   67 |   0   19     0   21 |   0   14     0   14
               1 |   0   13     0   50 |   1   32     1   61 |   1   20     1   51
        80000000 |  31   13    31   39 |  32   30    32   49 |  64   25    64   37
8000000000000000 |  63   13    63   34 |   0   17     0   16 |   0   12     0   14

--------------090601010900080404090604--
