From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2017 20:34:22 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170604.163422.1495211552291226243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
        <20170604.163042.2037487368752934309.davem@davemloft.net>
        <374faa2d-3a77-3a8e-e214-9d635a1f2ec0@physik.fu-berlin.de>
In-Reply-To: <374faa2d-3a77-3a8e-e214-9d635a1f2ec0@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 4 Jun 2017 22:33:21 +0200

> On 06/04/2017 10:30 PM, David Miller wrote:
>> All of my testing is being done with gcc-6.3 vanilla and current
>> kernels, and in fact I'm doing parallel "make -j128" gcc and glibc
>> testsuite runs and not hitting any problems at all.
> 
> Did you try to build and run the gcc-7 testsuite? Because we don't
> see this with the gcc-6 testsuite.
> 
> The environment is a clean Debian unstable sparc64 chroot with glibc-2.24
> and gcc-6.3.0.

I'm currently running the testsuite with gcc mainline.

Please post your sparc64 system specs.
