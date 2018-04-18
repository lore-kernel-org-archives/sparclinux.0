From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Wed, 18 Apr 2018 20:03:37 +0000
Subject: Re: [PATCH 2/2] selftests: sparc64: char: Selftest for privileged ADI driver
Message-Id: <a44ead3d-8565-2d44-5a28-dfc51d4920d9@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180418162958.442909-1-tom.hromatka@oracle.com>
 <20180418162958.442909-3-tom.hromatka@oracle.com>
 <6ef81e28-7656-ccf5-5d4d-ef315ae250ce@kernel.org>
In-Reply-To: <6ef81e28-7656-ccf5-5d4d-ef315ae250ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 04/18/2018 01:58 PM, Shuah Khan wrote:
> Hi Tom,
>
> On 04/18/2018 10:29 AM, Tom Hromatka wrote:
>> Add a selftest for the sparc64 privileged ADI driver.  These
>> tests verify the read(), pread(), write(), pwrite(), and seek()
>> functionality of the driver.  The tests also report simple
>> performance statistics:
>>
>>          Syscall Call    AvgTime AvgSize
>>                  Count   (ticks) (bytes)
>>          -------------------------------
>>          read          3  167134    8133
>>          pread         4  137217    6741
>>          write         3   73787    8133
>>          pwrite        4   65832    6741
>>          seek         10    2422       0
>>
>>          Ran 8 tests
>>          All tests passed
>>
>> Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
>> Reviewed-by: Allen Pais <allen.pais@oracle.com>
> Thanks for the patch. A few comments below:

Thanks for the quick turnaround, Shuah.=C2=A0 I'll work through your
comments and get a v2 out in the next few days.

Regards.

Tom



