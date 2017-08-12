From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Date: Sat, 12 Aug 2017 00:28:43 +0000
Subject: Re: [PATCH 2/3] sparc64: Add 16GB hugepage support
Message-Id: <09ba52c3-85de-20ca-4f5a-05433b82401f@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Nitin Gupta wrote:

> On 07/20/2017 01:04 PM, David Miller wrote:
>> From: Nitin Gupta <nitin.m.gupta@oracle.com>
>> Date: Thu, 13 Jul 2017 14:53:24 -0700
>> 
>>> Testing:
>>>
>>> Tested with the stream benchmark which allocates 48G of
>>> arrays backed by 16G hugepages and does RW operation on
>>> them in parallel.
>> 
>> It would be great if we started adding tests under
>> tools/testing/selftests so that other people can recreate
>> your tests/benchmarks.
>> 
> 
> Yes, I would like to add the stream benchmark to selftests too.
> I will check if our internal version of stream can be released.

STREAM's $HOME is at: https://www.cs.virginia.edu/stream/
C and Fortran implementations: https://www.cs.virginia.edu/stream/FTP/Code/
