From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 04 Jun 2017 13:16:33 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170602091717.GA7452@physik.fu-berlin.de>
 <20170602.102259.363059784928463769.davem@davemloft.net>
 <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
 <20170602.132809.1754806777743128355.davem@davemloft.net>
In-Reply-To: <20170602.132809.1754806777743128355.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 06/02/2017 07:28 PM, David Miller wrote:
>> Isn't a bug in the kernel if an application is able to crash to the point
>> that the machine has to be hard-rebooted?
> 
> It can be a bug in the compiler too and not necessarily the kernel's
> fault which is what I think is happening in your case.

So, in your point of view it's perfectly fine if an application is able
to crash the whole kernel with just user privileges?

Shouldn't the kernel be able to cope with that?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
