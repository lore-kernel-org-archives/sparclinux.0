From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 04 Jun 2017 20:33:21 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <374faa2d-3a77-3a8e-e214-9d635a1f2ec0@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
 <20170604.162150.706660537991026056.davem@davemloft.net>
 <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
 <20170604.163042.2037487368752934309.davem@davemloft.net>
In-Reply-To: <20170604.163042.2037487368752934309.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 06/04/2017 10:30 PM, David Miller wrote:
> All of my testing is being done with gcc-6.3 vanilla and current
> kernels, and in fact I'm doing parallel "make -j128" gcc and glibc
> testsuite runs and not hitting any problems at all.

Did you try to build and run the gcc-7 testsuite? Because we don't
see this with the gcc-6 testsuite.

The environment is a clean Debian unstable sparc64 chroot with glibc-2.24
and gcc-6.3.0.

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
