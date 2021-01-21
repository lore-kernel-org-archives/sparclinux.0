From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 21 Jan 2021 08:03:35 +0000
Subject: Re: soft lockups on T5120
Message-Id: <63c23957-cfb0-ecdb-babf-31fe19c0661f@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
In-Reply-To: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Rolf!

On 1/21/21 8:23 AM, Rolf Eike Beer wrote:
>> The kernel currently is 5.10.3, but I hit this for quite a while
>>
>> Here is what came out of dmesg today. I found no signs of trouble
>> earlier than this:
> 
> And here it is again:
> (...)

Anatoly found a reproducer for this bug [1]. So it might be an idea to bisect
the issue with the help of the reproducer.

Adrian

> [1] https://marc.info/?l=linux-sparc&m0967865029609&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
