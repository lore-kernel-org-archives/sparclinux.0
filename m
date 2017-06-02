From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2017 17:28:09 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170602.132809.1754806777743128355.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602091717.GA7452@physik.fu-berlin.de>
        <20170602.102259.363059784928463769.davem@davemloft.net>
        <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
In-Reply-To: <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 2 Jun 2017 18:33:45 +0200

> On 06/02/2017 04:22 PM, David Miller wrote:
>>> What remains to be fixed though is that the gcc-7 testsuite
>>> *reproducibly* kills the kernel on sparc64 when building with more than
>>> around 20 jobs:
>> 
>> Well, I already have a release gcc bug to fix so pretty much I have no
>> time to look into bugs in unreleased versions of gcc sorry.
> 
> Isn't a bug in the kernel if an application is able to crash to the point
> that the machine has to be hard-rebooted?

It can be a bug in the compiler too and not necessarily the kernel's
fault which is what I think is happening in your case.
