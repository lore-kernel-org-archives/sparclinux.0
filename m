From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Sat, 12 Aug 2017 02:50:36 +0000
Subject: Re: [PATCH 2/3] sparc64: Add 16GB hugepage support
Message-Id: <15a11c95-f4b2-3304-186d-de8d64396ba7@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/11/17 5:28 PM, Xose Vazquez Perez wrote:
> Nitin Gupta wrote:
> 
>> On 07/20/2017 01:04 PM, David Miller wrote:
>>> From: Nitin Gupta <nitin.m.gupta@oracle.com>
>>> Date: Thu, 13 Jul 2017 14:53:24 -0700
>>>
>>>> Testing:
>>>>
>>>> Tested with the stream benchmark which allocates 48G of
>>>> arrays backed by 16G hugepages and does RW operation on
>>>> them in parallel.
>>>
>>> It would be great if we started adding tests under
>>> tools/testing/selftests so that other people can recreate
>>> your tests/benchmarks.
>>>
>>
>> Yes, I would like to add the stream benchmark to selftests too.
>> I will check if our internal version of stream can be released.
> 
> STREAM's $HOME is at: https://www.cs.virginia.edu/stream/
> C and Fortran implementations: https://www.cs.virginia.edu/stream/FTP/Code/

Looking at:
https://www.cs.virginia.edu/stream/FTP/Code/stream.c

I see that arrays are statically allocated. To be useful for hugepage
testing, it should probably be converted to use malloc/mmap for these
array allocations.  This is a small easy change.  However, I'm not sure
if publication restrictions (see Item 3 in source header) would be
acceptable to the Linux kernel which is a call that I can't make.

Nitin


